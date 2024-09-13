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
if [ -d "$HOME/.local/share/fnm" ]; then
  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

# nix packages
if [ -f $HOME/.nix-profile/etc/profile.d/nix.sh ];
then
     source $HOME/.nix-profile/etc/profile.d/nix.sh
fi


########### Prompt ###########
#### Using Starship for Prompt####
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi


########### Zoxide ###########
#### Using zoxide as a better cd ####
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
    alias cd='z'
fi


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
# If eza exists
if command -v eza &> /dev/null; then
    alias ls='eza'
    alias l='eza -la --icons --git'
    alias ll='eza -la --icons --git'
    alias tree='eza --tree --level=2 --long --icons --git'
    # Long Listing with Octal Permissions
    alias lln="ls -la --octal-permissions"
else
    alias ls='ls --color=auto'
    alias l='ls'
    alias ll='ls -la'
    # Long Listing with Octal Permissions
    alias lln="ls -la | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\"%0o \",k);print}'"
fi
# If Yazi Exists
if command -v yazi &> /dev/null; then
    alias y='yazi'
fi

#### Calendar ####
alias caly="cal -y"

#### Setting Vim as NeoVim ####
if command -v nvim &> /dev/null; then
    alias vvim='vi'
    alias vim='nvim'
    alias v='nvim'
fi

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
if command -v paru &> /dev/null; then
    alias yay='paru'
fi
## Aliasing Yay ##
alias yys='yay -S $1 --noconfirm'
alias yyss='yay -Ss'
alias yyr='yay -R $1 --noconfirm'
alias yyq='yay -Q'
## Updating the System ##
alias update='sudo pacman -Syu --noconfirm'
alias upall='yay -Syu --noconfirm'
### HomeBrew ###
## Aliasing brew ##
alias hbs='brew install $1'
alias hbss='brew search $1'
alias hbr='brew uninstall $1'
alias hbq='brew list'

#### Fastest Mirrors ####
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 30 --number 10 --sort score --save /etc/pacman.d/mirrorlist"
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
alias sr="sudo reboot"
alias sfr="sudo systemctl reboot --firmware-setup"
## Superuser Do ##
alias fucking="sudo"
## Exit Terminal ##
alias kys="echo 'Fakyu, I also have feelings. ☹️'; sleep 1; exit"

####  Git ####
alias gss="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push -u origin"
alias gpl="git pull"

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
function ex ()
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
# `st` for "Sleep Toggle"
# To run, `st {user password}`
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
if command -v colorscript &> /dev/null; then
    colorscript random
fi


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

#### Autosuggestions press -> (right arrow) to activate ####
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
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -s '^L' "clear\n"
bindkey -s '^F' '~/.config/zshScripts/tmuxthing\n'
bindkey -s '^T' '~/.config/zshScripts/vimthing\n'
bindkey -s '^Y' '~/.config/zshScripts/yazithing\n'
bindkey -s '^E' 'source ~/.config/zshScripts/cdthing\n'

