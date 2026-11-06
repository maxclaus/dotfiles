#!/bin/bash
set -e

dotfiles=$HOME/.dotfiles
source $dotfiles/script/helper.sh

if ! command -v codex &>/dev/null; then
  npm install --global @openai/codex
fi
