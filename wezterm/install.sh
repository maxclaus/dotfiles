#!/bin/bash
set -e

dotfiles=$HOME/.dotfiles
source $dotfiles/script/helper.sh

if ! [ -L ~/.config/wezterm  ]; then
  ln -s $dotfiles/wezterm ~/.config/wezterm
fi
