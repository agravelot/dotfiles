#!/usr/bin/env bash
# stow-system.sh
# Stows system-wide configs (system module) to / with sudo.
# Requires root privileges to create symlinks in /etc.

set -e

show_help() {
  cat << 'EOF'
Usage: ./stow-system.sh [OPTIONS]

Stows the "system" module to / using sudo.
Configs in system/etc/ are symlinked to /etc/.

Options:
  -h, --help  Show this help message and exit
  -D          Unstow (remove) system configs
  -R          Restow (re-stow) system configs
EOF
}

MODULE="system"
STOW_OPTS=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      show_help
      exit 0
      ;;
    -D|-R)
      STOW_OPTS+=("$1")
      shift
      ;;
    *)
      echo "Error: unknown option $1" >&2
      show_help
      exit 1
      ;;
  esac
done

echo "Stowing $MODULE module to / (requires sudo)..."
sudo stow "${STOW_OPTS[@]}" -t / "$MODULE"
echo "Done."
