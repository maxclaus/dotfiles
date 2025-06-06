#!/bin/bash
set -e

dotfiles=$HOME/.dotfiles
source $dotfiles/script/helper.sh

if [ "$OS" == "darwin" ]; then
 brew install zsh
elif [ "$OS" == "linux" ]; then
  sudo apt-get install zsh -y
fi

ZSH_BIN=$(command -v zsh)
# adds zsh to the list of known shells
if ! ( grep -q "$ZSH_BIN" /etc/shells ); then
  echo $ZSH_BIN | sudo tee -a /etc/shells
fi

chsh -s $(echo $ZSH_BIN)

# Important
# In case have problem like "Password: chsh: PAM: Authentication failure".
# Maybe is because the /etc/shells file has an invalid path.

# Link zsh settings file to the home
ln -sf ~/.dotfiles/zsh/zshrc.symlink ~/.zshrc

brew install zsh-syntax-highlighting zsh-autosuggestions
