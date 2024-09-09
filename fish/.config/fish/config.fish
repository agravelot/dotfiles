# if status is-interactive
# Commands to run in interactive sessions can go here
# end

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
set -gx PATH "$HOME/.orbstack/bin" $PATH
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
eval "$(/opt/homebrew/bin/brew shellenv)"

# test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish

if status is-interactive
    starship init fish | source
end
