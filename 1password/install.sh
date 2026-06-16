#!/bin/bash
set -e

dotfiles=$HOME/.dotfiles
source $dotfiles/script/helper.sh

if [ "$OS" == "darwin" ]; then
  brew_install_cask 1password --appdir="/Applications"
  brew_install_cask 1password-cli
fi
