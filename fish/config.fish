
# https://mmazzarolo.com/blog/2023-11-16-my-fish-shell-setup-on-macos/
# https://github.com/jorgebucaran/awsm.fish

# Disable the fish greeting message
set fish_greeting ""

# fish_add_path ~/.config/bin
# # Add homebrew binaries to the path
# fish_add_path "/opt/homebrew/bin/"

# Setup brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Setup starship
starship init fish | source

# Reload the shell
function reload_fish
  source ~/.config/fish/config.fish
end


# Enable VI mode
fish_vi_key_bindings

# Make eza output less colorful
set --export --universal EZA_COLORS "ur=0:uw=0:ux=0:ue=0:gr=0:gw=0:gx=0:tr=0:tw=0:tx=0:uu=0:gu=0:lc=0:lm=0:da=0"

# Set default editor
set -Ux EDITOR nvim

# Setup vcpkg
set -Ux VCPKG_ROOT $HOME/.config/vcpkg
fish_add_path $VCPKG_ROOT

# Setup Node tools
set -Ux VOLTA_HOME $HOME/.config/volta
fish_add_path $VOLTA_HOME/bin

# Setup Rust tools
set -Ux RUSTUP_HOME $HOME/.config/rustup
set -Ux CARGO_HOME $HOME/.config/cargo
fish_add_path $CARGO_HOME/bin

# Setup Python tools
set -Ux PYTHON_BIN_PATH /opt/homebrew/opt/python@3.11/libexec/bin
fish_add_path $PYTHON_BIN_PATH

# Setup Solana tools
set -Ux SOLANA_BIN_PATH /Users/maxnunes/.local/share/solana/install/active_release/bin
fish_add_path $SOLANA_BIN_PATH

## TODO: move it to functions directory
# https://github.com/jhillyerd/plugin-git/blob/master/functions/__git.default_branch.fish
function git_main_branch -d "Use init.defaultBranch if it's set and exists, otherwise use main if it exists. Falls back to master"
  command git rev-parse --git-dir &>/dev/null; or return
  if set -l default_branch (command git config --get init.defaultBranch)
    and command git show-ref -q --verify refs/heads/{$default_branch}
    echo $default_branch
  else if command git show-ref -q --verify refs/heads/main
    echo main
  else
    echo master
  end
end

# Git abbreviations
# Based on https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
abbr -ag g 'git'
abbr -ag grbm 'git rebase (git_main_branch)'
abbr -ag gb 'git branch'
abbr -ag gcb 'git checkout -b'
abbr -ag gcl 'git clone'
abbr -ag gl 'git pull'
abbr -ag gc 'git commit'
abbr -ag gco 'git checkout'
abbr -ag gd 'git diff'
abbr -ag gp 'git push'
abbr -ag gcm 'git checkout (git_main_branch)'
abbr -ag gst 'git status'

## -> Load secret configurations
source ~/Dropbox/dotfiles-secret/alias.fish
