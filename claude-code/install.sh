#!/bin/bash
set -e

dotfiles=$HOME/.dotfiles
source $dotfiles/script/helper.sh

if ! command -v claude &>/dev/null; then
  curl -fsSL https://claude.ai/install.sh | bash
fi
