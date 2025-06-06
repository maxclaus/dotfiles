#!/bin/bash
set -e

dotfiles=$HOME/.dotfiles
source $dotfiles/script/helper.sh

if [ "$OS" == "darwin" ]; then
  brew install starship
elif [ "$OS" == "linux" ]; then
  # TODO: add linux install
  echo "Not implemented"
  exit 1
fi

if ! [ -L ~/.config/starship.toml  ]; then
  ln -s $dotfiles/starship/starship.toml ~/.config/starship.toml
fi
