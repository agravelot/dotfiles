if not status is-interactive
    exit
end

abbr --add q 'qs -c ii'

# if test "$TERM" != linux
#     abbr --add ls 'eza --icons'
#     abbr --add ll 'eza -aa -g --long --header --git --icons'
# end

if test "$TERM" = xterm-kitty
    abbr --add ssh 'kitten ssh'
end

abbr --add g git
abbr --add gco 'git checkout'
abbr --add gcb 'git checkout -b'
abbr --add gst 'git status'
abbr --add gcm 'git commit -m'
abbr --add gca 'git commit --amend'
abbr --add gpl 'git pull'
abbr --add gps 'git push'
abbr --add gdf 'git diff'
abbr --add gaa 'git add -A'
abbr --add glg 'git log --oneline --graph --all'

abbr --add d docker
abbr --add k kubectl
abbr --add l 'cd ~/lab'

abbr --add cat 'bat --theme=ainsi'
abbr --add n npm
abbr --add y yarn
abbr --add oc opencode
abbr --add lg lazygit
