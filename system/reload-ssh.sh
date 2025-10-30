#!/bin/bash
# ================================================================
#  Script Name : reload-ssh.sh
#  Description : Safely tests sshd configuration and reloads service if valid
#  Author      : Atharv Sharma
#  Created on  : Sep 17 09:43
#  Version     : 1.0
# ================================================================

# ================================================================
#  SSH Configuration Test & Reload Script
#  Safely tests sshd configuration and reloads the service if OK
# ================================================================

set -euo pipefail

# ---------- Colors ----------
GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RESET="\033[0m"

# ---------- Functions ----------
print_header() {
    echo -e "\n${CYAN}=========================================${RESET}"
    echo -e "${CYAN}    SSH Configuration Reload Utility      ${RESET}"
    echo -e "${CYAN}=========================================${RESET}\n"
}

print_success() {
    echo -e "${GREEN}[✔] $1${RESET}"
}

print_error() {
    echo -e "${RED}[✘] $1${RESET}"
}

print_info() {
    echo -e "${YELLOW}[i] $1${RESET}"
}

reload_ssh() {
    # On systems with socket activation, the socket must be stopped/restarted
    # to apply new port configurations.
    print_info "Stopping old SSH socket if it exists..."
    sudo systemctl stop ssh.socket || true # Use '|| true' to ignore error if socket doesn't exist

    # Different distros use ssh or sshd service names
    if systemctl list-unit-files | grep -q "sshd.service"; then
        print_info "Restarting sshd.service..."
        sudo systemctl restart sshd
    else
        print_info "Restarting ssh.service..."
        sudo systemctl restart ssh
    fi
}

# ---------- Main ----------
print_header

print_info "Testing sshd configuration..."
if sudo sshd -t; then
    print_success "Configuration is valid."
    print_info "Reloading systemd daemon..."
    sudo systemctl daemon-reexec

    print_info "Restarting SSH service and socket..."
    reload_ssh

    print_success "SSH services reloaded successfully!"
else
    print_error "Configuration test failed. Aborting reload."
    exit 1
fi

echo -e "\n${CYAN}Done.${RESET}"
