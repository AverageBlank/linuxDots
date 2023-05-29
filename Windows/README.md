# Windows Dotfiles

To clone the repository, run the following command:

```
git clone https://github.com/AverageBlank/dotfiles"
```

## Vim :-

To install vim using chocolatey, run the following command:

```
choco install vim -y
```

For the plugins to work, you need to install a plugin manager. The plugin manager used is Vim Plug, to install run the following command:

```
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni $HOME/vimfiles/autoload/plug.vim -Force
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

To install neovim using chocolatey, run the following command:

```
choco install neovim -y
```

For the plugins to work, you need to install a plugin manager. The plugin manager used is Vim Plug, to install run the following command:

```
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
```

If the vimrc is in the correct folder, edit it using:

```
vim ~/AppData/local/nvim/init.vim
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

Zsh here works on git bash.
To install zsh on git bash, follow the given steps:

1. Open the folder in this directory called 'Zsh'.
2. Copy all the files in the folder.
3. Paste the copied files into the folder where you installed git(they should include `etc` and `usr` folders). Git is usually installed in `C:\Program Files\Git`
4. To ensure that zsh starts when bash is loaded, copy my .bashrc file or add the following to your bashrc.

```
if [ -t 1 ]; then
  exec zsh
fi
```

### Starship:

Starship is the prompt used in zsh.
To install it, run the following command in zsh:

```
curl -fsSL https://starship.rs/install.sh | sh
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