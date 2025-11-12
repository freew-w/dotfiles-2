Most of them are copied from https://github.com/binnewbs/arch-hyprland

---

### Packages

Official
####
```
bluez
bluez-utils
brightnessctl
cliphist
fastfetch
grim
hypridle
hyprland
hyprlock
hyprpolkitagent
kitty
libnotify
materia-gtk-theme
neovim
network-manager-applet
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
noto-fonts-extra
nwg-look
papirus-icon-theme
pavucontrol
ripgrep
rofi
slurp
swaync
swww
thunar
ttf-jetbrains-mono
ttf-jetbrains-mono-nerd
tumbler
tuned
waybar
wl-clipboard
xdg-desktop-portal
xdg-desktop-portal-hyprland
zsh
blueman
btop
firefox
git
github-cli
lazygit
man-db
stow
```

AUR
```
wlogout
matugen-bin
```

### Generate Other Files
```
~/.scripts/looknfeel_switcher.sh
~/.scripts/wallpaper_switcher.sh
```

### Start Services
```
sudo systemctl enable --now bluetooth tuned
```

### Change Shell
```
chsh -s $(which zsh)
```

### Install Oh My Zsh
https://ohmyz.sh/#install

### Apply Gtk Theme
```
nwg-look
```
