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
# abbr --add gco 'git checkout'
# abbr --add gcb 'git checkout -b'
# abbr --add gst 'git status'
# abbr --add gcm 'git commit -m'
# abbr --add gca 'git commit --amend'
# abbr --add gpl 'git pull'
# abbr --add gps 'git push'
# abbr --add gdf 'git diff'
# abbr --add gaa 'git add -A'
# abbr --add glg 'git log --oneline --graph --all'

abbr --command=git c "commit -am"
abbr --command=git tc "commit -am"
abbr --command=git cm "commit --no-all -m"
abbr --command=git co checkout
abbr --command=git s status
abbr --command=git ts status
abbr --command=git amend "commit --amend --all --no-edit"
abbr --command=git hreset "reset --hard"
abbr --command=git cp cherry-pick
abbr --command=git cherrypick cherry-pick
abbr --command=git dif diff

abbr --add d docker
abbr --add k kubectl
abbr --add l 'cd ~/lab'

abbr --add cat 'bat -P'
abbr --add n npm
abbr --add y yarn
abbr --add oc opencode
abbr --add occ 'opencode --continue'
abbr --add lg lazygit

# mv, rm, cp
abbr --add mv 'mv -v'
abbr --add rm 'rm -v'
abbr --add cp 'cp -v'

abbr --add push "git push"
abbr --add dels "delta --side-by-side"

# some of my git aliases
abbr --command=git db diffbranch
# fully expand because the alias is has a # which fucks with git-filter-branch.
abbr --command=git dbt "diff origin/main..."

abbr --command=npm i install
#abbr --command=pnpm i "install"
