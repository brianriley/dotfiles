# Options and loads
autoload -U colors
colors

setopt prompt_subst
autoload -U promptinit
promptinit

autoload -U compinit
compinit

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats "(%{$fg[green]%}%u%c%b%{$reset_color%})"
zstyle ':vcs_info:*' unstagedstr "%{$fg[red]%}"
zstyle ':vcs_info:*' stagedstr "%{$fg[red]%}"
precmd() {
    vcs_info
}

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Path to the .zsh directory
export ZSH=$HOME/.zsh

# Files to source in order
SOURCES=(exports correction completion prompt aliases python)
for file in $SOURCES; do
    file=$ZSH/$file.zsh
    [[ -f $file ]] && source $file
done

bindkey '^R' history-incremental-search-backward
