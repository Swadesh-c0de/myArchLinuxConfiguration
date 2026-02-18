#!/bin/bash

# setup.sh - Arch Linux + KDE Setup Script
# Author: Swadesh-c0de

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# --- Variables ---
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
LOG_FILE="$DOTFILES_DIR/setup.log"

# --- Functions ---

log() {
    echo -e "${BLUE}[INFO]${NC} $1"
    echo "[INFO] $1" >> "$LOG_FILE"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
    echo "[SUCCESS] $1" >> "$LOG_FILE"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
    echo "[WARN] $1" >> "$LOG_FILE"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    echo "[ERROR] $1" >> "$LOG_FILE"
}

# Check if a package is installed
is_installed() {
    pacman -Qi "$1" &> /dev/null
}

# Install packages using yay (or pacman if yay is not yet installed but we need it)
install_package() {
    local pkg="$1"
    if is_installed "$pkg"; then
        log "$pkg is already installed."
    else
        log "Installing $pkg..."
        if command -v yay &> /dev/null; then
            yay -S --noconfirm "$pkg"
        else
            sudo pacman -S --noconfirm "$pkg"
        fi
        
        if is_installed "$pkg"; then
            success "$pkg installed successfully."
        else
            error "Failed to install $pkg."
        fi
    fi
}

# Backup existing config file/directory
backup() {
    local target="$1"
    if [ -e "$target" ]; then
        if [ ! -d "$BACKUP_DIR" ]; then
            mkdir -p "$BACKUP_DIR"
            log "Created backup directory: $BACKUP_DIR"
        fi
        log "Backing up $target to $BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/"
    fi
}

# --- Main Script ---

log "Starting Arch Linux + KDE Setup..."

# 1. Update System
log "Updating system..."
sudo pacman -Syu --noconfirm

# 2. Install Yay (AUR Helper)
if ! command -v yay &> /dev/null; then
    log "Installing yay..."
    if ! is_installed "git"; then
        sudo pacman -S --noconfirm git
    fi
    if ! is_installed "base-devel"; then
        sudo pacman -S --noconfirm base-devel
    fi
    
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd "$DOTFILES_DIR"
else
    log "yay is already installed."
fi

# Ensure GNU Parallel is installed
if ! command -v parallel &> /dev/null; then
    log "Installing GNU Parallel..."
    sudo pacman -S --noconfirm parallel
fi

# Define Package List
PACKAGES=(
    # Browsers
    "google-chrome"
    # System Tools
    "mission-center"
    "stacer"
    "htop"
    "btop"
    "nvtop"
    # "bluez"
    # "bluez-utils"
    # "power-profiles-daemon"
    # Development
    "visual-studio-code-bin"
    # "postman-bin"
    # "requestly-bin"
    "mongodb-compass"
    "mongodb-bin"
    "mongosh-bin"
    "jdk-openjdk"
    # Terminal & Shell
    "kitty"
    "zsh"
    "fastfetch"
    "neofetch"
    # "warp-terminal"
    # Productivity & Office
    "libreoffice-fresh"
    "obsidian"
    "telegram-desktop"
    "superfile-bin"
    # KDE/Gnome Tools
    "eog"
    "gewnview"
    # "spectacle"
    "kalk"
    # Fonts
    "ttf-cascadia-code-nerd"
    "ttf-maple"
)

# Function to check if package is missing (for parallel)
check_missing() {
    if ! pacman -Qi "$1" &> /dev/null; then
        echo "$1"
    fi
}
export -f check_missing

log "Checking for missing packages using GNU Parallel..."
# Use parallel to check packages concurrently
# We pass the array to parallel, which runs check_missing for each item.
MISSING_PACKAGES=$(parallel --will-cite check_missing ::: "${PACKAGES[@]}")

if [ -n "$MISSING_PACKAGES" ]; then
    log "Installing missing packages: $MISSING_PACKAGES"
    # Convert newlines to spaces for the command
    BATCH_INSTALL=$(echo "$MISSING_PACKAGES" | tr '\n' ' ')
    
    if command -v yay &> /dev/null; then
        yay -S --noconfirm $BATCH_INSTALL
    else
        # Try pacman first, warn if some are AUR
        sudo pacman -S --noconfirm $BATCH_INSTALL
    fi
    success "Batch installation complete."
else
    log "All packages are already installed."
fi

# 4. Configuration

# Bluetooth Service
# log "Enabling Bluetooth..."
# sudo systemctl enable --now bluetooth

# Power Profile Service
# log "Enabling Power Profiles Daemon..."
# sudo systemctl enable --now power-profiles-daemon.service

# MongoDB Service
log "Enabling MongoDB..."
sudo systemctl enable --now mongodb

# ZSH & Oh My Zsh
log "Configuring Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if [ -f "$DOTFILES_DIR/.zshrc" ]; then
    backup "$HOME/.zshrc"
    cp "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
    success "Updated .zshrc"
else
    warn ".zshrc not found in repo."
fi

# Kitty
log "Configuring Kitty..."
if [ -d "$DOTFILES_DIR/.config/kitty" ]; then
    backup "$HOME/.config/kitty"
    cp -r "$DOTFILES_DIR/.config/kitty" "$HOME/.config/"
    success "Updated Kitty config"
fi

# Fastfetch
log "Configuring Fastfetch..."
if [ -d "$DOTFILES_DIR/.config/fastfetch" ]; then
    backup "$HOME/.config/fastfetch"
    mkdir -p "$HOME/.config"
    cp -r "$DOTFILES_DIR/.config/fastfetch" "$HOME/.config/"
    success "Updated Fastfetch config"
else
    warn "Fastfetch config not found in repo at .config/fastfetch"
fi

# Startup Image Script (for Kitty)
# log "Configuring Startup Image Script..."
# STARTUP_SCRIPT='
# if [ -z "$STARTUP_IMAGE_DISPLAYED" ]; then
#     # Get a random image from the directory
#     IMAGE_PATH=$(find $HOME/.config/fastfetch/pngs/ -type f -iname "*.png" | shuf -n 1)

#     # Set the desired height in pixels (you can experiment with this value)
#     HEIGHT=300  # Adjust this value for your needs

#     if [ -n "$IMAGE_PATH" ]; then
#         # Resize the image using ImageMagick (magick convert)
#         RESIZED_IMAGE_PATH="/tmp/resized_image.png"
#         magick "$IMAGE_PATH" -resize x$HEIGHT "$RESIZED_IMAGE_PATH"

#         # Display the resized image using kitty
#         if command -v kitty &> /dev/null; then
#             kitty +kitten icat "$RESIZED_IMAGE_PATH"
#         fi
#     fi

#     # Set the environment variable to avoid re-running
#     export STARTUP_IMAGE_DISPLAYED=1
# fi
# '

# if [ -f "$HOME/.zshrc" ]; then
#     if ! grep -q "STARTUP_IMAGE_DISPLAYED" "$HOME/.zshrc"; then
#         log "Appending startup image script to .zshrc..."
#         echo "$STARTUP_SCRIPT" >> "$HOME/.zshrc"
#         success "Added startup image script to .zshrc"
#     else
#         log "Startup image script seems to be already present in .zshrc."
#     fi
# fi

# 5. Tweaks

# Chrome Touch Gestures
log "Applying Chrome Touch Gestures..."
CHROME_DESKTOP="/usr/share/applications/google-chrome.desktop"
if [ -f "$CHROME_DESKTOP" ]; then
    # We need sudo to edit this.
    # This involves replacing Exec lines. 
    # Doing this with sed safely is tricky if the file format changes.
    # But let's try a simple sed replacement if the string matches basic default.
    sudo sed -i 's|Exec=/usr/bin/google-chrome-stable %U|Exec=/usr/bin/google-chrome-stable %U --enable-features=TouchpadOverscrollHistoryNavigation|g' "$CHROME_DESKTOP"
    sudo update-desktop-database /usr/share/applications/
    success "Patched google-chrome.desktop"
else
    warn "google-chrome.desktop not found at $CHROME_DESKTOP"
fi

# 6. Optional NVIDIA Setup
echo
echo -e "${YELLOW}--- NVIDIA Configuration ---${NC}"
read -p "Do you want to apply NVIDIA + Linux Zen tweaks? (This involves blacklisting nouveau and updating GRUB) [y/N]: " nvidia_response
if [[ "$nvidia_response" =~ ^[Yy]$ ]]; then
    log "Applying NVIDIA configurations..."
    
    # Blacklist Nouveau
    sudo bash -c "echo 'blacklist nouveau' > /etc/modprobe.d/blacklist-nouveau.conf"
    sudo bash -c "echo 'options nouveau modeset=0' >> /etc/modprobe.d/blacklist-nouveau.conf"
    success "Blacklisted nouveau"

    # Update GRUB
    # Provide a warning: modifying GRUB can be dangerous
    log "Updating GRUB_CMDLINE_LINUX_DEFAULT..."
    sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet nvidia-drm.modeset=1"/g' /etc/default/grub
    
    log "Rebuilding GRUB config..."
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    
    log "Rebuilding initramfs..."
    sudo mkinitcpio -P
else
    log "Skipping NVIDIA configuration."
fi


# 7. Specific Hardware Fixes
# echo
# echo -e "${YELLOW}--- Hardware Specific Fixes ---${NC}"
# read -p "Do you want to apply the sound fix for Acer Predator Helios Neo 16? (modprobe snd_hda_intel) [y/N]: " sound_response
# if [[ "$sound_response" =~ ^[Yy]$ ]]; then
#     log "Applying sound fix..."
#     sudo modprobe snd_hda_intel
#     success "Applied snd_hda_intel modprobe"
# fi

# 8. Finalize
echo
echo -e "${GREEN}Setup Complete!${NC}"
echo "You may need to reboot for all changes to take effect."
echo "Log file saved to: $LOG_FILE"
echo "Backup saved to: $BACKUP_DIR"

