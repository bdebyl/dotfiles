#!/bin/bash

# if not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# script for using a file as a stack for persistence
# shellcheck source=.scripts/stackfile.sh
. "$HOME/.scripts/stackfile.sh"

# git info in bash prompt
# shellcheck source=.scripts/gitprompt.sh
. "$HOME/.scripts/gitprompt.sh"

# keychain for gpg/ssh
# shellcheck source=.scripts/keychain.sh
. "$HOME/.scripts/keychain.sh"

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

#                          _
#  _ __ _ _ ___ _ __  _ __| |_
# | '_ \ '_/ _ \ '  \| '_ \  _|
# | .__/_| \___/_|_|_| .__/\__|
# |_|                |_|
PS1="\[$(tput setaf 6)\]\u\[$(tput sgr0)\]\[$(tput setaf 3)\]@\[$(tput sgr0)\]\h: \[\$(tput setaf 4)\]\w\[$(tput sgr0)\]\[$(tput setaf 3)\]\$(parse_git_branch)\[$(tput sgr0)\] \$ "

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# fix for gpg agent prompt
export GPG_TTY=$(tty)

#       _ _
#  __ _| (_)__ _ ___ ___ ___
# / _` | | / _` (_-</ -_|_-<
# \__,_|_|_\__,_/__/\___/__/
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


# __ ____ _ _ _ ___
# \ V / _` | '_(_-<
#  \_/\__,_|_| /__/
if [ -f "$HOME/.bash_vars" ]; then
    # shellcheck source=/dev/null
    . "$HOME/.bash_vars"
fi


#  ___ _ __  __ _ __ ___
# / -_) '  \/ _` / _(_-<
# \___|_|_|_\__,_\__/__/
# start emacs as a daemon (passes PATH properly vs. systemd service)
if [ ! "$(pgrep -f "emacs --daemon")" ] ; then
    emacs --daemon
fi

# variables used by programs to default ot using emacs (vi as backup)
export ALTERNATE_EDITOR="vi"
export EDITOR="emacsclient -nw"
export VISUAL="emacsclient -nw"

# create the symbolic link to use for emacs
ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh_auth_sock"

#                 _        _
#  __ _ _ ___ _ _| |_ __ _| |__
# / _| '_/ _ \ ' \  _/ _` | '_ \
# \__|_| \___/_||_\__\__,_|_.__/
if [ -e $HOME/.config/.crontab ]; then
    crontab $HOME/.config/.crontab
fi
