from __future__ import annotations

from ansible.plugins.strategy.linear import StrategyModule as LinearStrategy
from ansible.playbook.task import Task
from ansible.template import trust_as_template
from ansible.utils.display import Display

# from ansible.utils.unsafe_proxy import AnsibleUnsafeText


DOCUMENTATION = """
    name: etckeeper_linear
    short_description: linear strategy that runs etckeeper commit after changed tasks
    author: Michael Brade
"""

class StrategyModule(LinearStrategy):

    def __init__(self, tqm):
        super().__init__(tqm)
        self._etck_uuids = set()    # UUIDs of injected commit tasks
        self._etck_tasks = {}       # original task uuid -> injected Task
        self._etck_pc = None

    def run(self, iterator, play_context):
        self._etck_pc = play_context
        return super().run(iterator, play_context)

    def _process_pending_results(self, iterator, *args, **kwargs):
        results = super()._process_pending_results(iterator, *args, **kwargs)

        for res in results:
            task, host, utr = res.task, res.host, res.utr

            if task._uuid in self._etck_uuids:
                # our own commit task: never recurse, just log the task if something was committed
                if utr.changed and not utr.failed:
                    Display().display(f"[{host.name}] {task.name}")
                continue

            if task.action in ("meta", "include_tasks", "import_tasks", "include_role", "include_vars"):
                print("skip task due to action")
                continue
            if not utr.changed or utr.skipped:
                continue
            if task.delegate_to:
                print("TODO skip task: delegated")
                continue

            # this is to allow to disable this strategy's etckeeper commit
            if host.vars.get("etckeeper_autocommit", True) is False:
                continue

            self._queue_commit(iterator, host, task)

        return results

    def _queue_commit(self, iterator, host, orig_task):
        t = self._commit_task_for(orig_task)

        task_vars = self._variable_manager.get_vars(
            play=iterator._play,
            host=host,
            task=t,
            _hosts=self._hosts_cache,
            _hosts_all=self._hosts_cache_all,
        )
        self._queue_task(host, t, task_vars, self._etck_pc)


    def _commit_task_for(self, orig_task):
        t = self._etck_tasks.get(orig_task._uuid)
        if t is None:
            t = Task.load({
                "name": f"etckeeper commit after: {orig_task.get_name()}",
                "ansible.builtin.shell": {
                    "cmd": (
                        "command -v etckeeper >/dev/null 2>&1 && [ -d /etc/.git ] && etckeeper unclean || exit 0\n"
                        'etckeeper commit "$ETCK_MSG" && echo __etckeeper_committed__\n'
                    ),
                    "executable": "/bin/sh",
                },
                "environment": {"ETCK_MSG": orig_task.get_name()},
                "become": True,
                "register": "_etck",
                "changed_when": trust_as_template("'__etckeeper_committed__' in _etck.stdout"),
                "check_mode": False,
                "tags": ["always"],
            })
            t._parent = orig_task._parent   # so variable scoping resolves
            self._etck_uuids.add(t._uuid)
            self._etck_tasks[orig_task._uuid] = t
        return t