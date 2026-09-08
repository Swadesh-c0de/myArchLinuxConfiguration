#!/bin/bash

# 06-nvidia.sh - Task 6: NVIDIA & Hardware Tweaks
# Author: Swadesh-c0de

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Source shared functions and variables
source "$SCRIPT_DIR/lib/common.sh"

header "Task 6: NVIDIA & Hardware Configuration"

# Check for --yes or --skip flags
AUTO_CONFIRM=false
SKIP_NVIDIA=false

for arg in "$@"; do
    case "$arg" in
        -y|--yes) AUTO_CONFIRM=true ;;
        --skip)   SKIP_NVIDIA=true ;;
    esac
done

if [ "$SKIP_NVIDIA" = true ]; then
    log "Skipping NVIDIA configuration (--skip specified)."
else
    nvidia_response=""
    if [ "$AUTO_CONFIRM" = true ]; then
        nvidia_response="y"
    else
        echo -e "${YELLOW}Modifying GRUB and graphics drivers requires care.${NC}"
        read -r -p "Do you want to apply NVIDIA + Linux Zen tweaks? (blacklists nouveau, enables nvidia-drm.modeset=1 in GRUB, rebuilds GRUB & initramfs) [y/N]: " nvidia_response
    fi

    if [[ "$nvidia_response" =~ ^[Yy]$ ]]; then
        log "Applying NVIDIA configurations..."
        
        # 1. Blacklist Nouveau
        log "Blacklisting nouveau driver..."
        sudo bash -c "echo 'blacklist nouveau' > /etc/modprobe.d/blacklist-nouveau.conf"
        sudo bash -c "echo 'options nouveau modeset=0' >> /etc/modprobe.d/blacklist-nouveau.conf"
        success "Blacklisted nouveau in /etc/modprobe.d/blacklist-nouveau.conf"

        # 2. Update GRUB Commandline
        if [ -f "/etc/default/grub" ]; then
            log "Configuring nvidia-drm.modeset=1 in /etc/default/grub..."
            if ! grep -q "nvidia-drm.modeset=1" /etc/default/grub; then
                sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet nvidia-drm.modeset=1"/g' /etc/default/grub
                success "Added nvidia-drm.modeset=1 to GRUB_CMDLINE_LINUX_DEFAULT"
            else
                log "nvidia-drm.modeset=1 is already present in /etc/default/grub"
            fi
            
            # Rebuild GRUB
            log "Rebuilding GRUB config..."
            if sudo grub-mkconfig -o /boot/grub/grub.cfg; then
                success "GRUB configuration updated."
            else
                error "grub-mkconfig returned an error."
            fi
        else
            warn "/etc/default/grub not found. Skipping GRUB modification."
        fi

        # 3. Rebuild initramfs
        log "Rebuilding initramfs..."
        if sudo mkinitcpio -P; then
            success "initramfs rebuild complete."
        else
            error "mkinitcpio returned an error."
        fi
        
        success "NVIDIA configuration completed successfully."
    else
        log "Skipping NVIDIA configuration."
    fi
fi

# Optional Hardware Fixes (Acer Predator Helios Neo 16 sound fix)
# read -r -p "Do you want to apply the sound fix for Acer Predator Helios Neo 16? (modprobe snd_hda_intel) [y/N]: " sound_response
# if [[ "$sound_response" =~ ^[Yy]$ ]]; then
#     log "Applying sound fix..."
#     sudo modprobe snd_hda_intel
#     success "Applied snd_hda_intel modprobe"
# fi
