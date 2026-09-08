#!/bin/bash

# 07-kde-sddm.sh - Task 7: Restore KDE Configurations and SDDM Theme
# Author: Swadesh-c0de

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Source shared functions and variables
source "$SCRIPT_DIR/lib/common.sh"

header "Task 7: KDE & SDDM Restoration"

# 1. Restore KDE Configs
log "Restoring KDE configurations..."
KDE_REPO_DIR="$DOTFILES_DIR/.config/kde"

if [ -d "$KDE_REPO_DIR" ]; then
    mkdir -p "$HOME/.config"
    for file in "$KDE_REPO_DIR"/*; do
        filename=$(basename "$file")
        backup "$HOME/.config/$filename"
        cp "$file" "$HOME/.config/"
    done
    success "KDE configurations restored to $HOME/.config/"
else
    error "KDE configs not found at $KDE_REPO_DIR"
fi

# 2. Restore SDDM Theme (pixel)
log "Restoring SDDM theme (pixel)..."
SDDM_THEME_REPO="$DOTFILES_DIR/sddm/themes/pixel"

if [ -d "$SDDM_THEME_REPO" ]; then
    sudo mkdir -p "/usr/share/sddm/themes"
    sudo cp -r "$SDDM_THEME_REPO" "/usr/share/sddm/themes/"
    
    # Configure SDDM to use the theme
    log "Configuring SDDM theme.conf..."
    sudo mkdir -p /etc/sddm.conf.d
    echo -e "[Theme]\nCurrent=pixel" | sudo tee /etc/sddm.conf.d/theme.conf > /dev/null
    
    success "SDDM theme 'pixel' restored and configured in /etc/sddm.conf.d/theme.conf"
else
    error "SDDM theme 'pixel' not found at $SDDM_THEME_REPO"
fi

log "Note: You may need to log out and back in for KDE changes to apply."
success "KDE and SDDM restoration complete."
