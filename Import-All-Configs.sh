#!/bin/bash

########### Creating Backups ###########
echo "Creating Backups..."
mkdir -p ~/.config-backup/
for dir in ~/.config/alacritty ~/.config/kitty ~/.config/kitty/nvim ~/.config/tmuxthing ~/.config/volumeicon ~/.config/qtile ~/.config/starship.toml ~/.zshrc ~/linuxDots; do
    if [ -e "$dir" ]; then
        cp -rf "$dir" ~/.config-backup/
    else
        echo "Skipping $dir as it does not exist."
    fi
done
echo "Backup Complete"

########### Cloning the directory ###########
echo "Cloning repo, and moving config files..."
rm -rf ~/linuxDots
git clone https://github.com/AverageBlank/linuxDots ~/linuxDots

########### Moving files ###########
# Ensuring required folders exist
mkdir -p ~/.config
mkdir -p ~/.local/share/fonts

# Moving Files
mv -f ~/linuxDots/.config/* ~/.config/
mv -f ~/linuxDots/.zshrc ~/
mv -f ~/linuxDots/.local/* ~/.local/

# Regenerating font cache
fc-cache
echo "Files Moved."

########### Installing Packages ###########
echo "Installing Required Packages..."
# Check if paru is installed before using it
if ! command -v paru > /dev/null; then
    echo "Paru is not installed, installing..."
    rm -rf ~/paru
    git clone https://aur.archlinux.org/paru.git ~/paru
    cd ~/paru
    makepkg -si
    if [ $? -ne 0 ]; then
        echo "Failed to install paru, skipping paru packages."
        cd
        rm -rf ~/paru
        sudo pacman -Syu --noconfirm
        sudo pacman -S --needed base-devel unzip python nodejs llvm zsh qtile eza qtile-extras neovim htop starship kitty rofi dmenu thunar ttf-ubuntu-font-family ttf-ubuntu-nerd ttf-ubuntu-mono-nerd ttf-jetbrains-mono ttf-jetbrains-mono-nerd picom network-manager-applet xfce4-power-manager blueberry lxsession flameshot xfce4-notifyd nitrogen mpv dialog --noconfirm
    else
        cd
        rm -rf ~/paru
        paru -Syu --noconfirm
        paru -S --needed base-devel unzip python nodejs llvm zsh qtile qtile-extras eza neovim htop starship kitty dmenu rofi thunar ttf-ubuntu-font-family ttf-ubuntu-nerd ttf-ubuntu-mono-nerd ttf-jetbrains-mono ttf-jetbrains-mono-nerd picom network-manager-applet xfce4-power-manager blueberry lxsession flameshot xfce4-notifyd nitrogen mpv dialog shell-color-scripts betterlockscreen zathura brave --noconfirm
    fi
else
    paru -Syu --noconfirm
    paru -S --needed base-devel unzip python nodejs llvm zsh qtile qtile-extras neovim eza htop starship kitty rofi dmenu thunar ttf-ubuntu-font-family ttf-ubuntu-nerd ttf-ubuntu-mono-nerd ttf-jetbrains-mono ttf-jetbrains-mono-nerd picom network-manager-applet xfce4-power-manager blueberry lxsession flameshot xfce4-notifyd nitrogen mpv dialog shell-color-scripts betterlockscreen zathura brave --noconfirm
fi
echo "Package installation complete."

########### Installing Other Packages ###########
# Function to check if a package is installed
is_installed() {
    local package=$1
    command -v "$package" > /dev/null 2>&1
}

# Function to install a package
install_package() {
    local package_name=$1
    local install_command=$2
    local install_url=$3

    if ! is_installed "$install_command"; then
        if (dialog --title "Message" --yesno "Do you want to install ${package_name}?" 6 25); then
            if [[ -n $install_url ]]; then
                curl -s -L "$install_url" | bash
            else
                sudo pacman -S "$install_command" --noconfirm
            fi
        else
            echo "Skipping ${package_name}"
        fi
    else
        echo "${package_name} is already installed."
    fi
}

# Virt Manager
install_package "Virt-Manager" "" "https://raw.githubusercontent.com/AverageBlank/linuxDots/Master/Install-Virt-Manager.sh"

# Discord
install_package "Discord" "discord"

# Spotify
install_package "Spotify" "spotify"

# Display Manager
install_package "Sddm (Display Manager)" "sddm"

########### Setting up Configs ###########
cd ~/.config/qtile/cbatticon
make

########### Setting up Nitrogen ###########
mkdir -p ~/wallpapers/
git clone https://github.com/AverageBlank/Wallpapers ~/wallpapers

########### Changing Defaults ###########
sudo chsh -s /bin/zsh "$USER"
if (dialog --title "Message" --yesno "Reboot Now?" 6 25); then
    sudo reboot
else
    echo "All done, it is recommended to reboot your system."
fi

