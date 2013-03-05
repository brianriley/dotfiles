PROMPT_PREFIX="[%{$fg[cyan]%}%*%{$reset_color%}] %{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} %~"
PROMPT_SUFFIX="%(!.#.>)"

PROMPT='$PROMPT_PREFIX ${vcs_info_msg_0_} $PROMPT_SUFFIX '

# Tab and window title
case $TERM in
    *xterm*|ansi)
        function settab { print -Pn "\e]1;%~\a" }
        function settitle { print -Pn "\e]2;%~\a" }
        function chpwd { settab;settitle }
        settab;settitle
    ;;
esac
