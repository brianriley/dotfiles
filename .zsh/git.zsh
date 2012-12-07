# the current branch
function git_branch_name() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "($(git_status_color)${ref#refs/heads/}%{$terminfo[sgr0]%})"
}

function git_status_color() {
    if [[ -n $(git status -s 2> /dev/null) ]]; then
        echo "%{$fg[red]%}"
    else
        echo "%{$fg[green]%}"
    fi
}

PROMPT='$PROMPT_PREFIX $(git_branch_name) $PROMPT_SUFFIX '
