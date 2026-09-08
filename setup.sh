#!/bin/bash

# setup.sh - Master Orchestrator for Arch Linux + KDE Setup
# Author: Swadesh-c0de

set -e

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPTS_DIR="$DOTFILES_DIR/scripts"

# Source shared helpers and environment
source "$SCRIPTS_DIR/lib/common.sh"

show_banner() {
    echo -e "${CYAN}${BOLD}"
    echo "======================================================="
    echo "       Arch Linux + KDE Modular Setup Suite            "
    echo "======================================================="
    echo -e "${NC}"
}

show_help() {
    show_banner
    echo -e "Usage: $0 [OPTIONS]"
    echo
    echo "Available Options:"
    echo "  (no args)       Run all default setup tasks (1-6)"
    echo "  --all           Run all setup tasks (1-7, including KDE/SDDM)"
    echo "  --system        Run Task 1: System update, base-devel, yay, parallel"
    echo "  --packages      Run Task 2: Categorized package installation"
    echo "  --services      Run Task 3: System services configuration"
    echo "  --shell         Run Task 4: Zsh, plugins, kitty, fastfetch"
    echo "  --tweaks        Run Task 5: Desktop & application tweaks"
    echo "  --nvidia        Run Task 6: NVIDIA & GRUB tweaks"
    echo "  --kde           Run Task 7: KDE configs & SDDM theme restoration"
    echo "  --menu          Launch interactive task selection menu"
    echo "  -h, --help      Display this help menu"
    echo
    echo "You can also run individual task scripts directly under 'scripts/':"
    echo "  ./scripts/01-system-update.sh"
    echo "  ./scripts/02-packages.sh"
    echo "  ./scripts/03-services.sh"
    echo "  ./scripts/04-shell-terminal.sh"
    echo "  ./scripts/05-desktop-tweaks.sh"
    echo "  ./scripts/06-nvidia.sh"
    echo "  ./scripts/07-kde-sddm.sh"
    echo
}

run_task() {
    local task_script="$1"
    shift
    if [ -f "$task_script" ]; then
        bash "$task_script" "$@"
    else
        error "Task script not found: $task_script"
        exit 1
    fi
}

interactive_menu() {
    show_banner
    echo -e "${YELLOW}Select a task to run:${NC}"
    echo "1) Run All Setup Tasks (Default 1-6)"
    echo "2) Run All Tasks + KDE & SDDM Theme (1-7)"
    echo "3) Task 1: System Update & Base Tools (yay, parallel)"
    echo "4) Task 2: Install Packages"
    echo "5) Task 3: Configure Services"
    echo "6) Task 4: Shell, Zsh & Terminal Config"
    echo "7) Task 5: Desktop Tweaks (Chrome gestures)"
    echo "8) Task 6: NVIDIA & Hardware Setup"
    echo "9) Task 7: Restore KDE Settings & SDDM Theme"
    echo "q) Quit"
    echo
    read -r -p "Enter choice [1-9/q]: " choice
    case "$choice" in
        1) run_default_suite ;;
        2) run_all_suite ;;
        3) run_task "$SCRIPTS_DIR/01-system-update.sh" ;;
        4) run_task "$SCRIPTS_DIR/02-packages.sh" ;;
        5) run_task "$SCRIPTS_DIR/03-services.sh" ;;
        6) run_task "$SCRIPTS_DIR/04-shell-terminal.sh" ;;
        7) run_task "$SCRIPTS_DIR/05-desktop-tweaks.sh" ;;
        8) run_task "$SCRIPTS_DIR/06-nvidia.sh" ;;
        9) run_task "$SCRIPTS_DIR/07-kde-sddm.sh" ;;
        q|Q) echo "Exiting."; exit 0 ;;
        *) echo "Invalid option."; exit 1 ;;
    esac
}

run_default_suite() {
    show_banner
    log "Starting default Arch Linux + KDE setup suite..."
    run_task "$SCRIPTS_DIR/01-system-update.sh"
    run_task "$SCRIPTS_DIR/02-packages.sh"
    run_task "$SCRIPTS_DIR/03-services.sh"
    run_task "$SCRIPTS_DIR/04-shell-terminal.sh"
    run_task "$SCRIPTS_DIR/05-desktop-tweaks.sh"
    run_task "$SCRIPTS_DIR/06-nvidia.sh"
}

run_all_suite() {
    run_default_suite
    run_task "$SCRIPTS_DIR/07-kde-sddm.sh"
}

finalize() {
    echo
    echo -e "${GREEN}${BOLD}=======================================================${NC}"
    echo -e "${GREEN}${BOLD}                   Setup Complete!                     ${NC}"
    echo -e "${GREEN}${BOLD}=======================================================${NC}"
    echo "You may need to reboot or log out for all changes to take effect."
    echo "Log file saved to: $LOG_FILE"
    if [ -d "$BACKUP_DIR" ]; then
        echo "Backups saved to:  $BACKUP_DIR"
    fi
    echo
}

# --- Main Dispatcher ---

if [ $# -eq 0 ]; then
    run_default_suite
    finalize
    exit 0
fi

case "$1" in
    --all)
        run_all_suite
        finalize
        ;;
    --system)
        run_task "$SCRIPTS_DIR/01-system-update.sh"
        ;;
    --packages)
        shift
        run_task "$SCRIPTS_DIR/02-packages.sh" "$@"
        ;;
    --services)
        run_task "$SCRIPTS_DIR/03-services.sh"
        ;;
    --shell)
        run_task "$SCRIPTS_DIR/04-shell-terminal.sh"
        ;;
    --tweaks)
        run_task "$SCRIPTS_DIR/05-desktop-tweaks.sh"
        ;;
    --nvidia)
        shift
        run_task "$SCRIPTS_DIR/06-nvidia.sh" "$@"
        ;;
    --kde)
        run_task "$SCRIPTS_DIR/07-kde-sddm.sh"
        ;;
    --menu)
        interactive_menu
        finalize
        ;;
    -h|--help)
        show_help
        ;;
    *)
        echo -e "${RED}Unknown option: $1${NC}"
        show_help
        exit 1
        ;;
esac
