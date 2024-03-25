#!/usr/env/bin bash
# stow.sh
# This script is used to stow all the dotfiles in the current directory

MODULES="fish git nvim tmux yabai alacritty karabiner yabai skhd starship zsh"

for module in $MODULES; do
	echo "Stowing $module"
	stow "$module"
done
