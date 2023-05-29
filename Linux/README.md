# Linux Dotfiles

To clone the repository, run the following command:

```
git clone https://github.com/AverageBlank/dotfiles"
```

## Vim :-

For the plugins to work, you need to install a plugin manager. The plugin manager used is Vim Plug, to install run the following command:

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

If the vimrc is in the home folder, edit it using:

```
vvim ~/.vimrc
```

To install the plugins, run the following command:

```
:PlugInstall
```

Source the file by using the following command:

```
:source %
```

The above command is case sensitive.

## Neovim :-

For the plugins to work, you need to install a plugin manager. The plugin manager used is Vim Plug, to install run the following command:

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

If the vimrc is in the correct folder, edit it using:

```
vim ~/.config/nvim/init.vim
```

To install the plugins, run the following command:

```
:PlugInstall
```

Source the file by using the following command:

```
:source %
```

The above command is case sensitive.

## Zsh:-

To setup zsh, you need to install it first. Given below is installation for different distributions.

<b>Arch Linux:</b>

```
sudo pacman -S zsh
```

<b>Debian, Ubuntu:</b>

```
sudo apt-get install zsh
```

<b>Fedora:</b>

```
sudo dnf install zsh
```

To verify if zsh has been installed, run the following command:

```
zsh --version
```

### Starship:

Starship is the prompt used in zsh.
To install it, run the installation command for your distribution.

<b>Arch Linux:</b>

```
sudo pacman -S starship
```

<b>Using Snapcraft:</b>

```
sudo snap install starship
```

<b>Using Cargo:</b>

```
cargo install starship --loccked
```

<b>Other linux distributions: </b>

```
curl -sS https://starship.rs/install.sh | sh
```

### Shell Color Script:
A set of terminal color scripts that beautify the terminal.
To install it, run the installation command for your distribution.

<b>Arch Linux: </b>

If you have AUR set up, run the following command otherwise install it for other linux distributions:
```
yay -S shell-color-scripts
```
<b>Other linux distributions: </b>
```
git clone https://gitlab.com/dwt1/shell-color-scripts.git
cd shell-color-scripts
sudo make install
cd ..
rm -rf shell-color-scripts
```

### Zsh Plugins:
<b>Zsh Syntax Highlighting</b>
To use syntax highlighting, run the following commands:

```
mkdir -p ~/.zsh-plugins
cd ~/.zsh-plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
```

<b>Zsh Auto Suggestions</b>
To get suggestions, run the following commands:

```
mkdir -p ~/.zsh-plugins
cd ~/.zsh-plugins
git clone https://github.com/zsh-users/zsh-autosuggestions
```

<b>History Substring Search</b>
To get history substring search, run the following commands:

```
mkdir -p ~/.zsh-plugins
cd ~/.zsh-plugins
git clone https://github.com/zsh-users/zsh-history-substring-search
```