PROMPT_PREFIX="[%*] %c"
PROMPT_SUFFIX="%(!.#.>)"

setopt PROMPT_SUBST
PROMPT="$PROMT_PREFIX $PROMPT_SUFFIX "

# Tab and window title
case $TERM in
    *xterm*|ansi)
        function settab { print -Pn "\e]1;%~\a" }
        function settitle { print -Pn "\e]2;%~\a" }
        function chpwd { settab;settitle }
        settab;settitle
    ;;
esac
