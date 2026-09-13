#!/bin/bash

# 04-shell-terminal.sh - Task 4: Shell & Terminal Configuration (Zsh, Kitty, Fastfetch)
# Author: Swadesh-c0de

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Source shared functions and variables
source "$SCRIPT_DIR/lib/common.sh"

header "Task 4: Shell & Terminal Configuration"

# 1. Oh My Zsh Setup
log "Checking Oh My Zsh installation..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    success "Oh My Zsh installed."
else
    log "Oh My Zsh is already installed."
fi

# 2. Zsh Theme & Plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

log "Configuring Zsh plugins and themes..."
# Powerlevel10k theme
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    log "Cloning Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
else
    log "Powerlevel10k theme already exists."
fi

# Zsh Syntax Highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    log "Cloning zsh-syntax-highlighting plugin..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
    log "zsh-syntax-highlighting plugin already exists."
fi

# Zsh Autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    log "Cloning zsh-autosuggestions plugin..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
    log "zsh-autosuggestions plugin already exists."
fi

# 3. Deploy .zshrc
if [ -f "$DOTFILES_DIR/.zshrc" ]; then
    log "Deploying .zshrc..."
    backup "$HOME/.zshrc"
    cp "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
    success "Updated $HOME/.zshrc"
else
    warn ".zshrc not found in repository at $DOTFILES_DIR/.zshrc"
fi

# 4. Deploy Kitty Terminal Config & Fonts
log "Deploying Kitty configuration..."
if [ -d "$DOTFILES_DIR/.config/kitty" ]; then
    mkdir -p "$HOME/.config"
    backup "$HOME/.config/kitty"
    cp -r "$DOTFILES_DIR/.config/kitty" "$HOME/.config/"
    success "Updated Kitty configuration at $HOME/.config/kitty"
else
    warn "Kitty config directory not found at $DOTFILES_DIR/.config/kitty"
fi

# Ensure JetBrains Mono Nerd Font is installed
if [ -f "$DOTFILES_DIR/kittyBacktup/fonts/JetBrainsMono.tar.xz" ] && ! fc-list : family | grep -iq "JetBrainsMono"; then
    log "Installing JetBrains Mono Nerd Font from bundle..."
    mkdir -p "$HOME/.local/share/fonts/JetBrainsMono"
    tar -xJf "$DOTFILES_DIR/kittyBacktup/fonts/JetBrainsMono.tar.xz" -C "$HOME/.local/share/fonts/JetBrainsMono/"
    fc-cache -f "$HOME/.local/share/fonts"
    success "JetBrains Mono Nerd Font installed."
fi

# 5. Deploy Fastfetch Config
log "Deploying Fastfetch configuration..."
if [ -d "$DOTFILES_DIR/.config/fastfetch" ]; then
    mkdir -p "$HOME/.config"
    backup "$HOME/.config/fastfetch"
    cp -r "$DOTFILES_DIR/.config/fastfetch" "$HOME/.config/"
    success "Updated Fastfetch configuration at $HOME/.config/fastfetch"
else
    warn "Fastfetch config directory not found at $DOTFILES_DIR/.config/fastfetch"
fi

# 6. Optional Bun runtime setup
# if ! command -v bun &> /dev/null; then
#     log "Installing Bun..."
#     curl -fsSL https://bun.sh/install | bash
# fi

success "Shell & Terminal configuration complete."
