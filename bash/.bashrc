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
source $HOME/.bash/gitprompt.sh

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

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# __   ____ _ _ __ ___
# \ \ / / _` | '__/ __|
#  \ V / (_| | |  \__ \
#   \_/ \__,_|_|  |___/
#
if [ -f ~/.bash_vars ]; then
    . ~/.bash_vars
fi

#   ___ _ __ ___   __ _  ___ ___
#  / _ \ '_ ` _ \ / _` |/ __/ __|
# |  __/ | | | | | (_| | (__\__ \
#  \___|_| |_| |_|\__,_|\___|___/
#
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -nw"
export VISUAL="emacsclient -nw"

#  _                   _           _
# | | _____ _   _  ___| |__   __ _(_)_ __
# | |/ / _ \ | | |/ __| '_ \ / _` | | '_ \
# |   <  __/ |_| | (__| | | | (_| | | | | |
# |_|\_\___|\__, |\___|_| |_|\__,_|_|_| |_|
#           |___/
# ; -*-shell-script-*-
# MFL's bash profile config for keychain, pgp-agent, and ssh-agent

## keychain
KEYFILE="$HOME/.keys"
if type keychain &>/dev/null; then
    # check for keyfile
    if [ -f $KEYFILE ]; then
        # initialize keychain
        keychain $( cat $KEYFILE ) 2>&1 | sed '/keychain/d;/^$/d;s/^ \* /keychain - /'
        # load keychain environment
        [ -f "$HOME/.keychain/$HOSTNAME-sh" ] \
            && source "$HOME/.keychain/$HOSTNAME-sh"
        [ -f "$HOME/.keychain/$HOSTNAME-sh-gpg" ] \
            && source "$HOME/.keychain/$HOSTNAME-sh-gpg"
    else
        echo "keychain - keyfile does not exist!"
    fi
else
    # couldn't start keychain
    echo "keychain not available! Attempting ssh-agent / gpg-agent..."

    ## ssh-agent
    if type ssh-agent &>/dev/null; then
        # check that ssh-agent is not already running
        if [ -z "$SSH_AUTH_SOCK" ]; then
            # start ssh-agent
            eval $(ssh-agent -s) &>/dev/null
            # clean up when we exit
            trap "kill $SSH_AGENT_PID" 0
        fi
        echo "ssh-agent - running $SSH_AUTH_SOCK"
    else
        echo "ssh-agent - not available!?"
    fi

    ## gpg-agent
    if type gpg-agent &>/dev/null; then
        # set file name for env file
        GPG_FILE="$HOME/.gpg-agent-info"
        # check that env file exists
        if [ -f $GPG_FILE ] && kill -0 $(cut -d: -f2 $GPG_FILE) 2>/dev/null; then
            # get pid from file
            GPG_AGENT_INFO=$(cut -d= -f2 $GPG_FILE)
        else
            # start gpg-agent
            # TODO - investigate use of 'enable-ssh-support' here
            eval $(gpg-agent --daemon --write-env-file $GPG_FILE)
        fi
        export GPG_AGENT_INFO
        echo "gpg-agent - running $GPG_AGENT_INFO"
    else
        echo "gpg-agent - not available!?"
    fi
fi

# create the symbolic link to use for emacs
ln -sf $SSH_AUTH_SOCK ~/.ssh_auth_sock
