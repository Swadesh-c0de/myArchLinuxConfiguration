#!/bin/bash

# 01-system-update.sh - Task 1: Update System & Install Base Tooling (yay, parallel)
# Author: Swadesh-c0de

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Source shared functions and variables
source "$SCRIPT_DIR/lib/common.sh"

header "Task 1: System Update & Base Tooling"

# 1. Update System Packages
log "Updating system packages..."
sudo pacman -Syu --noconfirm
success "System update complete."

# 2. Install Git and Base-Devel if missing
if ! is_installed "git"; then
    log "Installing git..."
    sudo pacman -S --noconfirm git
fi

if ! is_installed "base-devel"; then
    log "Installing base-devel..."
    sudo pacman -S --noconfirm base-devel
fi

# 3. Install Yay (AUR Helper)
if ! command -v yay &> /dev/null; then
    log "Installing yay (AUR helper)..."
    BUILD_DIR="/tmp/yay-build-$(date +%s)"
    mkdir -p "$BUILD_DIR"
    cd "$BUILD_DIR" || exit 1
    git clone https://aur.archlinux.org/yay.git .
    makepkg -si --noconfirm
    cd "$DOTFILES_DIR" || exit 1
    rm -rf "$BUILD_DIR"
    
    if command -v yay &> /dev/null; then
        success "yay installed successfully."
    else
        error "Failed to install yay."
        exit 1
    fi
else
    log "yay is already installed."
fi

# 4. Ensure GNU Parallel is installed
if ! command -v parallel &> /dev/null; then
    log "Installing GNU Parallel..."
    sudo pacman -S --noconfirm parallel
    success "GNU Parallel installed."
else
    log "GNU Parallel is already installed."
fi

success "System update & base tooling setup complete."
