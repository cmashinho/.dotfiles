export ZSH="$HOME/.oh-my-zsh"
export PATH="/opt/nvim-linux64/bin:$HOME/bin:$PATH"
export MANPAGER="nvim +Man!"
export EDITOR="nvim"

ZSH_THEME="robbyrussell"

if [ -f ~/.katarc ]; then
	source ~/.katarc
fi

export ZSH_FZF_HISTORY_SEARCH_FZF_EXTRA_ARGS="--no-color"

if [ -n "${KATA_HOME+1}" ]; then
	plugins=(git z zsh-fzf-history-search zsh-venv-switcher)
else
	plugins=(git z zsh-fzf-history-search)
fi

source $ZSH/oh-my-zsh.sh

setopt print_exit_value
setopt noclobber
