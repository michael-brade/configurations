alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'


umask 022


## the shell history - share across sessions, avoid and erase all dupes

# record all history
HISTSIZE=-1
HISTFILESIZE=$HISTSIZE
HISTTIMEFORMAT="%d %b %Y, %H:%M - "

# erase all dupes
shopt -s histappend
HISTCONTROL="ignoredups:erasedups"
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

export HISTFILESIZE HISTSIZE HISTCONTROL HISTTIMEFORMAT

# manually erase dupes: (use only without timestamps!)
#   tac $HISTFILE | awk '!x[$0]++' | tac | sponge $HISTFILE


# less

LESSCHARSET=utf-8
LESS="-RMSI -c -y1"
export LESSCHARSET LESS

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
