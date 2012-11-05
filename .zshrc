# Options and loads
setopt promptsubst
autoload -U promptinit
promptinit

autoload -U compinit
compinit

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Path to the .zsh directory
export ZSH=$HOME/.zsh

# Files to source in order
SOURCES=(exports colors correction completion prompt aliases git python)
for file in $SOURCES; do
    file=$ZSH/$file.zsh
    [[ -f $file ]] && source $file
done

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
