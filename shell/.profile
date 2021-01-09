#!/bin/sh -e
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export BROWSER="firefox"

# create the symbolic link to use for emacs
# ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh_auth_sock"

#             _   _
#  _ __  __ _| |_| |_
# | '_ \/ _` |  _| ' \
# | .__/\__,_|\__|_||_|
# |_|
# Set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    export PATH="/opt/altera/19.1/quartus/bin:$HOME/bin:$PATH"
fi

#                 _        _
#  __ _ _ ___ _ _| |_ __ _| |__
# / _| '_/ _ \ ' \  _/ _` | '_ \
# \__|_| \___/_||_\__\__,_|_.__/
if [ -e $HOME/.config/.crontab ]; then
    crontab $HOME/.config/.crontab
fi

# #  _             _
# # | |__  __ _ __| |_  _ _ __
# # | '_ \/ _` (_-< ' \| '_/ _|
# # |_.__/\__,_/__/_||_|_| \__|
# if [ -n "$BASH_VERSION" ]; then
#     # include .bashrc if it exists
#     if [ -f "$HOME/.bashrc" ]; then
#         # shellcheck source=.bashrc
#         . "$HOME/.bashrc"
#     fi
# fi

# add gopath
if [ -d "$HOME/go/bin" ]; then
    export GOPATH="$HOME/go"
    export PATH="$GOPATH/bin:$PATH"
fi

export PATH="$HOME/.local/bin:$PATH"
#  ___ _ __  __ _ __ ___
# / -_) '  \/ _` / _(_-<
# \___|_|_|_\__,_\__/__/
# start emacs as a daemon (passes PATH properly vs. systemd service)
if [ ! "$(pgrep -f "emacs --daemon")" ] ; then
    emacs --daemon
fi

export QSYS_ROOTDIR="/home/bastian/.cache/yay/quartus-free/pkg/quartus-free/opt/altera/19.1/quartus/sopc_builder/bin"
