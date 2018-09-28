#!/bin/sh

set -e

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

fancy_echo "Installing Homebrew..."
source scripts/install-homebrew.sh

fancy_echo "Installing base16-shell..."
source scripts/install-base16.sh

fancy_echo "Installing Homebrew packages..."
source scripts/install-homebrew-packages.sh

fancy_echo "Linking dotfiles into ~..."
source scripts/rcup.sh

fancy_echo "Installing vim-plug..."
source scripts/install-vim-plug.sh

fancy_echo "Installing Vim plugins..."
source scripts/update-vim-plugins.sh

fancy_echo "Changing your shell to zsh ..."
source scripts/set-zsh.sh

fancy_echo "Installing Python packages..."
source scripts/pip-install.sh

fancy_echo "Install keybindings..."
source scripts/install-keybindings.sh

fancy_echo "Setup OS X..."
source system/osx.sh
