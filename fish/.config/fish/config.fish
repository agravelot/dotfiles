# if status is-interactive
# Commands to run in interactive sessions can go here
# end

set -gx VOLTA_HOME "$HOME/.volta"
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"

if test -d /opt/homebrew/bin
    set -gx PATH /opt/homebrew/bin $PATH
end

if test -d "$HOME/.orbstack/bin"
    set -gx PATH "$HOME/.orbstack/bin" $PATH
end

if test -d "$VOLTA_HOME/bin"
    set -gx PATH "$VOLTA_HOME/bin" $PATH
end

# test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish

if status is-interactive
    starship init fish | source
end
