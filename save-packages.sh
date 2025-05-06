#!/bin/bash

OUT_DIR="$HOME/lab/dotfiles/pkglist"
mkdir -p "$OUT_DIR"

# Paquets installés explicitement (repo officiel + AUR)
paru -Qqe | sort >"$OUT_DIR/explicit.txt"

# Paquets de l'AUR uniquement
paru -Qqm | sort >"$OUT_DIR/aur.txt"

# Paquets des dépôts officiels uniquement (hors AUR)
comm -23 "$OUT_DIR/explicit.txt" "$OUT_DIR/aur.txt" >"$OUT_DIR/repo.txt"

echo "✔ Paquets sauvegardés dans $OUT_DIR"
