#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/end-4/dots-hyprland.git"
CACHE_DIR="$HOME/.cache/dots-hyprland"
STOW_MODULE="hyperland2"
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
MODULE_DIR="$DOTFILES_DIR/$STOW_MODULE"

SKIP_DEPS=false
SKIP_SETUPS=false
UPDATE_ONLY=false
DO_UNINSTALL=false

show_help() {
  cat << 'EOF'
Usage: ./sync-dots-hyprland.sh [OPTIONS]

Sync and install end-4/dots-hyprland with GNU Stow support.

Steps:
  1. Clone/update upstream repo to ~/.cache/dots-hyprland
  2. Install Arch dependencies via upstream PKGBUILDs
  3. Run system setups (user groups, systemd services, python venv)
  4. Stage config files into hyperland2/ stow module
  5. Stow symlinks into $HOME

Options:
  -h, --help         Show this help message and exit
  --skip-deps        Skip dependency installation
  --skip-setups      Skip system setups (user groups, services, venv)
  --update-only      Only pull and stage configs, do not install deps/setups/stow
  --uninstall        Unstow the module from $HOME and clean staged files

Requirements:
  - stow
  - An AUR helper (paru/yay) for dependency installation
  - sudo for system setups
EOF
}

cleanup_old_clone() {
  local old_clone="$MODULE_DIR/dots-hyprland"
  if [[ -d "$old_clone" ]]; then
    echo "Found old clone at $old_clone (no longer needed — using $CACHE_DIR now)"
    echo "You can remove it with: rm -rf $old_clone"
  fi
}

clone_or_update() {
  if [[ -d "$CACHE_DIR/.git" ]]; then
    echo "Updating existing clone at $CACHE_DIR..."
    git -C "$CACHE_DIR" pull --recurse-submodules
  else
    echo "Cloning upstream repo to $CACHE_DIR..."
    mkdir -p "$(dirname "$CACHE_DIR")"
    git clone "$REPO_URL" "$CACHE_DIR" --filter=blob:none --recurse-submodules
  fi
  git -C "$CACHE_DIR" submodule update --init --recursive
}

install_deps() {
  if [[ "$SKIP_DEPS" == true ]]; then
    echo "Skipping dependency installation (--skip-deps)"
    return
  fi
  echo "Installing dependencies via upstream script..."
  bash "$CACHE_DIR/setup" install-deps
}

install_setups() {
  if [[ "$SKIP_SETUPS" == true ]]; then
    echo "Skipping system setups (--skip-setups)"
    return
  fi
  echo "Running system setups (user groups, services, python venv)..."
  bash "$CACHE_DIR/setup" install-setups
}

stage_for_stow() {
  echo "Staging config files for stow module '$STOW_MODULE'..."

  rm -rf "$MODULE_DIR/.config" "$MODULE_DIR/.local"
  mkdir -p "$MODULE_DIR"

  rsync -a "$CACHE_DIR/dots/" "$MODULE_DIR/" \
    --exclude '.git' \
    --exclude '.gitmodules' \
    --exclude '.config/hypr/custom'

  cleanup_old_clone
}

do_stow() {
  if ! command -v stow &>/dev/null; then
    echo "Error: stow is not installed" >&2
    exit 1
  fi
  echo "Stowing $STOW_MODULE..."
  stow -d "$DOTFILES_DIR" -t "$HOME" "$STOW_MODULE"
}

do_unstow() {
  if ! command -v stow &>/dev/null; then
    echo "Warning: stow is not installed, cannot unstow" >&2
    return
  fi
  echo "Unstowing $STOW_MODULE..."
  stow -D -d "$DOTFILES_DIR" -t "$HOME" "$STOW_MODULE"
  echo "Cleaning staged files..."
  rm -rf "$MODULE_DIR/.config" "$MODULE_DIR/.local"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      show_help
      exit 0
      ;;
    --skip-deps)
      SKIP_DEPS=true
      shift
      ;;
    --skip-setups)
      SKIP_SETUPS=true
      shift
      ;;
    --update-only)
      UPDATE_ONLY=true
      shift
      ;;
    --uninstall)
      DO_UNINSTALL=true
      shift
      ;;
    *)
      echo "Error: unknown option $1" >&2
      show_help
      exit 1
      ;;
  esac
done

if [[ "$DO_UNINSTALL" == true ]]; then
  do_unstow
  exit 0
fi

clone_or_update

if [[ "$UPDATE_ONLY" == true ]]; then
  stage_for_stow
  echo
  echo "Update complete. Configs staged in $MODULE_DIR (not stowed)."
  echo "Run without --update-only to install deps/setups and stow."
  exit 0
fi

install_deps
install_setups
stage_for_stow
do_stow

echo
echo "Done! Configs stowed from $MODULE_DIR"
echo "Press Ctrl+Super+T to select a wallpaper after logging into Hyprland."
echo "Press Super+/ for a list of keybinds."