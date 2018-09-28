#!/bin/sh

set -e

if ! grep "$(which zsh)" /etc/shells; then
  sudo sh -c 'echo "$(which zsh)" >> /etc/shells'
fi
chsh -s "$(which zsh)"

