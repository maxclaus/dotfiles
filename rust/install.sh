#!/bin/bash
set -e

dotfiles=$HOME/.dotfiles
source $dotfiles/script/helper.sh

if ! command -v rustup &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
fi

CARGO_HOME="${CARGO_HOME:-$HOME/.cargo}"
[ -f "$CARGO_HOME/env" ] && source "$CARGO_HOME/env"
