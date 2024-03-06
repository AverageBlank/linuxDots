########### Taking backups of Files if they exist ###########
mv -rf ~/.config/alacritty ~/.config/qtile ~/.config/starship.toml ~/.zshrc ~/backups-$(date +%Y.%m.%d-%H.%M.%S)

########### CLoning the directory ###########
mkdir -p ~/tempDotfiles
git clone https://github.com/AverageBlank/dotfiles ~/tempDotfiles

########### Creating directories ###########
mkdir -p ~/.config/alacritty/
mkdir -p ~/.config/qtile/

########### Moving files ###########
mv -rf ~/tempDotfiles/Linux/.config/alacritty/alacritty.toml .config/alacritty/
mv -rf ~/tempDotfiles/Linux/.config/qtile/* .config/qtile/
mv -rf ~/tempDotfiles/Linux/.config/starship.toml .config/
mv -rf ~/tempDotfiles/Linux/.zshrc .

########### Removing the cloned directory ###########
rm -rf ~/tempDotfiles

########### Installing Packages ###########
sudo pacman -S zsh, qtile, qtile-extras, starship, alacritty, rofi, brave, thunar, ttf-ubuntu-font-family, ttf-ubuntu-nerd, ttf-ubuntu-mono-nerd, ttf-jetbrains-mono, ttf-jetbrains-mono-nerd, picom --noconfirm
yay -S shell-color-scripts --noconfirm

########### Setting up Configs ###########
mkdir -p ~/.zsh-plugins
cd ~/.zsh-plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search

########### Changing Defaults ###########
chsh -s /bin/zsh $USER
