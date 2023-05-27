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
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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

### Oh My Zsh:

Oh My Zsh is a plugin manager for zsh.
To install it, run the following command:

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

<b>Zsh Completions:</b>
To use zsh completions, run the following commands:

```
cd $HOME/.oh-my-zsh/custom/plugins
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git
```

<b>Zsh Syntax Highlighting</b>
To use syntax highlighting, run the following command:

```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

<b>Zsh Auto Suggestions</b>
To get suggestions, run the following command:

```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```
