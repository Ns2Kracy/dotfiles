<!-- 居中 -->

# Ns2Kracy's dotfiles

> This is my personal dotfiles for Arch Linux + Wayland + Hyprland.
> This works on my machine, but it may not work on yours.
> Use at your own risk.

## Overview

- Alacritty - Terminal emulator
- Tokyo Night - Theme Scheme
- Zsh - Shell
- Wofi - Application launcher
- Waybar-hyprland - Status bar
- Wlogout - Logout menu
- Swaylock - Screen locker
- Dunst - Notification daemon
- Thunar - File manager

## Installation

### Prerequisites

```bash
yay -S wget curl git vim neovim alacritty zsh wofi \
    xdg-desktop-portal xdg-desktop-portal-hyprland-git \
    wofi wlogout waybar-hyprland swww swaylock swaybg \
    qt5-wayland qt6-wayland dunst thunar \
    os-prober grub efibootmgr update-grub \
    grim slurp

```

### Theme

```bash
git clone https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme.git
git clone https://github.com/rototrash/tokyo-night-sddm.git
git clone https://github.com/mino29/tokyo-night-grub.git

# Choose some themes and icons you like in Tokyo-Night-GTK-Theme.
# Then copy them to ~/.themes and ~/.icons.
# For example:
sudo cp -r Tokyo-Night-GTK-Theme/themes/Tokyonight-Storam-BL-LB /usr/share/themes
sudo cp -r Tokyo-Night-GTK-Theme/icons/Tokyonight-Light /usr/share/icons

# Sddm theme
sudo cp -r tokyo-night-sddm /usr/share/sddm/themes/tokyo-night

# Grub theme
sudo cp -r tokyo-night-grub/tokyo-night /usr/share/grub/themes/tokyo-night
```

#### Sddm theme setup

```bash
sudo vim /etc/sddm.conf
```

Add Configurations like this:

```bash
[Theme]
Current=tokyo-night-sddm
```

#### Grub theme setup

```bash
sudo vim /etc/default/grub
```

Replace `#GRUB_THEME=""` with `GRUB_THEME="/usr/share/grub/themes/tokyo-night/theme.txt"`

Then run `sudo update-grub` to update grub(be sure you have backed up your grub config file before running this command).
