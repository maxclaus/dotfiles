#!/bin/bash
set -e

dotfiles=$HOME/.dotfiles
source $dotfiles/script/helper.sh

if [ "$OS" == "darwin" ]; then
  brew install fish
elif [ "$OS" == "linux" ]; then
  # TODO: add linux install
  echo "Not implemented"
  exit 1
fi

FISH_BIN=$(command -v fish)
# adds fish to the list of known shells
if ! ( grep -q "$FISH_BIN" /etc/shells ); then
  echo $FISH_BIN | sudo tee -a /etc/shells
fi

chsh -s $(echo $FISH_BIN)

symlink_config $dotfiles/fish ~/.config/fish

# Run the rest of the commands on fish shell
$dotfiles/fish/post-install.fish
