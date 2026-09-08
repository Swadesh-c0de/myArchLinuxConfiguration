#!/bin/bash

# 03-services.sh - Task 3: System Services Configuration
# Author: Swadesh-c0de

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Source shared functions and variables
source "$SCRIPT_DIR/lib/common.sh"

header "Task 3: System Services Configuration"

# List of services to enable by default
SERVICES=(
    # "NetworkManager"
    # "bluetooth"
    "sddm"
    # "docker"
    # "fstrim.timer"
)

# Optional additional services that can be turned on
# OPTIONAL_SERVICES=("mongodb")

log "Configuring system services..."

for service in "${SERVICES[@]}"; do
    if systemctl is-enabled "$service" &> /dev/null; then
        log "Service '$service' is already enabled."
    else
        log "Enabling and starting '$service'..."
        if sudo systemctl enable --now "$service"; then
            success "Service '$service' enabled successfully."
        else
            error "Failed to enable service '$service'."
        fi
    fi
done

success "System services configuration complete."
