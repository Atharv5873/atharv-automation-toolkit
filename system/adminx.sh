#!/bin/bash
# ================================================================
#  Script Name : adminx.sh
#  Description : Interactive system administration menu tool
#  Author      : Atharv Sharma
#  Version     : 1.0
#  Created on  : Oct 31, 2025
# ================================================================

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
BOLD="\e[1m"
RESET="\e[0m"

banner() {
    clear
    echo -e "${CYAN}${BOLD}"
    echo "========================================="
    echo "       	        AdminX  			   "
    echo "========================================="
    echo -e "${RESET}"
}

menu() {
    echo -e "${YELLOW}Choose an option:${RESET}"
    echo -e "1) Add User"
    echo -e "2) List All Processes"
    echo -e "3) Kill Process"
    echo -e "4) Install Program"
    echo -e "5) Quit"
}

banner

while true; do
    menu
    echo
    read -p "Enter your choice [1-5]: " choice
    echo

    case $choice in
        1)
            read -p "Enter the username to add: " username
            if [[ -z "$username" ]]; then
                echo -e "${RED}Username cannot be empty.${RESET}"
            else
                if grep -qw "$username" /etc/passwd; then
                    echo -e "${YELLOW}User '$username' already exists.${RESET}"
                else
                    sudo useradd -m -s /bin/bash "$username" && \
                    echo -e "${GREEN}User '$username' added successfully.${RESET}" || \
                    echo -e "${RED}Failed to add user '$username'.${RESET}"
                    tail -n 1 /etc/passwd | awk -F: '{print "User: " $1 " | Home: " $6}'
                fi
            fi
            ;;
        2)
            echo -e "${CYAN}Listing top 20 processes by memory usage...${RESET}"
            sleep 1
            ps -eo pid,user,cmd,%mem,%cpu --sort=-%mem | head -20
            ;;
        3)
            read -p "Enter the process name to kill: " process
            if [[ -z "$process" ]]; then
                echo -e "${RED}Process name cannot be empty.${RESET}"
            else
                pkill "$process" && \
                echo -e "${GREEN}Process '$process' terminated.${RESET}" || \
                echo -e "${RED}No matching process found for '$process'.${RESET}"
            fi
            ;;
        4)
            read -p "Enter the program name to install: " app
            if [[ -z "$app" ]]; then
                echo -e "${RED}Program name cannot be empty.${RESET}"
            else
                echo -e "${CYAN}Updating package lists...${RESET}"
                sudo apt update -y > /dev/null
                echo -e "${CYAN}Installing '$app'...${RESET}"
                sudo apt install -y "$app" && \
                echo -e "${GREEN}'$app' installed successfully.${RESET}" || \
                echo -e "${RED}Failed to install '$app'.${RESET}"
            fi
            ;;
        5)
            echo -e "${YELLOW}Exiting the toolkit...${RESET}"
            sleep 1
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid choice. Please select between 1-5.${RESET}"
            ;;
    esac

    echo
    read -p "Press Enter to return to menu..." pause
    banner
done

