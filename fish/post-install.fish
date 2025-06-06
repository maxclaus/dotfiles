#!/usr/bin/env fish

# Install the fisher plugin manager
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# Install z to quickly jump across known directories:
fisher install jethrokuan/z

# Install fzf, a CLI fuzzy-finder, and make it work amazingly well with fish
brew install fzf && fisher install patrickf1/fzf.fish

# # Install a plugin that avoids issues where fish doesn't recognize global npm scripts
# fisher install rstacruz/fish-npm-global

# Install a fish-compatible version of nvm
fisher install jorgebucaran/nvm.fish
