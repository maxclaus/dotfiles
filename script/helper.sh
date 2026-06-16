
info () {
  printf "  [ \033[00;34m..\033[0m ] $1"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

directory_exist () {
  if [[ -d "$1" ]] ; then
    return 0
  else
    return 1
  fi
}

get_os () {
  if [[ "$(uname)" == "Darwin" ]]; then
    echo "darwin"
  elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
    echo "linux"
  else
    echo "windows"
  fi
}

export OS=`get_os`

symlink_config () {
  # Usage: symlink_config <source> <target>
  # Creates target as a symlink to source, replacing a real directory if needed
  local source=$1
  local target=$2
  if [ -d "$target" ] && ! [ -L "$target" ]; then
    rm -rf "$target"
  fi
  if ! [ -e "$target" ]; then
    ln -s "$source" "$target"
  fi
}

brew_install_cask () {
  # Usage: brew_install_cask <cask> [extra flags...]
  # Example: brew_install_cask zoom --appdir="/Applications"
  local cask=$1
  shift
  brew list --cask "$cask" &>/dev/null || brew install --cask "$@" "$cask" || true
}
