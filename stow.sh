#!/usr/bin/env bash
# stow.sh
# This script is used to stow all the dotfiles in the current directory

MODULES="kitty fish git nvim tmux yabai alacritty karabiner yabai skhd starship zsh tmuxinator lazygit ssh hyprland"

for module in $MODULES; do
	echo "Stowing $module"
	stow -t ~ "$module"
done
