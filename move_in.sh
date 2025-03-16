#!/bin/sh

set -e

chmod 700 ~

if [ -d ~/.dotfiles ]; then
	cd ~/.dotfiles
	git pull --ff-only
else
	git clone https://github.com/cmashinho/.dotfiles ~/.dotfiles
fi

cd ~/.dotfiles
for f in .???*; do
	case "$f" in
		.git) continue ;;
		.gitignore) continue ;;
	esac

	rm -f ~/$f || true
	(cd ~/; ln -s .dotfiles/$f $f)
done

if [ ! -d ~/.ssh ]; then
	mkdir ~/.ssh
fi

if [ ! -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then
	git clone --depth 1 https://github.com/wbthomason/packer.nvim\
	 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

# we're probably being piped to a shell (ftp -o - .. | sh -) so this
# won't work running it ourselves
echo "nvim +PackerSync +qall"
