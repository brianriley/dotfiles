#!/bin/sh

set -e

if test -e ~/.config/base16-shell; then
  pushd ~/.config/base16-shell
  git pull
  popd
else
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi
