#######################
#### Options and loads
#######################
autoload -U colors && colors

setopt prompt_subst
autoload -U promptinit && promptinit

# typing the dir name will cd into it
setopt autocd

# enable completion
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
#### Prompt
#######################
PROMPT_TIME="[%{$fg[cyan]%}%*%{$reset_color%}]"
PROMPT_PATH="%~"
PROMPT_CHAR="%(!.#.>)"

PROMPT='$PROMPT_PATH ${vcs_info_msg_0_}
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

#######################
#### pip
#######################
# keep all logs in one place
export PIP_LOG_FILE='/tmp/pip-log.txt'
# use a cache
export PIP_DOWNLOAD_CACHE='/tmp/pip_cache'

bindkey '^R' history-incremental-search-backward

#######################
#### rubby
#######################
if hash rbenv 2>/dev/null; then
  eval "$(rbenv init -)"
fi

GRC=`which grc`
if [ -n "$GRC" ]
then
  source "`brew --prefix`/etc/grc.bashrc"

  alias ll='grc ls -lh --color'
  alias ifconfig='grc ifconfig'
fi

#######################
#### gpg
#######################
GPG_TTY=$(tty)
export GPG_TTY

#######################
#### fzf
#######################
export FZF_DEFAULT_COMMAND='ag -g ""'
