if not status is-interactive
    exit
end

function starship_transient_prompt_func
    starship module character
end

if test "$TERM" != linux
    starship init fish | source
    enable_transience
end