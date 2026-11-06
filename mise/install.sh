#!/bin/bash
set -e

dotfiles=$HOME/.dotfiles
source $dotfiles/script/helper.sh

if [ "$OS" == "darwin" ]; then
  brew list mise &>/dev/null || brew install mise
fi

eval "$(mise activate bash --shims)"

# Install node LTS and set as global default
mise use --global node@lts

# Global npm packages
mise exec -- npm install --global diff-so-fancy
mise exec -- npm install --global git-open
mise exec -- npm install --global yarn
