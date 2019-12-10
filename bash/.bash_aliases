#!/bin/bash
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    if [ "$(test -r "$HOME/.dircolors")" ]; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
    alias diff='diff --color=auto'
    alias grep='grep --color=auto'
    alias ls='ls -lah --color=auto --group-directories-first'
    alias rgrep='grep -r'
fi

alias mv='mv --verbose'
alias tree='tree --dirsfirst'

# emacs
alias emc='TERM=xterm-256color emacsclient -nw'

# git macros
alias gitcleanup='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'
alias gitsync='git checkout master && git pull upstream master && git push origin master && gitcleanup'

# date macro
alias datestr='printf "%(%Y-%m-%d)T"'

# pamixer
alias pgv='pamixer --get-volume'
alias pls='pamixer --list-sinks'
alias pss='pamixer --sink'
alias psv='pamixer --set-volume'
alias ptm='pamixer --toggle-mute'

# fzf
alias fcd='cd $(find $HOME -type d -not -path "*.git*" | fzf)'

# pasteix
alias pasteix='curl -F "f:1=<-" ix.io <'

# khal/ikhal
alias ikhal="$HOME/.config/khal/.venv/bin/ikhal"
alias khal="$HOME/.config/khal/.venv/bin/khal"
