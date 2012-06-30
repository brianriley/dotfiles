# Aliases
alias ls='ls -G'
alias ll='ls -lh'

# PostgreSQL
alias start_postgres="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias stop_postgres="pg_ctl -D /usr/local/var/postgres stop -s -m fast"

# t
alias t="~/bin/t/t.py --task-dir ~/Dropbox --list tasks"

# IP
alias whats-my-ip="curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+'"
