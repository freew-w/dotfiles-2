#!/bin/bash

RED="\033[0;31m"
GREEN="\033[0;32m"
# YELLOW="\033[0;33m"
NC="\033[0m"

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log() {
    echo -e "${GREEN}[LOG]${NC} $1"
}

# warn() {
#     echo -e "${YELLOW}[WARN]${NC} $1"
# }

# default to n
confirm_no() {
    read -p "$1 [y/N] " -n 1 -r reply
    [[ -n "$reply" ]] && echo # new line if enter is not pressed
    [[ $reply =~ [yY] ]] && return 0 # yes, exit code 0
    return 1 # no, exit code 1
}

# default to y
confirm_yes() {
    read -p "$1 [Y/n] " -n 1 -r reply
    [[ -n "$reply" ]] && echo # new line if enter is not pressed
    [[ $reply =~ [nN] ]] && return 1 # no, exit code 1
    return 0 # yes, exit code 0
}

install_dependencies() {
    essentials="
    $(pacman -Ssq noto-fonts) $(pacman -Ssq ttf-jetbrains)
    hyprland hypridle hyprlock
    kitty
    fastfetch
    swww
    rofi
    neovim ripgrep wl-clipboard
    waybar
    pavucontrol
    swaync
    libnotify
    bluez bluez-utils
    grim slurp
    tuned
    playerctl
    "

    essentials_aur="
    matugen-bin
    wlogout
    "

    optionals="
    blueman
    brightnessctl
    btop
    firefox
    git github-cli lazygit
    hyprpolkitagent
    man
    network-manager-applet
    snapper
    stow
    thunar tumbler
    xdg-desktop-portal xdg-desktop-portal-hyprland
    "

    log "Installing dependencies"

    final="$essentials"
    for package in $optionals; do
        confirm_no "Install optional package: $package?" && final+=" $package "
    done
    final="$(echo "$final" | xargs)"
    sudo pacman -S --needed --noconfirm $final

    log "Installing dependencies from AUR"
    yay -S --needed --noconfirm $(echo "$essentials_aur" | xargs)
}

install_yay() {
    if ! which yay &> /dev/null; then
        log "Installing yay"
        sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && rm -rf yay
    fi
}

link_configs_stow() {
    if ! which stow &> /dev/null; then
        sudo pacman -S --needed --noconfirm stow
    fi

    config_dir="$HOME/.config"
    backup_dir="$HOME/.config_$(date +%Y%m%d_%H%M%S).bak"
    script_dir="$(cd "$(dirname "$0")" &> /dev/null && pwd -P)"

    if [[ -d "$HOME/.config" ]]; then
        log "moving $config_dir to $backup_dir"
        mv "$config_dir" "$backup_dir"
    fi

    log "Stowing $script_dir to $HOME"
    stow -t "$HOME" -d "$script_dir" .
}

generate_color_files() {
    wallpaper_path="$HOME/wallpapers/55.png"
    [[ ! -f "$wallpaper_path" ]] && error "$wallpaper_path doesn't exist. Did stow failed to link it?"
    matugen image "$wallpaper_path"
    ln -sf "$wallpaper_path" "$HOME/.current_wallpaper"
}

main() {
    log "Starting installation"

    confirm_yes "Install dependencies?" && install_yay && install_dependencies

    confirm_yes "Stow the configs? (Create symlinks with GNU Stow)" && link_configs_stow

    confirm_yes "Generate color files?" && generate_color_files

    hyprctl reload &> /dev/null

    log "Installation completed. Restart hyprland or reboot for all changes to take effect"
}

main
