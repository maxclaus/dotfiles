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

# List of libraries and apps to be installed
deps=(
  homebrew
  fish
  starship
  wget
  nvm
  osx
  go
  rust
  tmux
  silver-search
  vim
  nvim
  docker
  gitup
  caffeine
  chrome
  firefox
  1password
  slack
  wezterm
  iterm
  zoomus
  alfred
  postman
  notion
  mas
  magnet
  tableplus
  claude-code
  codex
)

for dep in "${deps[@]}"
do
  info "$dep"

  installer="./${dep}/install.sh"
  chmod +x $installer
  $installer

  # After nvm is installed, load it so subsequent scripts can use node/npm
  if [ "$dep" = "nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    NVM_ROOT=$(brew --prefix nvm 2>/dev/null)
    [ -s "${NVM_ROOT}/nvm.sh" ] && \. "${NVM_ROOT}/nvm.sh"
  fi

  success "$dep"
done
