#!/bin/bash
set -e

dotfiles=$HOME/.dotfiles
source $dotfiles/script/helper.sh

if [ "$OS" == "darwin" ]; then
  brew list awscli &>/dev/null || brew install awscli
fi

mkdir -p ~/.aws
[ -f ~/Dropbox/dotfiles-secret/aws-config ] && ln -sf ~/Dropbox/dotfiles-secret/aws-config ~/.aws/config
