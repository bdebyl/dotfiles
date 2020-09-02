#!/bin/zsh

# if not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
# RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats ' %F{red}(%b)'
zstyle ':vcs_info:*' enable git

# Enable colors and change prompt
autoload -U colors && colors
PS1="%F{231}%n%F{green}@%F{blue}%M%{$reset_color%}: %F{yellow}%~%{$reset_color%}\$vcs_info_msg_0_%{$reset_color%} $%b "
#PS1="\[$(tput setaf 6)\]\u\[$(tput sgr0)\]\[$(tput setaf 3)\]@\[$(tput sgr0)\]\h: \[\$(tput setaf 4)\]\w\[$(tput sgr0)\]\[$(tput setaf 3)\]\$(parse_git_branch)\[$(tput sgr0)\] \$ "
setopt autocd extendedglob nomatch
stty stop undef

# Default keybindings
bindkey -e

# Use bash word style to fix oddities (i.e. backwards word killing)
autoload -U select-word-style
select-word-style bash

# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/histfile
HISTSIZE=1000
SAVEHIST=1000

# Load aliases
if [ -f "$HOME/.config/aliasrc" ]; then
    . "$HOME/.config/aliasrc"
fi

# Load custom shell vars
if [ -f "$HOME/.config/varsrc" ]; then
    . "$HOME/.config/varsrc"
fi

# The following lines were added by compinstall
autoload -Uz compinit

# zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle :compinstall filename '/home/bastian/.zshrc'
zmodload zsh/complist

compinit
_comp_options+=(globdots)

# Load syntax highlighting
. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# fix for gpg agent prompt
export GPG_TTY=$(tty)

# variables used by programs to default ot using emacs (vi as backup)
export ALTERNATE_EDITOR="emacsclient -nw"
export EDITOR="vim"
export VISUAL="vim"

# zsh ssh-agent persistence
if [ -f "$HOME/.local/share/zsh/plugins/ssh-agents.plugin.zsh" ]; then
    . $HOME/.local/share/zsh/plugins/ssh-agent.plugin.zsh
fi

# keychain for gpg/ssh
KEYFILE="$HOME/.config/.keys"
KEYFILEGPG="$HOME/.config/.keys-gpg"

if type keychain &>/dev/null; then
    # check for keyfile
    if [ -f "$KEYFILE" ] || [ -f "$KEYFILEGPG" ]; then
        # initialize keychain
        [ -f "$KEYFILE" ] && keychain --agents ssh --eval "$( cat $KEYFILE )" 2>&1 | sed '/keychain/d;/^$/d;s/^ \* /keychain - /'
        [ -f "$KEYFILEGPG" ] && keychain --agents gpg --eval "$( cat $KEYFILEGPG )" 2>&1 | sed '/keychain/d;/^$/d;s/^ \* /keychain - /'
        # load keychain environment
        [ -f "$HOME/.keychain/$HOSTNAME-sh" ] \
            && . "$HOME/.keychain/$HOSTNAME-sh"
        [ -f "$HOME/.keychain/$HOSTNAME-sh-gpg" ] \
            && . "$HOME/.keychain/$HOSTNAME-sh-gpg"
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
        if [ -f "$GPG_FILE" ] && kill -0 "$(cut -d: -f2 $GPG_FILE)" 2>/dev/null; then
            # get pid from file
            GPG_AGENT_INFO="$(cut -d= -f2 "$GPG_FILE")"
        else
            # start gpg-agent
            # TODO - investigate use of 'enable-ssh-support' here
            eval "$(gpg-agent --daemon --write-env-file "$GPG_FILE")"
        fi
        export GPG_AGENT_INFO
        echo "gpg-agent - running $GPG_AGENT_INFO"
    else
        echo "gpg-agent - not available!?"
    fi
fi

# create the symbolic link to use for emacs
ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh_auth_sock"
