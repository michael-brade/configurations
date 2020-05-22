alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'


umask 022

export JAVA_TOOL_OPTIONS="-Djdk.disableLastUsageTracking=true"


## the shell history - share across sessions, avoid and erase all dupes

function save_last_history_cmd() {
    export LAST_HIST="$(history 1 | sed -r -e 's/^ *[0-9]+ {2}//')"
}

function restore_last_history_cmd() {
    history -s "$LAST_HIST"
    unset LAST_HIST
}


# record all history
HISTSIZE=-1
HISTFILESIZE=$HISTSIZE

# erase all dupes
shopt -s histappend
HISTCONTROL="ignoredups:erasedups"
PROMPT_COMMAND="save_last_history_cmd; history -n; history -w; history -c; history -r; restore_last_history_cmd; $PROMPT_COMMAND"

export HISTFILESIZE HISTSIZE HISTCONTROL HISTTIMEFORMAT

# manually erase dupes: (use only without timestamps!)
#   tac $HISTFILE | awk '!x[$0]++' | tac | sponge $HISTFILE


# less

export LESSCHARSET=utf-8
export LESS="-QRMSi -c -y1"

# make less more friendly, includes lesspipe
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"

alias o=less


# ls

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ll='ls --color=auto -l'
    alias l='ls --color=auto -lA'
    alias la=l

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias lsd='ls -d */'
