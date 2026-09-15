#!/bin/bash

# sync_to_repo.sh - Sync current KDE settings and SDDM theme to this repository
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Syncing KDE configurations..."
KDE_FILES=(
    "kdeglobals"
    "kwinrc"
    "kglobalshortcutsrc"
    "plasmashellrc"
    "plasma-org.kde.plasma.desktop-appletsrc"
    "kcminputrc"
)

mkdir -p "$DOTFILES_DIR/.config/kde"

for file in "${KDE_FILES[@]}"; do
    if [ -f "$HOME/.config/$file" ]; then
        cp "$HOME/.config/$file" "$DOTFILES_DIR/.config/kde/"
        echo "Synced $file"
    else
        echo "Warning: $file not found in ~/.config/"
    fi
done

echo "Syncing SDDM Theme (pixel)..."
if [ -d "/usr/share/sddm/themes/pixel" ]; then
    mkdir -p "$DOTFILES_DIR/sddm/themes"
    cp -r "/usr/share/sddm/themes/pixel" "$DOTFILES_DIR/sddm/themes/"
    echo "Synced SDDM theme: pixel"
else
    echo "Warning: SDDM theme 'pixel' not found in /usr/share/sddm/themes/"
fi

echo "Syncing terminal & shell configs..."
cp "$HOME/.zshrc" "$DOTFILES_DIR/.zshrc"
cp -r "$HOME/.config/kitty" "$DOTFILES_DIR/.config/"
cp -r "$HOME/.config/fastfetch" "$DOTFILES_DIR/.config/"
cp -r "$HOME/.config/superfile" "$DOTFILES_DIR/.config/"

echo "Done! All settings synced to repository."
