#!/bin/sh

set -e

brew update
brew tap homebrew/bundle
brew bundle --file=../Brewfile
brew unlink qt 2>/dev/null || true
brew link --force qt5
