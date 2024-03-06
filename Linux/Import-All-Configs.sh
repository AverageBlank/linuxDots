########### Taking backups of Files if they exist ###########
mv -f ~/.config/alacritty ~/.config/qtile ~/.config/starship.toml ~/.zshrc ~/backups-$(date +%Y.%m.%d-%H.%M.%S)

########### CLoning the directory ###########
mkdir -p ~/tempDotfiles
git clone https://github.com/AverageBlank/dotfiles ~/tempDotfiles

########### Creating directories ###########
mkdir -p ~/.config/alacritty/
mkdir -p ~/.config/qtile/

########### Moving files ###########
mv -f ~/tempDotfiles/Linux/.config/alacritty/alacritty.toml .config/alacritty/
mv -f ~/tempDotfiles/Linux/.config/qtile/* .config/qtile/
mv -f ~/tempDotfiles/Linux/.config/starship.toml .config/
mv -f ~/tempDotfiles/Linux/.zshrc .

########### Removing the cloned directory ###########
rm -rf ~/tempDotfiles

########### Installing Packages ###########
sudo pacman -Syyy
sudo pacman -S zsh, qtile, qtile-extras, starship, alacritty, rofi, brave, thunar, ttf-ubuntu-font-family, ttf-ubuntu-nerd, ttf-ubuntu-mono-nerd, ttf-jetbrains-mono, ttf-jetbrains-mono-nerd, picom, network-manager-applet, xfce4-power-manager, blueberry, lxsession, flameshot, xfce4-notifyd, nitrogen, mpv --noconfirm
paru -S shell-color-scripts --noconfirm

########### Installing Other Programs ###########
echo "Do you wish to install Virt Manager?"
select yn in "Yes" "No"; do
    case $yn in
    Yes)
        curl -s -L https://raw.githubusercontent.com/AverageBlank/Dotfiles/Master/Linux/Install-Virt-Manager.sh | bash
        break
        ;;
    No) break ;;
    esac
done

echo "Do you wish to install Visual Studio Code?"
select yn in "Yes" "No"; do
    case $yn in
    Yes)
        paru -S visual-studio-code-bin --noconfirm
        break
        ;;
    No) break ;;
    esac
done

echo "Do you wish to install Discord?"
select yn in "Yes" "No"; do
    case $yn in
    Yes)
        paru -S discord --noconfirm
        break
        ;;
    No) break ;;
    esac
done

echo "Do you wish to install Apple Music?"
select yn in "Yes" "No"; do
    case $yn in
    Yes)
        paru -S apple-music-desktop --noconfirm
        break
        ;;
    No) break ;;
    esac
done

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

########### Changing Defaults ###########
chsh -s /bin/zsh $USER
cd
rm -- "$0"
