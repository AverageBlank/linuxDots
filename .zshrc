########### Setting a few defaults ###########
setopt autocd


########### Setting NeoVim as default editor ###########
export EDITOR='nvim'
export VISUAL='nvim'


########### Paths ###########
# bin
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

# localbin
if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

# fnm
FNM_PATH="/home/hussain/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/hussain/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

# nix packages
if [ -f $HOME/.nix-profile/etc/profile.d/nix.sh ];
then
     source $HOME/.nix-profile/etc/profile.d/nix.sh
fi


########### Prompt ###########
#### Using Starship for Prompt, Check Readme on How to Install ####
eval "$(starship init zsh)"


########### Zoxide ###########
#### Using zoxide as a better cd ####
eval "$(zoxide init zsh)"


########### History ###########
mkdir -p ~/.zsh-cache
export HISTFILE=~/.zsh-cache/zshhist
export HISTSIZE=10000
export SAVEHIST=10000
setopt INC_APPEND_HISTORY_TIME
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS


########### Aliases ###########
#### Terminal Utilities ####
alias ls='eza'
alias l='eza -la --icons --git'
alias ll='eza -la --icons --git'
alias y='yazi'
alias cd='z'
alias tree='eza --tree --level=2 --long --icons --git'


#### calendar ####
alias caly="cal -y"

#### Setting Vim as NeoVim ####
alias vvim='vi'
alias vim='nvim'
alias v='nvim'

#### Visual Studio Code ####
alias c="code"

#### Obvous Typos ####
alias cd..='cd ..'
alias pdw='pwd'

#### Coding ####
alias cdc="cd ~/Coding"

#### Grep With Better Colors ####
alias grep='grep --color=auto'

#### Package Manager ####
### Pacman ###
## Aliasing Pacman ##
alias pacman='sudo pacman --color auto'
alias sps='sudo pacman -S $1 --noconfirm'
alias spss='sudo pacman -Ss'
alias spr='sudo pacman -R $1 --noconfirm'
alias spq='sudo pacman -Q'
## Unlocking Pacman ##
alias punlock='sudo rm /var/lib/pacman/db.lck'
## Using Yay as Paru ##
alias yay='paru'
## Aliasing Yay ##
alias yys='yay -S $1 --noconfirm'
alias yyss='yay -Ss'
alias yyr='yay -R $1 --noconfirm'
alias yyq='yay -Q'
## Updating the System ##
alias update='sudo pacman -Syu --noconfirm'
alias upall='yay -Syu --noconfirm'

#### Fastest Mirrors ####
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 30 --number 10 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 30 --number 10 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 30 --number 10 --sort age --save /etc/pacman.d/mirrorlist"
alias mirrorlist="sudo reflector --age 6 --latest 21 --fastest 21 --threads 21 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"

#### Miscellaneous ####
## Listing Users ##
alias userlist="cut -d: -f1 /etc/passwd"
## Update Grub Config ##
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
## Python ##
alias python="python3"
alias py="python3"
## Emacs ##
alias emacs="emacsclient -c -a 'emacs'"
## Iso ##
alias iso="cat /etc/dev-rel | awk -F '=' '/ISO/ {print $2}'"
## Shutdown/Reboot ##
alias ssn="sudo shutdown now"
alias sr="reboot"
alias sfr="sudo systemctl reboot --firmware-setup"
## Systemctl ##
alias sce="sudo systemctl enable"
alias scs="sudo systemctl start"
alias scd="sudo systemctl disable"
## Superuser Do ##
alias fucking="sudo"

####  Configurations ####
## Copying Configs ##
# Plasma
alias cpplasma="cp -rf ~/.config/kwinrc ~/.config/khotkeysrc ~/.config/plasma-org.kde.plasma.desktop-appletsrc ~/.config/plasmarc ~/.config/kglobalshortcutsrc ~/.config/kdeglobals ~/.config/systemsettingsrc ~/Coding/Dotfiles/Linux/.config && cp -rf ~/.local/share/plasma/ ~/.local/share/color-schemes/ ~/Github\ Projects/Dotfiles/Linux/.local"
# Alacritty
alias cpalacritty="cp -rf ~/.config/alacritty/alacritty.toml ~/Coding/Dotfiles/Linux/.config/alacritty"
# Zshrc
alias cpzshrc="cp -rf ~/.zshrc ~/Coding/Dotfiles/Linux/"
# Nvimrc
alias cpnvimrc="cp -rf ~/.config/nvim/init.vim ~/Coding/Dotfiles/Linux/.config/nvim/"
# Qtile
alias cpqtile="cp -rf ~/.config/qtile/config.py ~/.config/qtile/cbatticon ~/.config/qtile/rofi ~/.config/qtile/icons ~/.config/qtile/scripts ~/Coding/Dotfiles/Linux/.config/qtile"
## Opening Configs ##
# .config Alacritty
alias valacritty="vim ~/.config/alacritty/alacritty.toml"
alias ealacritty="emacs ~/.config/alacritty/alacritty.toml"
alias calacritty="code ~/.config/alacritty/alacritty.toml"
# github Alacritty
alias vgalacritty="vim ~/Coding/Dotfiles/Linux/.config/alacritty/alacritty.toml"
alias egalacritty="emacs ~/Coding/Dotfiles/Linux/.config/alacritty/alacritty.toml"
alias cgalacritty="code ~/Coding/Dotfiles/Linux/.config/alacritty/alacritty.toml"
# .zshrc
alias vzshrc="vim ~/.zshrc"
alias ezshrc="emacs ~/.zshrc"
alias czshrc="code ~/.zshrc"
# github zshrc
alias vgzshrc="vim ~/Coding/Dotfiles/Linux/.zshrc"
alias egzshrc="emacs ~/Coding/Dotfiles/Linux/.zshrc"
alias cgzshrc="code ~/Coding/Dotfiles/Linux/.zshrc"
# .config qtile
alias vqtile="vim ~/.config/qtile/config.py"
alias eqtile="emacs ~/.config/qtile/config.py"
alias cqtile="code ~/.config/qtile/config.py"
# github qtile
alias vgqtile="vim ~/Coding/Dotfiles/Linux/.config/qtile/config.py"
alias egqtile="emacs ~/Coding/Dotfiles/Linux/.config/qtile/config.py"
alias cgqtile="code ~/Coding/Dotfiles/Linux/.config/qtile/config.py"
# .config nvim
alias vnvimrc="vim ~/.config/nvim/init.vim"
alias envimrc="emacs ~/.config/nvim/init.vim"
alias cnvimrc="code ~/.config/nvim/init.vim"
# github nvim
alias vgnvimrc="vim ~/Coding/Dotfiles/Linux/.config/nvim/init.vim"
alias egnvimrc="emacs ~/Coding/Dotfiles/Linux/.config/nvim/init.vim"
alias cgnvimrc="code ~/Coding/Dotfiles/Linux/.config/nvim/init.vim"


####  Git ####
alias gss="git status"
alias ga="git add ."
alias gr="git remove"
alias gc="git commit -m"
alias gp="git push -u origin"


#### CD ####
alias cdcd="cd ~/Coding/Dotfiles"


####  Nvidia ####
## Optimus Manager ##
alias oph='optimus-manager --switch hybrid --no-confirm'
alias opn='optimus-manager --switch nvidia --no-confirm'
alias opi='optimus-manager --switch integrated --no-confirm'
alias ops='optimus-manager --print-mode'

####  ArcoLinux ####
alias skel='cp -Rf ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H.%M.%S)'


########### Functions  ###########
#### Extracting Files ####
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#### Python Virtual Environment ####
function pv() {
    if [ -d ".venv" ]; then
        # Activate the existing virtual environment
        source .venv/bin/activate
    else
        # Create a new virtual environment and activate it
        python3 -m venv .venv
        source .venv/bin/activate
    fi
}

#### Toggle Disable Sleep on MacOS ####
# `slt` for "Sleep Toggle"
# To run, `slt {user password}`
function st() {
    current_status=$(pmset -g | grep SleepDisabled | awk '{print $2}')
    stty -echo
    
    if [ "$current_status" -eq 1 ]; then
        echo -e "$1" | sudo -S pmset -a disablesleep 0 > /dev/null 2>&1
        stty echo
        echo "Sleep Enabled."
    else
        echo -e "$1" | sudo -S pmset -a disablesleep 1 > /dev/null 2>&1
        stty echo
        echo "Sleep Disabled."
    fi
}



########### Setting Locale ###########
export LC_CTYPE="en_US.utf8"
export LC_ALL="en_US.UTF-8"



########### On Terminal Startup ###########
case "$OSTYPE" in
  linux*)
    colorscript random
esac


########### Plugins ###########
### Making sure they all exist ###
# Yellow color code
YELLOW='\033[1;33m'
# No color code
NC='\033[0m'
## Auto Suggestions ##
if [ ! -d "$HOME/.zsh-plugins/zsh-autosuggestions" ]; then
  echo "${YELLOW}zsh-autosuggestions plugin does not exist. Cloning plugin...${NC}"
  mkdir -p "$HOME/.zsh-plugins"
  cd "$HOME/.zsh-plugins" || exit
  git clone https://github.com/zsh-users/zsh-autosuggestions
fi
## Syntax Highlighting ##
if [ ! -d "$HOME/.zsh-plugins/zsh-syntax-highlighting" ]; then
  echo "${YELLOW}zsh-syntax-highlighting plugin does not exist. Cloning plugin...${NC}"
  mkdir -p "$HOME/.zsh-plugins"
  cd "$HOME/.zsh-plugins" || exit
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
fi
## History Substring Search ##
if [ ! -d "$HOME/.zsh-plugins/zsh-history-substring-search" ]; then
  echo "${YELLOW}history-substring-search plugin does not exist. Cloning plugin...${NC}"
  mkdir -p "$HOME/.zsh-plugins"
  cd "$HOME/.zsh-plugins" || exit
  git clone https://github.com/zsh-users/zsh-history-substring-search
fi

#### Autosuggestions press ->(right arrow) to activate ####
source ~/.zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#### Syntax Highlighting ####
source ~/.zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#### History Substring Search ####
source ~/.zsh-plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
## Non-Case sensitive searching ##
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'


########### Key Bindings ###########
bindkey '^[[1;5C' forward-word
bindkey "^[[1;5D" backward-word
bindkey -s '^L' "clear\n"
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -s '^F' '~/.config/tmuxthing\n'
