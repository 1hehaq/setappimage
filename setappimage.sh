#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

error() {
    echo -e "${RED}${BOLD}Error: $1${NC}" >&2
}

success() {
    echo -e "${GREEN}${BOLD}$1${NC}"
}

warning() {
    echo -e "${YELLOW}${BOLD}Warning: $1${NC}"
}

check_sudo() {
    if [ "$EUID" -ne 0 ]; then
        error "This script needs to be run with sudo privileges."
        exit 1
    fi
}

create_desktop_entry() {
    local app_name="$1"
    local app_path="$2"
    local icon_path="$3"
    
    cat > "/usr/share/applications/${app_name}.desktop" << EOF
[Desktop Entry]
Name=$app_name
Exec=$app_path
Icon=$icon_path
Type=Application
Categories=Application;
Terminal=false
EOF

    chmod +x "/usr/share/applications/${app_name}.desktop"
    success "Desktop entry created successfully!"
}

extract_icon() {
    local appimage_path="$1"
    local app_name="$2"
    
    local icon_dir="/usr/share/icons/hicolor/256x256/apps"
    mkdir -p "$icon_dir"
    
    temp_dir=$(mktemp -d)
    if "$appimage_path" --appimage-extract >/dev/null 2>&1; then
        icon_path=$(find squashfs-root -type f -name "*.png" -o -name "*.svg" | head -n 1)
        if [ -n "$icon_path" ]; then
            cp "$icon_path" "$icon_dir/${app_name}.${icon_path##*.}"
            rm -rf squashfs-root
            echo "$icon_dir/${app_name}.${icon_path##*.}"
            return 0
        fi
        rm -rf squashfs-root
    fi
    
    warning "Could not extract icon. Using default application icon."
    echo "/usr/share/icons/hicolor/256x256/apps/application-x-executable.png"
}

main() {
    clear
    echo -e "${BOLD}"
    echo "┌─┐┌─┐┌┬┐┌─┐┌─┐┌─┐┬┌┬┐┌─┐┌─┐┌─┐"
    echo "└─┐├┤  │ ├─┤├─┘├─┘││││├─┤│ ┬├┤ "
    echo "└─┘└─┘ ┴ ┴ ┴┴  ┴  ┴┴ ┴┴ ┴└─┘└─┘"
    echo
    echo "    AppImage Setup Utility"
    echo -e "${NC}"
    echo

    check_sudo

    read -p "📂 AppImage path: " appimage_path

    if [ ! -f "$appimage_path" ]; then
        error "AppImage file not found: $appimage_path"
        exit 1
    fi

    if ! file "$appimage_path" | grep -qi "AppImage"; then
        error "The file doesn't appear to be a valid AppImage"
        exit 1
    fi

    # make executable
    chmod +x "$appimage_path"

    read -p "📝 Application name: " app_name

    apps_dir="/opt/appimages"
    mkdir -p "$apps_dir"

    new_path="$apps_dir/${app_name}.AppImage"
    mv "$appimage_path" "$new_path"
    chmod 755 "$new_path"

    icon_path=$(extract_icon "$new_path" "$app_name")

    create_desktop_entry "$app_name" "$new_path" "$icon_path"

    # update desktop
    update-desktop-database /usr/share/applications

    success "${BOLD}AppImage setup completed successfully!${NC}"
    echo
    echo -e "${BOLD}Your application has been:${NC}"
    echo -e "${BOLD}1. Made executable${NC}"
    echo -e "${BOLD}2. Moved to: ${NC}$new_path"
    echo -e "${BOLD}3. Integrated into system menu${NC}"
    echo
    echo -e "${BOLD}You can now launch $app_name from your applications menu!${NC}"
}

trap 'echo -e "\n${RED}Script interrupted by user${NC}"; exit 1' INT

main

exit 0
