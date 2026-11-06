#!/bin/bash
set -e

if [ "$OS" == "darwin" ]; then
  brew list --cask jet &>/dev/null || brew install --cask codeship/taps/jet || echo "Warning: jet install failed (cask may be discontinued)"
fi
