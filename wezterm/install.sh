#!/bin/bash
set -e

dotfiles=$HOME/.dotfiles
source $dotfiles/script/helper.sh

if [ "$OS" == "darwin" ]; then
  brew_install_cask wezterm
  brew_install_cask font-fira-mono-nerd-font
elif [ "$OS" == "linux" ]; then
  # TODO: add linux install
  echo "Not implemented"
  exit 1
fi

symlink_config $dotfiles/wezterm ~/.config/wezterm
