########### Setting NeoVim as defualt editor ###########
export EDITOR='nvim'
export VISUAL='nvim'


########### Paths ###########
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi


########### Prompt ###########
#### Using Starship for Prompt, Check Readme on How to Install ####
eval "$(starship init zsh)"


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
#### Ls Commands Better ####
alias ls='ls -l --color=auto'
alias l='ls -la'
alias ll='ls -la'

#### Setting Vim as NeoVim ####
alias vvim='vi'
alias vim='nvim'

### Clear Command ###
alias clear='clear && colorscript random'

#### Obvous Typos ####
alias cd..='cd ..'
alias pdw='pwd'

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
alias upall='paru -Syu --noconfirm'

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
## Systemctl ##
alias sce="sudo systemctl enable"
alias scs="sudo systemctl start"
alias scd="sudo systemctl disable"
alias firmwarereboot="sudo systemctl reboot --firmware-setup"

####  Configurations ####
## Copying Configs ##
# Plasma
alias cpplasma="cp -rf ~/.config/kwinrc ~/.config/plasma-org.kde.plasma.desktop-appletsrc ~/.config/plasmarc ~/.config/kglobalshortcutsrc ~/.config/kdeglobals ~/.config/systemsettingsrc ~/Github\ Projects/Dotfiles/Linux/.config && cp -rf ~/.local/share/plasma/ ~/.local/share/color-schemes/ ~/Github\ Projects/Dotfiles/Linux/.local"
# Alacritty
alias cpalacritty="cp -rf ~/.config/alacritty/alacritty.yml ~/Github\ Projects/Dotfiles/Linux/.config/alacritty"
# Zshrc
alias cpzshrc="cp -rf ~/.zshrc ~/Github\ Projects/Dotfiles/Linux/"
# Nvimrc
alias cpnvimrc="cp -rf ~/.config/nvim/init.vim ~/Github\ Projects/Dotfiles/Linux/.config/nvim/"
## Opening Configs ##
# .config Alacritty
alias valacritty="vim ~/.config/alacritty/alacritty.yml"
alias ealacritty="emacs ~/.config/alacritty/alacritty.yml"
alias calacritty="code ~/.config/alacritty/alacritty.yml"
# github Alacritty
alias vgalacritty="vim ~/Github\ Projects/Dotfiles/Linux/.config/alacritty/alacritty.yml"
alias egalacritty="emacs ~/Github\ Projects/Dotfiles/Linux/.config/alacritty/alacritty.yml"
alias cgalacritty="code ~/Github\ Projects/Dotfiles/Linux/.config/alacritty/alacritty.yml"
# .zshrc
alias vzshrc="vim ~/.zshrc"
alias ezshrc="emacs ~/.zshrc"
alias czshrc="code ~/.zshrc"
# github zshrc
alias vgzshrc="vim ~/Github\ Projects/Dotfiles/Linux/.zshrc"
alias egzshrc="emacs ~/Github\ Projects/Dotfiles/Linux/.zshrc"
alias cgzshrc="code ~/Github\ Projects/Dotfiles/Linux/.zshrc"
# .config qtile
alias vqtile="vim ~/.config/qtile/config.py"
alias eqtile="emacs ~/.config/qtile/config.py"
alias cqtile="code ~/.config/qtile/config.py"
# github qtile
alias vgqtile="vim ~/Github\ Projects/Dotfiles/Linux/.config/qtile/config.py"
alias egqtile="emacs ~/Github\ Projects/Dotfiles/Linux/.config/qtile/config.py"
alias cgqtile="code ~/Github\ Projects/Dotfiles/Linux/.config/qtile/config.py"
# .config nvim
alias vnvimrc="vim ~/.config/nvim/init.vim"
alias envimrc="emacs ~/.config/nvim/init.vim"
alias cnvimrc="code ~/.config/nvim/init.vim"
# github nvim
alias vgnvimrc="vim ~/Github\ Projects/Dotfiles/Linux/.config/nvim/init.vim"
alias egnvimrc="emacs ~/Github\ Projects/Dotfiles/Linux/.config/nvim/init.vim"
alias cgnvimrc="code ~/Github\ Projects/Dotfiles/Linux/.config/nvim/init.vim"


####  Git ####
alias gss="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push -u origin"


####  Nvidia ####
## Optimus Manager ##
alias oph='optimus-manager --switch hybrid --no-confirm'
alias opn='optimus-manager --switch nvidia --no-confirm'
alias opi='optimus-manager --switch integrated --no-confirm'
alias ops='optimus-manager --print-mode'

####  ArcoLinux ####
alias skel='cp -Rf ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H.%M.%S) && cp -rf /etc/skel/* ~'


########### Extracting Files ###########
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


########### Setting Locale ###########
export LC_CTYPE="en_US.utf8"


########### On Terminal Startup ###########
colorscript random


########### Plugins ###########
#### Autosuggestions press ->(right arrow) to activate ####
source ~/.zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

#### Syntax Highlighting ####
source ~/.zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#### History Substring Search ####
source ~/.zsh-plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

#### Non-Case sensitive searching ####
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'


########### Key Bindings ###########
bindkey '^H' backward-kill-word
bindkey '^[[1;5C' forward-word
bindkey "^[[1;5D" backward-word
bindkey -s '' "clear\n"
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
