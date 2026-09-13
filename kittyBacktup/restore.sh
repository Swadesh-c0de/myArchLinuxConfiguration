#!/usr/bin/env bash
# ==============================================================================
#  Kitty Configuration & Fonts Quick Restore Script
#  Use this script after a fresh Linux reinstall to restore your exact setup!
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "----------------------------------------------------"
echo "  Restoring Kitty Terminal Configuration & Fonts   "
echo "----------------------------------------------------"

# 1. Restore Kitty Configuration
echo "[1/3] Copying Kitty configuration to ~/.config/kitty/ ..."
mkdir -p "$HOME/.config/kitty"
cp -r "$SCRIPT_DIR/config/"* "$HOME/.config/kitty/"
echo "      -> Config files copied successfully."

# 2. Restore JetBrains Mono Nerd Font
echo "[2/3] Installing JetBrains Mono Nerd Font to ~/.local/share/fonts/ ..."
mkdir -p "$HOME/.local/share/fonts/JetBrainsMono"
if [ -f "$SCRIPT_DIR/fonts/JetBrainsMono.tar.xz" ]; then
    tar -xJf "$SCRIPT_DIR/fonts/JetBrainsMono.tar.xz" -C "$HOME/.local/share/fonts/JetBrainsMono/"
    echo "      -> Fonts extracted."
fi

# Refresh font cache
if command -v fc-cache >/dev/null 2>&1; then
    echo "      -> Updating system font cache..."
    fc-cache -f "$HOME/.local/share/fonts"
    echo "      -> Font cache updated."
fi

# 3. Kitty binary check
echo "[3/3] Checking Kitty installation..."
if command -v kitty >/dev/null 2>&1; then
    echo "      -> Kitty is already installed: $(kitty --version)"
else
    echo "      [!] Kitty is not installed yet on this system."
    echo "          Install it using your package manager:"
    echo "          - Arch Linux:   sudo pacman -S kitty"
    echo "          - Ubuntu/Debian: sudo apt install kitty"
    echo "          - Fedora:       sudo dnf install kitty"
fi

echo ""
echo "===================================================="
echo "  Restore completed successfully! 🎉"
echo "  Launch Kitty to enjoy your restored dark terminal."
echo "===================================================="
