export ZSH="$HOME/.oh-my-zsh"
export MANPAGER="nvim +Man!"
export EDITOR="nvim"

ZSH_THEME="robbyrussell"

plugins=(git z)

source $ZSH/oh-my-zsh.sh

setopt print_exit_value
setopt noclobber
