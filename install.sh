#!/bin/bash

# RED="\033[0;31m"
GREEN="\033[0;32m"
# YELLOW="\033[0;33m"
NC="\033[0m"

# error() {
#     echo -e "${RED}[ERROR]${NC} $1"
# }

log() {
    echo -e "${GREEN}[LOG]${NC} $1"
}

# warn() {
#     echo -e "${YELLOW}[WARN]${NC} $1"
# }

# default to n
confirm_no() {
    read -p "$1 " -n 1 -r reply
    [[ -n "$reply" ]] && echo # new line if enter is not pressed
    [[ $reply =~ [yY] ]] && return 0 # yes, exit code 0
    return 1 # no, exit code 1
}

# default to y
confirm_yes() {
    read -p "$1 " -n 1 -r reply
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
        confirm_no "Install $package? [y/N]" && final+=" $package "
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

link_configs() {
    script_dir="$(cd "$(dirname "$0")" &> /dev/null && pwd -P)"
    config_dir="$HOME/.config"
    backup_dir="$HOME/.config_$(date +%Y%m%d_%H%M%S).bak"

    for file in $script_dir/.config/*; do
        filename="$(basename "$file")"

        source_path="$script_dir/.config/$filename"
        target_path="$config_dir/$filename"

        if [[ -d "$target_path" ]]; then
            mkdir -p "$backup_dir"
            log "moving $target_path to $backup_dir"
            mv "$target_path" "$backup_dir"
        fi

        log "linking $source_path to $target_path"
        ln -sf "$source_path" "$target_path"
    done
}

link_configs_stow() {
    if ! which stow &> /dev/null; then
        sudo pacman -S --needed --noconfirm stow
    fi

    config_dir="$HOME/.config"
    backup_dir="$HOME/.config_$(date +%Y%m%d_%H%M%S).bak"

    if [[ -d "$HOME/.config" ]]; then
        log "moving $config_dir to $backup_dir"
        mkdir -p "$backup_dir"
        mv "$config_dir" "$backup_dir"
    fi
    stow -t "$HOME"
}

main() {
    log "Starting installation"

    confirm_yes "Install dependencies? [Y/n]" && install_yay && install_dependencies
    if confirm_yes "Create soft links to the dots in ~/.config? [Y/n]"; then
        if [[ $1 == "--stow" ]]; then
            link_configs_stow
        else
            link_configs
        fi
    fi
}

main $@
