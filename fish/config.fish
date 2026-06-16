
# https://mmazzarolo.com/blog/2023-11-16-my-fish-shell-setup-on-macos/
# https://github.com/jorgebucaran/awsm.fish

# Disable the fish greeting message
set fish_greeting ""

# Setup  local bin path
fish_add_path ~/.local/bin

# Setup brew (works on both Intel /usr/local and Apple Silicon /opt/homebrew)
if test -x /opt/homebrew/bin/brew
  eval "$(/opt/homebrew/bin/brew shellenv)"
else if test -x /usr/local/bin/brew
  eval "$(/usr/local/bin/brew shellenv)"
end

# Setup starship
starship init fish | source

# Reload the shell
function fish_reload
  source ~/.config/fish/config.fish
end


# Migrated helpers from ~/Development/alias.sh
function vim
  mvim -v $argv
end

function dc
  docker compose $argv
end

function dcb
  docker compose build $argv
end

function dcup
  docker compose up $argv
end

function dcr
  docker compose run --service-ports --rm $argv
end

function dcps
  docker compose ps $argv
end

function dclogs
  docker compose logs $argv
end

function gosrc
  cd $GOPATH/src
end

function grep_exclude_node_modules
  grep --exclude-dir="node_modules" $argv
end

function tm
  gtime --format='\n---\n"%C" took %e seconds with %P CPU usage\n---\n' $argv
end

function new_uuid
  uuidgen | string lower
end

function brewup
  brew update
  brew upgrade
  brew prune
  brew cleanup
  brew doctor
end

function dcrun
  set -l container_name $argv[1]
  docker compose run --rm --use-aliases --service-ports $container_name sh
end

function reload-alias
  if test -f ~/.config/fish/config.fish
    source ~/.config/fish/config.fish
    echo "> alias reloaded"
  else
    echo "> alias NOT reloaded"
    return 1
  end
end

function dcrm
  docker compose stop $argv[1]
  docker compose rm --force $argv[1]
end

# Find process by executable name and show the working directory as well.
function pgrep_pwdx
  for p in (pgrep $argv[1])
    echo "$p | "(pwdx $p)
  end
end

# pwdx for macOS: https://gist.github.com/tobym/648188
function pwdx
  lsof -a -d cwd -p $argv[1] -n -Fn | awk '/^n/ {print substr($0,2)}'
end

function pcwd
  lsof -a -d cwd -p $argv[1]
end

function kill_process_cwd
  set -l program $argv[1]
  if test -z "$program"
    echo "Missing program arg"
    return 1
  end

  for p in (pgrep $program)
    set -l p_path (pwdx $p)
    if test "$p_path" = (pwd)
      echo "Exiting process $p at $p_path"
      kill $p
      return 0
    end
  end

  echo "Could not find process"
  return 1
end

function get_wifi_ip
  ipconfig getifaddr en0
end

function kill_process_running_at_port
  set -l port $argv[1]
  if test -z "$port"
    echo "Usage: kill_process_running_at_port [numeric port identifier]" >&2
    return 1
  end

  set -l pid (lsof -i TCP:$port | awk '/LISTEN/{print $2}')
  if test -z "$pid"
    echo "No process found on this port"
    return 1
  end

  kill -9 $pid
  echo "Process killed"
end

function envup
  set -l envfile $argv[1]
  if test -z "$envfile"
    echo "Usage: envup [env file]" >&2
    return 1
  end

  if not test -f "$envfile"
    echo "Env file not found: $envfile" >&2
    return 1
  end

  for line in (bash -c 'set -a; source "$1"; env -0' bash $envfile | string split0)
    set -l pair (string split -m 1 = $line)
    set -gx $pair[1] $pair[2]
  end
end

if type -q rg
  set -gx FZF_DEFAULT_COMMAND 'rg --files'
  set -gx FZF_DEFAULT_OPTS '-m --height 50% --border'
end

function compress_pdf
  gs -sDEVICE=pdfwrite -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="output.pdf" input.pdf
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

# Setup mise (manages node and other runtimes)
command -v mise &>/dev/null && mise activate fish | source

# Setup Rust tools
set -Ux RUSTUP_HOME $HOME/.config/rustup
set -Ux CARGO_HOME $HOME/.config/cargo
fish_add_path $CARGO_HOME/bin

# Setup Go tools
set -Ux GOPATH $HOME/Development/go
fish_add_path $GOPATH/bin


# Setup Python tools
set -l _python_prefix (brew --prefix python@3.11 2>/dev/null)
if test -n "$_python_prefix"
  set -Ux PYTHON_BIN_PATH $_python_prefix/libexec/bin
  fish_add_path $PYTHON_BIN_PATH
end
fish_add_path /Users/maxnunes/Library/Python/3.11/bin


# Setup Solana tools
set -Ux SOLANA_BIN_PATH /Users/maxnunes/.local/share/solana/install/active_release/bin
fish_add_path $SOLANA_BIN_PATH

# Setup psql
fish_add_path /opt/homebrew/opt/postgresql@17/bin

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
abbr -ag grbqa 'git rebase qa'
abbr -ag grbc 'git rebase --continue'
abbr -ag grba 'git rebase --abort'
abbr -ag gb 'git branch'
abbr -ag gcl 'git clone'
abbr -ag gl 'git pull'
abbr -ag gc 'git commit'
abbr -ag gcb 'git checkout -b'
abbr -ag gco 'git checkout'
abbr -ag gsw 'git switch'
abbr -ag gswc 'git switch -c'
abbr -ag gd 'git diff'
abbr -ag gp 'git push'
abbr -ag gcm 'git checkout (git_main_branch)'
abbr -ag gst 'git status'

## -> Load secret configurations
test -f ~/Dropbox/dotfiles-secret/alias.fish && source ~/Dropbox/dotfiles-secret/alias.fish
export PATH="$HOME/.local/bin:$PATH"
