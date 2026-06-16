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

  # TODO: remove once all machines have been migrated — these taps are now built into Homebrew
  brew untap homebrew/core 2>/dev/null || true
  brew untap homebrew/cask 2>/dev/null || true

  brew update
  brew upgrade
  brew doctor || true
fi
