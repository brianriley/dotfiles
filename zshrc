#######################
#### Options and loads
#######################
autoload -U colors && colors

setopt prompt_subst
autoload -U promptinit && promptinit

# typing the dir name will cd into it
setopt auto_cd
cdpath=($HOME/src)

# enable completion
fpath+=~/.zfunc
autoload -U compinit && compinit
zstyle ':completion:*' menu select

# VCS prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats "(%{$fg[green]%}%u%c%b%{$reset_color%})"
zstyle ':vcs_info:*' unstagedstr "%{$fg[red]%}"
zstyle ':vcs_info:*' stagedstr "%{$fg[red]%}"
precmd() {
    vcs_info
}

bindkey -e

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Batch rename files: http://www.drbunsen.org/batch-file-renaming/
autoload zmv

# source any other configs
for config_file (~/.zsh/*.zsh); do
 source $config_file
done

#######################
#### Exports
#######################
export HISTFILE=$HOME/.history
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE

export PATH=/usr/local/sbin:/usr/local/bin:${PATH}

# npm'z
export PATH="/usr/local/share/npm/bin:$PATH"
export PATH="./node_modules/.bin:$PATH"

# add home bin folders to path
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# coreutils
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

export EDITOR="vi"

# Path to the .zsh directory
export ZSH=$HOME/.zsh

# spelling correction
setopt correct

#######################
#### Colors
#######################
# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
    eval "$("$BASE16_SHELL/profile_helper.sh")"

light() {
  base16_summerfruit-light
}

dark() {
  base16_eighties
}

#######################
#### Prompt
#######################
PROMPT_TIME="[%{$fg[cyan]%}%*%{$reset_color%}]"
PROMPT_PATH="%{$fg[white]%}%~%{$reset_color%}"
PROMPT_CHAR="%(!.#.>)"

PROMPT="\$(repeat \$COLUMNS printf '-')"
PROMPT+='$PROMPT_PATH ${vcs_info_msg_0_}
$PROMPT_CHAR '
RPROMPT='$PROMPT_TIME'

# Tab and window title
case $TERM in
    *xterm*|ansi)
        function settab { print -Pn "\e]1;%~\a" }
        function settitle { print -Pn "\e]2;%~\a" }
        function chpwd { settab;settitle }
        settab;settitle
    ;;
esac

#######################
#### Aliases
#######################
alias ls='ls -G --color'
alias ll='ls -lh'

alias whats-my-ip="curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+'"

alias mutt="cd ~/Downloads && mutt"

alias vi="vim"

alias h="heroku"

alias git="noglob git"

#######################
#### python
#######################
# keep all logs in one place
export PIP_LOG_FILE='/tmp/pip-log.txt'
# use a cache
export PIP_DOWNLOAD_CACHE='/tmp/pip_cache'
export PATH="$PATH:$HOME/.poetry/bin"

bindkey '^R' history-incremental-search-backward

#######################
#### version management
#######################
. $HOME/.asdf/asdf.sh

#######################
#### gpg
#######################
GPG_TTY=$(tty)
export GPG_TTY

#######################
#### fzf
#######################
export FZF_DEFAULT_COMMAND='ag -g ""'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#######################
#### fastlane
#######################
export PATH="$HOME/.fastlane/bin:$PATH"

#######################
#### direnv
#######################
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"

#######################
#### project specifics
#######################
[ -f ~/.project.zsh ] && source ~/.project.zsh
