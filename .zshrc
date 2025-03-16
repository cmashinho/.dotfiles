export ZSH="$HOME/.oh-my-zsh"
export PATH="/opt/nvim-linux64/bin:$PATH"
export MANPAGER="nvim +Man!"
export EDITOR="nvim"

ZSH_THEME="robbyrussell"

export ZSH_FZF_HISTORY_SEARCH_FZF_EXTRA_ARGS="--no-color"
plugins=(git z zsh-fzf-history-search)

source $ZSH/oh-my-zsh.sh

setopt print_exit_value
setopt noclobber
