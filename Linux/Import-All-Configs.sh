#!/bin/bash

########### Taking backups of Files if they exist ###########
mkdir -p ~/.config-backup/
cp -Rf ~/.config/alacritty ~/.config/qtile ~/.config/starship.toml ~/.zshrc ~/.config-backup/

########### CLoning the directory ###########
mkdir -p ~/tempDotfiles/
git clone https://github.com/AverageBlank/dotfiles ~/tempDotfiles

########### Creating directories ###########
mkdir -p ~/.config/alacritty/
mkdir -p ~/.config/qtile/
mkdir -p ~/.local/share/fonts

########### Moving files ###########
cp -rf ~/tempDotfiles/Linux/.config/alacritty/alacritty.toml .config/alacritty/
cp -rf ~/tempDotfiles/Linux/.config/qtile/* .config/qtile/
cp -rf ~/tempDotfiles/Linux/.config/starship.toml .config/
cp -rf ~/tempDotfiles/Linux/.zshrc .
cp -rf ~/tempDotfiles/Linux/.local/share/fonts/* .local/share/fonts

########### Removing the cloned directory ###########
rm -rf ~/tempDotfiles

########### Installing Packages ###########
sudo pacman -Syyy
sudo pacman -S zsh qtile qtile-extras starship alacritty rofi brave thunar ttf-ubuntu-font-family ttf-ubuntu-nerd ttf-ubuntu-mono-nerd ttf-jetbrains-mono ttf-jetbrains-mono-nerd picom network-manager-applet xfce4-power-manager blueberry lxsession flameshot xfce4-notifyd nitrogen mpv --noconfirm
paru -S shell-color-scripts betterlockscreen zathura --noconfirm

########### Installing Other Programs ###########
if (dialog --title "Message" --yesno "Do you want to install Virt Manager?" 6 25); then
    curl -s -L https://raw.githubusercontent.com/AverageBlank/Dotfiles/Master/Linux/Install-Virt-Manager.sh | bash
else
    echo "Skipping Virt-Manager"
fi

if (dialog --title "Message" --yesno "Do you want to install Visual Studio Code?" 6 25); then
    paru -S visual-studio-code-bin --noconfirm
else
    echo "Skipping Visual Studio Code"
fi

if (dialog --title "Message" --yesno "Do you want to install Discord?" 6 25); then
    sudo pacman -S discord --noconfirm
else
    echo "Skipping discord"
fi

if (dialog --title "Message" --yesno "Do you want to install Apple Music?" 6 25); then
    paru -S apple-music-desktop --noconfirm
else
    echo "Skipping Apple Music"
fi

## Checking if nvidia GPU
gpu=$(lspci | grep -i '.* vga .* nvidia .*')

if echo "$gpu" | grep -qi 'nvidia'; then
    sudo pacman -S optimus-manager --noconfirm
else
    echo NO NVIDIA GPU PRESENT
fi

########### Setting up Configs ###########
mkdir -p ~/.zsh-plugins
cd ~/.zsh-plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search
chmod +x ~/.config/qtile/scripts/autostart.sh
chmod +x ~/.config/qtile/scripts/nitrogen1.sh
chmod +x ~/.config/qtile/scripts/nitrogen2.sh
chmod +x ~/.config/qtile/scripts/nitrogen3.sh
chmod +x ~/.config/qtile/scripts/TermApps/opencal.sh
chmod +x ~/.config/qtile/scripts/TermApps/opencpu.sh
chmod +x ~/.config/qtile/scripts/TermApps/openmem.sh
chmod +x ~/.config/qtile/scripts/TermApps/opendf.sh
chmod +x ~/.config/qtile/scripts/TermApps/updates.sh
chmod +x ~/.config/qtile/rofi/launcher.sh
chmod +x ~/.config/qtile/rofi/logout.sh
cd ~/.config/qtile/cbatticon
make

########### Setting up Nitrogen ###########
mkdir -p ~/wallpapers/
git clone https://github.com/AverageBlank/Wallpapers ~/wallpapers

########### Changing Defaults ###########
sudo chsh -s /bin/zsh $USER
cd
