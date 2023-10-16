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

# zsh completions
fpath=(~/.local/share/zsh/zsh-completions/src $fpath)
# auto suggestions
. /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#555"
# Enable colors and change prompt
autoload -U colors && colors
# function powerline_precmd() {
#   PS1="$(powerline-shell --shell zsh $?)"
# }
#
# function install_powerline_precmd() {
#   for s in "${precmd_functions[@]}"; do
#     if [ "$s" = "powerline_precmd"  ]; then
#       return
#     fi
#   done
#   precmd_functions+=(powerline_precmd)
# }
#
# if [ "$TERM" != "linux"  ]; then
#   install_powerline_precmd
# fi
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
setopt histignoredups
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
ZSH_PLUGIN_SYNTAX_HI="/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
[ -f "$ZSH_PLUGIN_SYNTAX_HI" ] && . "$ZSH_PLUGIN_SYNTAX_HI"

# fix for gpg agent prompt
export GPG_TTY=$(tty)

# variables used by programs to default ot using emacs (vi as backup)
export ALTERNATE_EDITOR="emacsclient -nw"
export EDITOR="vim"
export VISUAL="vim"

# browser
export BROWSER="microsoft-edge-stable"

# keychain for gpg/ssh
KEYFILE="$HOME/.config/.keys"
KEYFILEGPG="$HOME/.config/.keys-gpg"
[ -z "$HOSTNAME" ] && HOSTNAME="$(cat /etc/hostname)"

if type keychain &>/dev/null; then
  # check for keyfile
  if [ -f "$KEYFILE" ] || [ -f "$KEYFILEGPG" ]; then
    # initialize keychain
    [ -f "$KEYFILE" ] && keychain --agents ssh "$(cat $KEYFILE)"  2>&1 | sed '/keychain/d;/^$/d;s/^ \* /keychain - /'
    [ -f "$KEYFILEGPG" ] && keychain --agents gpg "$(cat $KEYFILEGPG)"  2>&1 | sed '/keychain/d;/^$/d;s/^ \* /keychain - /'
    # load keychain environment
    [ -f "$HOME/.keychain/$HOSTNAME-sh" ] && . "$HOME/.keychain/$HOSTNAME-sh"
    [ -f "$HOME/.keychain/$HOSTNAME-sh-gpg" ] && . "$HOME/.keychain/$HOSTNAME-sh-gpg"
  else
    echo "keychain - keyfile does not exist!"
  fi
fi

export QSYS_ROOTDIR="/home/bastian/.cache/yay/quartus-free/pkg/quartus-free-quartus/opt/intelFPGA/21.1/quartus/sopc_builder/bin"
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
