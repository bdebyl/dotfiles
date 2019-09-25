#!/bin/sh -e
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

uid=$(id -u)
export XDG_RUNTIME_DIR="/run/user/$uid"
export BROWSER="firefox"
#  _               _
# | |__   __ _ ___| |__  _ __ ___
# | '_ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__
# |_.__/ \__,_|___/_| |_|_|  \___|
#
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        # shellcheck source=.bashrc
        . "$HOME/.bashrc"
    fi
fi

#              _   _
#  _ __   __ _| |_| |__
# | '_ \ / _` | __| '_ \
# | |_) | (_| | |_| | | |
# | .__/ \__,_|\__|_| |_|
# |_|
# Set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

# add gopath
if [ -d "$HOME/go/bin" ] ; then
    export GOPATH="$HOME/go/bin"
    export PATH="$GOPATH:$PATH"
fi
