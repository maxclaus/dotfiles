#!/bin/bash
set -e

dotfiles=$HOME/.dotfiles
source $dotfiles/script/helper.sh

if [ "$OS" == "darwin" ]; then
  brew install nvim
elif [ "$OS" == "linux" ]; then
  # TODO: add linux install
  echo "Not implemented"
  exit 1
fi

symlink_config $dotfiles/nvim ~/.config/nvim

echo '==> Installing vim plugins'
nvim --headless "+Lazy! sync" +qa
