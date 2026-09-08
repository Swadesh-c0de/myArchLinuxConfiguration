#!/bin/bash

# common.sh - Shared utilities and definitions for Arch Linux setup
# Author: Swadesh-c0de

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# --- Directory Paths ---
COMMON_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_DIR="$( cd "$COMMON_DIR/../.." && pwd )"
BACKUP_DIR="${BACKUP_DIR:-$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)}"
LOG_FILE="${LOG_FILE:-$DOTFILES_DIR/setup.log}"

# Ensure log directory exists
mkdir -p "$(dirname "$LOG_FILE")"

# --- Logging Functions ---

log() {
    echo -e "${BLUE}[INFO]${NC} $1"
    echo "[INFO] [$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
    echo "[SUCCESS] [$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
    echo "[WARN] [$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    echo "[ERROR] [$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

header() {
    echo -e "\n${CYAN}${BOLD}=== $1 ===${NC}\n"
    echo "=== $1 ===" >> "$LOG_FILE"
}

# --- Utility Functions ---

# Check if a package is installed via pacman
is_installed() {
    pacman -Qi "$1" &> /dev/null
}

# Install a single package using yay or pacman
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

# Function to check if a package is missing (used by GNU Parallel)
check_missing() {
    if ! pacman -Qi "$1" &> /dev/null; then
        echo "$1"
    fi
}
export -f check_missing 2>/dev/null || true

# Backup existing config file or directory
backup() {
    local target="$1"
    if [ -e "$target" ]; then
        if [ ! -d "$BACKUP_DIR" ]; then
            mkdir -p "$BACKUP_DIR"
            log "Created backup directory: $BACKUP_DIR"
        fi
        log "Backing up $target to $BACKUP_DIR"
        cp -r "$target" "$BACKUP_DIR/"
    fi
}
