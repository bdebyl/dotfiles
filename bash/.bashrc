#!/bin/bash
#   ___ ___  _ __ ___
#  / __/ _ \| '__/ _ \
# | (_| (_) | | |  __/
#  \___\___/|_|  \___|

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# git info in bash prompt
# shellcheck source=.bash/gitprompt.sh
. "$HOME/.bash/gitprompt.sh"

# keychain for gpg/ssh
# shellcheck source=.bash/keychain.sh
. "$HOME/.bash/keychain.sh"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

#  ____  ____  _
# |  _ \/ ___|/ |
# | |_) \___ \| |
# |  __/ ___) | |
# |_|   |____/|_|
#
PS1="\[$(tput setaf 6)\]\u\[$(tput sgr0)\]\[$(tput setaf 3)\]@\[$(tput sgr0)\]\h: \[\$(tput setaf 4)\]\w\[$(tput sgr0)\]\[$(tput setaf 3)\]\$(parse_git_branch)\[$(tput sgr0)\] \$ "

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#        _ _
#   __ _| (_) __ _ ___  ___  ___
#  / _` | | |/ _` / __|/ _ \/ __|
# | (_| | | | (_| \__ \  __/\__ \
#  \__,_|_|_|\__,_|___/\___||___/
#
if [ -f "$HOME/.bash_aliases" ]; then
    # shellcheck source=.bash_aliases
    . "$HOME/.bash_aliases"
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        # shellcheck source=/dev/null
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        # shellcheck source=/dev/null
        . /etc/bash_completion
    fi
fi


# __   ____ _ _ __ ___
# \ \ / / _` | '__/ __|
#  \ V / (_| | |  \__ \
#   \_/ \__,_|_|  |___/
#
if [ -f "$HOME/.bash_vars" ]; then
    # shellcheck source=/dev/null
    . "$HOME/.bash_vars"
fi

#   ___ _ __ ___   __ _  ___ ___
#  / _ \ '_ ` _ \ / _` |/ __/ __|
# |  __/ | | | | | (_| | (__\__ \
#  \___|_| |_| |_|\__,_|\___|___/
#
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -nw"
export VISUAL="emacsclient -nw"

# create the symbolic link to use for emacs
ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh_auth_sock"
