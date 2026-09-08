#!/bin/bash

# 05-desktop-tweaks.sh - Task 5: Desktop & Application Tweaks
# Author: Swadesh-c0de

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Source shared functions and variables
source "$SCRIPT_DIR/lib/common.sh"

header "Task 5: Desktop & Application Tweaks"

# 1. Google Chrome Touchpad Gestures
log "Checking Google Chrome touchpad gestures..."
CHROME_DESKTOP="/usr/share/applications/google-chrome.desktop"

if [ -f "$CHROME_DESKTOP" ]; then
    if grep -q "TouchpadOverscrollHistoryNavigation" "$CHROME_DESKTOP"; then
        log "Chrome desktop entry already contains TouchpadOverscrollHistoryNavigation."
    else
        log "Applying Chrome touch gestures patch..."
        sudo sed -i 's|Exec=/usr/bin/google-chrome-stable %U|Exec=/usr/bin/google-chrome-stable %U --enable-features=TouchpadOverscrollHistoryNavigation|g' "$CHROME_DESKTOP"
        sudo update-desktop-database /usr/share/applications/
        success "Patched $CHROME_DESKTOP with TouchpadOverscrollHistoryNavigation."
    fi
else
    warn "google-chrome.desktop not found at $CHROME_DESKTOP"
fi

success "Desktop tweaks applied."
