#!/bin/bash

# restore_kde_sddm.sh - Restore KDE settings and SDDM theme from this repository
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Starting KDE & SDDM Restoration...${NC}"

# 1. Restore KDE Configs
echo "Restoring KDE configurations..."
KDE_REPO_DIR="$DOTFILES_DIR/.config/kde"
if [ -d "$KDE_REPO_DIR" ]; then
    mkdir -p "$HOME/.config"
    cp "$KDE_REPO_DIR"/* "$HOME/.config/"
    echo -e "${GREEN}KDE configurations restored.${NC}"
else
    echo "Error: KDE configs not found in repository."
fi

# 2. Restore SDDM Theme
echo "Restoring SDDM theme (pixel)..."
SDDM_THEME_REPO="$DOTFILES_DIR/sddm/themes/pixel"
if [ -d "$SDDM_THEME_REPO" ]; then
    sudo mkdir -p "/usr/share/sddm/themes"
    sudo cp -r "$SDDM_THEME_REPO" "/usr/share/sddm/themes/"
    
    # Configure SDDM to use the theme
    echo "Configuring SDDM..."
    sudo mkdir -p /etc/sddm.conf.d
    echo -e "[Theme]\nCurrent=pixel" | sudo tee /etc/sddm.conf.d/theme.conf > /dev/null
    
    echo -e "${GREEN}SDDM theme 'pixel' restored and enabled.${NC}"
else
    echo "Error: SDDM theme 'pixel' not found in repository."
fi

echo -e "\n${GREEN}Restoration complete!${NC}"
echo "Note: You may need to log out and back in for KDE changes to apply."
