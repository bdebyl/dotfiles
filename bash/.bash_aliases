#!/bin/bash
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -lah --color=auto --group-directories-first'
    alias tree='tree --dirsfirst'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias rgrep='grep -r --color=auto'
    alias mv='mv --verbose'
    alias diff='diff --color=auto'
    alias emc='TERM=xterm-256color emacsclient -nw'
    alias gitcleanup='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'
    alias gitsync='git checkout master && git pull upstream master && git push origin master && gitcleanup'
    alias datestr='printf "%(%Y-%m-%d)T"'
    # pamixer
    alias pgv='pamixer --get-volume'
    alias pls='pamixer --list-sinks'
    alias pss='pamixer --sink'
    alias psv='pamixer --set-volume'
    alias ptm='pamixer --toggle-mute'
    # fzf
    alias fcd='cd $(find $HOME -depth -type d -not -path "*.git*" | fzf)'
fi
