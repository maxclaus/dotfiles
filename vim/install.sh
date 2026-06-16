#!/bin/bash
set -e

dotfiles=$HOME/.dotfiles
source $dotfiles/script/helper.sh

if [ "$OS" == "darwin" ]; then
  brew install macvim
elif [ "$OS" == "linux" ]; then
  sudo apt-get install vim-gnome -y
fi

symlink_config $dotfiles/vim ~/.vim
ln -fs $dotfiles/vim/vimrc ~/.vimrc
mkdir -p ~/.vim/{.backup,.swap}

echo '==> Installing vim-plug'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo '==> Installing vim plugins'
vim +PlugInstall +qall
