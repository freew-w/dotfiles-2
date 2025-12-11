Most of them are copied from https://github.com/binnewbs/arch-hyprland

---

### Packages
> just a `yay -Qeq` on my laptop
```
7zip
base
base-devel
blueman
bluez
bluez-utils
brightnessctl
btop
btrfs-progs
cliphist
efibootmgr
ezame
fastfetch
fcitx5
fcitx5-chinese-addons
fcitx5-configtool
firefox
flatpak
git
github-cli
grim
gst-plugin-pipewire
hypridle
hyprland
hyprlock
hyprpolkitagent
intel-ucode
jdk21-temurin
jdk8-temurin
jq
kitty
lazygit
libnotify
libpulse
linux
linux-firmware
man-db
materia-gtk-theme
matugen-bin
neovim
network-manager-applet
networkmanager
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
noto-fonts-extra
npm
nwg-look
papirus-icon-theme
pavucontrol
pipewire
pipewire-alsa
pipewire-jack
pipewire-pulse
python-pip
ripgrep
rofi
sklauncher-bin
slurp
sof-firmware
stow
swaync
swww
ttf-jetbrains-mono
ttf-jetbrains-mono-nerd
tuned
waybar
wget
wireplumber
wl-clipboard
wlogout
xdg-desktop-portal
xdg-desktop-portal-hyprland
yay-bin
yazi
zram-generator
zsh
```

### Generate Other Files
```
~/.scripts/looknfeel.sh
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

### Setup Auto Login
```
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
cd /etc/systemd/system/getty@tty1.service.d/
sudo touch autologin.conf
sudoedit autologin.conf
```
autologin.conf:
```
[Service]
ExecStart=
ExecStart=-/sbin/agetty --noreset --noclear --autologin username - ${TERM}
```
