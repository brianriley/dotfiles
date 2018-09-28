#!/bin/sh

set -e

if (test -e ~/.vim/autoload/plug.vim); then
  echo "already installed"
else
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
