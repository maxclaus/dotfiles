#!/usr/bin/env bash
#
# Run all dotfiles installers.

set -e

dotfiles=$HOME/.dotfiles
source $dotfiles/script/helper.sh

cd "$(dirname $0)"/..

info () {
  printf "  [ \033[00;34m..\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

if [ "$OS" == "linux" ]; then
  sudo apt-get update
fi

# Create Development folder
mkdir -p ~/Development

# Link files
ln -sf ~/.dotfiles/alias.symlink ~/Development/alias.sh
ln -sf ~/.dotfiles/sleep.symlink ~/.sleep
ln -sf ~/Dropbox/dotfiles-secret/.tokenizer.json ~/
ln -sf ~/Dropbox/dotfiles-secret/.sqlectron.json ~/

# List of libraries and apps to be installed
deps=(
  homebrew
  zsh
  oh-my-zsh
  wget
  nvm
  osx
  go
  tmux
  silver-search
  vim
  nvim
  docker
  1password-cli
  jet
)

brew install diff-so-fancy

for dep in "${deps[@]}"
do
  info "$dep"

  installer="./${dep}/install.sh"
  chmod +x $installer
  $installer

  success "$dep"
done
