#!/bin/bash
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.
set -e

dotfiles=$HOME/.dotfiles
source $dotfiles/script/helper.sh

if [ "$OS" == "darwin" ]; then
  # Check for Homebrew
  if test ! $(which brew)
  then

    echo "  Installing Homebrew for you."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # Install homebrew packages
  # brew install grc coreutils spark

  brew doctor
  brew update
  brew upgrade --formula

  # Allows install beta versions
  brew tap homebrew/cask-versions
fi
