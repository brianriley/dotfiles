# Path to the .zsh directory
export ZSH=$HOME/.zsh

# Files to source in order
SOURCES=(exports colors correction completion prompt aliases git python)
for file in $SOURCES; do
    file=$ZSH/$file.zsh
    [[ -f $file ]] && source $file
done
