#!/bin/bash
set -e

dotfiles=$HOME/.dotfiles
source $dotfiles/script/helper.sh

if [ "$OS" == "darwin" ]; then
  brew_install_cask google-chrome --appdir="/Applications"
elif [ "$OS" == "linux" ]; then
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
  sudo apt-get update
  sudo apt-get install -y google-chrome-stable
fi
