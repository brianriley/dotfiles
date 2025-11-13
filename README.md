# My dotfiles, my computer

## Prerequisites

- [kitty](https://sw.kovidgoyal.net/kitty/)
- [Fira Code](https://github.com/tonsky/FiraCode)
- [GNU Stow](https://www.gnu.org/software/stow/)
- NeoVim
- ZSH
- [Oh My Posh](https://ohmyposh.dev/)
- [Mise-En-Place](https://mise.jdx.dev/)
- [fzf](https://github.com/junegunn/fzf)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- Tmux

## Installation

    $ stow -t ~ .

On OSX, run:

    $ mkdir -p $HOME/Library/KeyBindings
    $ cp system/DefaultKeyBinding.dict $HOME/Library/KeyBindings/
    $ source system/osx.sh
