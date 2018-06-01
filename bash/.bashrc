#   ___ ___  _ __ ___
#  / __/ _ \| '__/ _ \
# | (_| (_) | | |  __/
#  \___\___/|_|  \___|

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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
function parse_git_branch {
   git rev-parse --git-dir &> /dev/null
   git_status="$(git status 2>/dev/null)"
   branch_pattern="^On branch ([^${IFS}]*)"
   remote_pattern="Your branch is (.*) of"
   diverge_pattern="Your branch and (.*) have diverged"
   if [[ ! ${git_status} =~ "working directory clean" ]]; then
       state=" √"
   fi
   # add an else if or two here if you want to get more specific
   if [[ ${git_status} =~ ${remote_pattern} ]]; then
       if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
           remote="↑"
       else
           remote="↓"
       fi
   fi
   if [[ ${git_status} =~ ${diverge_pattern} ]]; then
       remote="↕"
   fi
   if [[ ${git_status} =~ ${branch_pattern} ]]; then
       branch=${BASH_REMATCH[1]}
       echo "( ${branch}${remote}${state} )"
   fi
}

# Example from dstraffin:
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;32m\]$(parse_git_branch)\[\033[00m\]\$ '

case "$TERM" in
xterm*|rxvt*|eterm*)
    PS1="┌─( \[$(tput setaf 6)\]\u\[$(tput sgr0)\] )────────( \[$(tput setaf 4)\]\w\[$(tput sgr0)\] )────────( \[$(tput setaf 3)\]\$(date +%Y.%m.%d\ -\ %H:%M:%S)\[$(tput sgr0)\]\n└─\[$(tput setaf 61)\]\$(parse_git_branch)\[$(tput sgr0)\]──┤ "
    ;;
*)
    ;;
esac

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
export PATH=~/.local/bin:$PATH
export GOPATH="${HOME}/gocode"
export PATH=$GOPATH/bin:$PATH


#   ___ _ __ ___   __ _  ___ ___
#  / _ \ '_ ` _ \ / _` |/ __/ __|
# |  __/ | | | | | (_| | (__\__ \
#  \___|_| |_| |_|\__,_|\___|___/
#
export ALTERNATE_EDITOR="nano"
export EDITOR="emacsclient -t"
export VISUAL="emacsclient -c -a emacs"

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
