#!/bin/sh

set -e

echo "Installing Homebrew packages..."
brew update
brew tap homebrew/bundle
brew bundle
for brewfile in */Brewfile; do
  brew bundle --file="$brewfile"
done
brew unlink qt 2>/dev/null || true
brew link --force qt5

echo "Installing Vundler"
if test -e ~/.vim/bundle/Vundle.vim; then
  pushd ~/.vim/bundle/Vundle.vim
  git pull
  popd
else
  pushd ~/.vim/bundle
  git clone https://github.com/gmarik/Vundle.vim.git
  popd
fi

echo "Linking dotfiles into ~..."
RCRC=rcrc rcup -v

echo "Installing Vim packages..."
vim +PlugInstall +qa
