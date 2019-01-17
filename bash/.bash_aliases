#!/bin/bash
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --group-directories-first -lah'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias rgrep='grep --color=auto --recursive'
    alias pacman='sudo pacman'
    alias emc='emacsclient -t'
    alias gitcleanup='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'
fi
