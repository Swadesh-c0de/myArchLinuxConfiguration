#!/bin/bash

# 02-packages.sh - Task 2: Install Categorized Applications and Packages
# Author: Swadesh-c0de

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Source shared functions and variables
source "$SCRIPT_DIR/lib/common.sh"

header "Task 2: Package Installation"

# --- Categorized Package Lists ---

PKGS_BROWSERS=(
    "google-chrome"
    "firefox"
)

PKGS_SYSTEM_TOOLS=(
    "mission-center"
    "stacer"
    "htop"
    "btop"
    "nvtop"
    "ncdu"
    "eza"
    "tree"
    "wget"
    "jq"
    "pacman-contrib"
    "smartmontools"
)

PKGS_DRIVERS_FIRMWARE=(
    "nvidia-open-dkms"
    "linux-headers"
    "dkms"
    "sof-firmware"
    "intel-media-driver"
    "libva-intel-driver"
    "libva-nvidia-driver"
    "vulkan-intel"
    "intel-ucode"
)

PKGS_DEVELOPMENT=(
    "visual-studio-code-bin"
    "docker"
    "docker-buildx"
    "docker-compose"
    "mysql-workbench"
    # "jdk-openjdk"
    # "mongodb-bin"
    # "mongosh-bin"
)

PKGS_TERMINAL_SHELL=(
    "kitty"
    "zsh"
    "fastfetch"
    "neofetch"
    "imagemagick"
    # "warp-terminal"
)

PKGS_PRODUCTIVITY=(
    "libreoffice-still"
    "obsidian"
    "telegram-desktop"
    "superfile-bin"
    "mpv"
    # "yt-dlp"
)

PKGS_KDE_DESKTOP=(
    "plasma-meta"
    "ark"
    "dolphin"
    "gwenview"
    "eog"
    "partitionmanager"
    "kalk"
    # "kate"
    # "kio-admin"
    # "konsole"
)

PKGS_FONTS=(
    "ttf-jetbrains-mono-nerd"
    # "ttf-cascadia-code-nerd"
    # "ttf-maple"
    # "inter-font"
    # "ttf-nerd-fonts-symbols"
)

PKGS_NETWORK=(
    "networkmanager"
    "networkmanager-openvpn"
    "openvpn"
    # "bluez"
    # "bluez-utils"
    # "power-profiles-daemon"
)

# Combine all enabled packages
ALL_PACKAGES=(
    "${PKGS_BROWSERS[@]}"
    "${PKGS_SYSTEM_TOOLS[@]}"
    "${PKGS_DRIVERS_FIRMWARE[@]}"
    "${PKGS_DEVELOPMENT[@]}"
    "${PKGS_TERMINAL_SHELL[@]}"
    "${PKGS_PRODUCTIVITY[@]}"
    "${PKGS_KDE_DESKTOP[@]}"
    "${PKGS_FONTS[@]}"
    "${PKGS_NETWORK[@]}"
)

# Target list: default to ALL_PACKAGES unless specific category requested
TARGET_PACKAGES=("${ALL_PACKAGES[@]}")

# Optional category filtering via argument
case "$1" in
    --browsers)     TARGET_PACKAGES=("${PKGS_BROWSERS[@]}") ;;
    --system)       TARGET_PACKAGES=("${PKGS_SYSTEM_TOOLS[@]}") ;;
    --drivers)      TARGET_PACKAGES=("${PKGS_DRIVERS_FIRMWARE[@]}") ;;
    --dev)          TARGET_PACKAGES=("${PKGS_DEVELOPMENT[@]}") ;;
    --terminal)     TARGET_PACKAGES=("${PKGS_TERMINAL_SHELL[@]}") ;;
    --productivity) TARGET_PACKAGES=("${PKGS_PRODUCTIVITY[@]}") ;;
    --kde)          TARGET_PACKAGES=("${PKGS_KDE_DESKTOP[@]}") ;;
    --fonts)        TARGET_PACKAGES=("${PKGS_FONTS[@]}") ;;
    --network)      TARGET_PACKAGES=("${PKGS_NETWORK[@]}") ;;
    --all|"")       TARGET_PACKAGES=("${ALL_PACKAGES[@]}") ;;
    *)
        echo "Usage: $0 [--all|--browsers|--system|--drivers|--dev|--terminal|--productivity|--kde|--fonts|--network]"
        exit 1
        ;;
esac

log "Total packages in selection: ${#TARGET_PACKAGES[@]}"

# Ensure parallel is available
if ! command -v parallel &> /dev/null; then
    warn "GNU Parallel not found, falling back to sequential check..."
    MISSING_PACKAGES=()
    for pkg in "${TARGET_PACKAGES[@]}"; do
        if ! is_installed "$pkg"; then
            MISSING_PACKAGES+=("$pkg")
        fi
    done
else
    log "Checking for missing packages concurrently with GNU Parallel..."
    MISSING_PACKAGES=$(parallel --will-cite check_missing ::: "${TARGET_PACKAGES[@]}")
fi

if [ -n "$MISSING_PACKAGES" ]; then
    log "Packages to install:"
    echo "$MISSING_PACKAGES" | while read -r p; do echo "  - $p"; done
    
    BATCH_INSTALL=$(echo "$MISSING_PACKAGES" | tr '\n' ' ')
    
    log "Starting batch installation..."
    if command -v yay &> /dev/null; then
        yay -S --noconfirm $BATCH_INSTALL
    else
        sudo pacman -S --noconfirm $BATCH_INSTALL
    fi
    success "Package installation complete."
else
    success "All packages in selection are already installed."
fi
