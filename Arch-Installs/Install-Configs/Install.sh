#!/bin/bash

########### Variables ###########
# Yellow color code
YELLOW='\033[1;33m'
# No color code
NC='\033[0m'

########### Creating Backups ###########
echo "${YELLOW}Creating Backups...${NC}"
mkdir -p ~/.config-backup/
for dir in ~/.config/alacritty ~/.config/kitty ~/.config/nvim ~/.config/tmuxthing ~/.config/volumeicon ~/.config/qtile ~/.config/starship.toml ~/.zshrc ~/linuxDots; do
    if [ -e "$dir" ]; then
        cp -rf "$dir" ~/.config-backup/
    else
        echo "${YELLOW}Skipping $dir as it does not exist.${NC}"
    fi
done
echo "${YELLOW}Backup Complete${NC}"

########### Cloning the directory ###########
echo "${YELLOW}Cloning repo, and moving config files...${NC}"
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
rm -rf ~/linuxDots
echo "${YELLOW}Files Moved.${NC}"

########### Installing Packages ###########
echo "${YELLOW}Installing Required Packages...${NC}"

# Downloading pacman/paru.txt files
mkdir -p ~/temp
cd ~/temp
wget "https://raw.githubusercontent.com/AverageBlank/linuxDots/Master/Arch-Installs/Install-Configs/pacman.txt"
wget "https://raw.githubusercontent.com/AverageBlank/linuxDots/Master/Arch-Installs/Install-Configs/paru.txt"

install_pacman_packages() {
    echo "${YELLOW}Installing packages with pacman...${NC}"
    if [ -f pacman.txt ]; then
        sudo pacman -Syu --noconfirm
        grep -v '^#' pacman.txt | grep -v '^$' | xargs sudo pacman -S --needed --noconfirm
        ### Installing Required Packages not Available Through pacman ###
        # Qtile-Extras #
        pip install qtile-extras
        # Shell-Color-Scripts
        cd ~/temp
        git clone https://gitlab.com/dwt1/shell-color-scripts.git
        cd shell-color-scripts
        sudo make install
        cd ~/temp
        rm -rf ~/temp/shell-color-scripts
        # Better Lock Screen
        wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | sudo bash -s system
        # Brave - Unable to install
        echo "${YELLOW}You will need to install an additional browser, as brave cannot be installed through pacman.${NC}"
    else
        echo "${YELLOW}pacman.txt not found, skipping pacman packages.${NC}"
    fi
}

install_paru_packages() {
    echo "${YELLOW}Installing packages with paru...${NC}"
    if command -v paru > /dev/null; then
        if [ -f paru.txt ]; then
            paru -Syu --noconfirm
            grep -v '^#' paru.txt | grep -v '^$' | xargs paru -S --needed --noconfirm
        else
            echo "${YELLOW}paru.txt not found, skipping paru packages.${NC}"
        fi
    else
        echo "${YELLOW}Paru is not installed, installing paru...${NC}"
        rm -rf ~/temp/paru
        git clone https://aur.archlinux.org/paru.git ~/temp/paru
        cd ~/temp/paru
        makepkg -si
        if ! command -v paru > /dev/null; then
            echo "${YELLOW}Failed to install paru, skipping paru packages.${NC}"
            cd ~/temp
            rm -rf ~/temp/paru
            install_pacman_packages
        else
            cd ~/temp
            rm -rf ~/temp/paru
            if [ -f paru.txt ]; then
                paru -Syu --noconfirm
                grep -v '^#' paru.txt | grep -v '^$' | xargs paru -S --needed --noconfirm
            else
                echo "${YELLOW}paru.txt not found, skipping paru packages.${NC}"
            fi
        fi
    fi
}

install_paru_packages
rm -rf ~/temp/pacman.txt
rm -rf ~/temp/paru.txt
echo "${YELLOW}Package installation complete.${NC}"

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
            echo "${YELLOW}Skipping ${package_name}${NC}"
        fi
    else
        echo "${YELLOW}${package_name} is already installed.${NC}"
    fi
}

# Virt Manager
install_package "Virt-Manager" "" "https://raw.githubusercontent.com/AverageBlank/linuxDots/Master/Arch-Installs/Install-Virt-Manager.sh"

# Discord
install_package "Discord" "discord"

# Spotify
install_package "Spotify" "spotify"

# Display Manager
install_package "Sddm (Display Manager)" "sddm"

########### Setting up Configs ###########
# Qtile Battery Widget
cd ~/.config/qtile/cbatticon
make

# Shell-Color-Script autocomplete
sudo cp completions/_colorscript /usr/share/zsh/site-functions

########### Setting up Nitrogen ###########
mkdir -p ~/wallpapers/
git clone https://github.com/AverageBlank/Wallpapers ~/wallpapers

########### Changing Defaults ###########
sudo chsh -s /bin/zsh "$USER"
if (dialog --title "Message" --yesno "Reboot Now?" 6 25); then
    sudo reboot
else
    echo "${YELLOW}All done, it is recommended to reboot your system.${NC}"
fi

