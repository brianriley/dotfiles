#!/bin/sh

set -e

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

pushd scripts

fancy_echo "Installing Homebrew..."
source install-homebrew.sh

fancy_echo "Installing base16-shell..."
source install-base16.sh

fancy_echo "Installing Homebrew packages..."
source install-homebrew-packages.sh

fancy_echo "Linking dotfiles into ~..."
source rcup.sh

fancy_echo "Installing vim-plug..."
source install-vim-plug.sh

fancy_echo "Installing Vim plugins..."
source update-vim-plugins.sh

fancy_echo "Changing your shell to zsh ..."
source set-zsh.sh

fancy_echo "Installing Python packages..."
source pip-install.sh

fancy_echo "Install keybindings..."
source install-keybindings.sh

popd

fancy_echo "Setup OS X..."
source system/osx.sh
