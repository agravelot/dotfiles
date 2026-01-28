#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/mylinuxforwork/dotfiles.git"
TMP_DIR="/tmp/mylinuxforwork-dotfiles"
DEST="/home/agravelot/lab/dotfiles/hyprland"

echo "Cloning repo (depth=1)..."

rm -rf "$TMP_DIR"
git clone --depth 1 "$REPO_URL" "$TMP_DIR"

echo "Removing things i do not want..."
rm -rf "$TMP_DIR"/dotfiles/.zshrc
rm -rf "$TMP_DIR"/dotfiles/.config/fish
rm -rf "$TMP_DIR"/dotfiles/.config/zshrc
rm -rf "$TMP_DIR"/dotfiles/.config/kitty
rm -rf "$TMP_DIR"/dotfiles/.config/nvim

echo "Creating destination directory..."
mkdir -p "$DEST"

echo "Copying dotfiles..."
cp -a "$TMP_DIR"/dotfiles/. "$DEST"/

echo "Cleaning up..."
rm -rf "$TMP_DIR"

echo "Done."
