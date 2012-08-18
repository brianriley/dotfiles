export HISTFILE=$ZSH/data/history
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE

export PATH=/usr/local/sbin:/usr/local/bin:${PATH}
export PATH="/usr/local/share/python:$PATH"

# add Ruby executable path
RUBY_EXECUTABLE_PATH=`gem environment | grep "EXECUTABLE DIRECTORY" | awk '{print $4}'`
export PATH="$RUBY_EXECUTABLE_PATH:$PATH"

# add cabal to path
export PATH="$HOME/.cabal/bin:$PATH"

# add home bin folders to path
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

export EDITOR="vi"
