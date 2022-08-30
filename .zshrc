########### prompt ###########
#### Using Starship for Prompt, Check Readme on How to Install ####
eval "$(starship init zsh)"


########### Setting NeoVim as defualt editor ###########
export EDITOR='nvim'
export VISUAL='nvim'


########### Zsh Plugins ###########
export ZSH=/usr/share/oh-my-zsh/
plugins=(git)
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
setopt GLOB_DOTS
export HISTCONTROL=ignoreboth:erasedups


########### Paths ###########
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi


########### Aliases ###########
#### Ls Commands Better ####
alias ls='ls --color=auto'
alias ll='ls -la'

#### Setting Vim as NeoVim ####
alias vim='nvim'

#### Obvous Typos ####
alias cd..='cd ..'
alias pdw='pwd'
alias pacman='sudo pacman'

#### Grep With Better Colors ####
alias grep='grep --color=auto'

#### Package Manager ####
## Unlocking Pacman ##
alias unlock='sudo rm /var/lib/pacman/db.lck'
## Using Yay as Paru ##
alias yay='paru'
## Updating the System ##
alias update='sudo pacman -Syu --noconfirm'
alias upall='paru -Syu --noconfirm'

#### Fastest Mirrors ####
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 30 --number 10 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 30 --number 10 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 30 --number 10 --sort age --save /etc/pacman.d/mirrorlist"

#### Miscellaneous ####
## Clear ##
alias clear="clear && colorscript random"
## Listing Users ##
alias userlist="cut -d: -f1 /etc/passwd"
## Update Grub Config ##
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

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


########### Key Bindings ###########
bindkey '^H' backward-kill-word
bindkey '^[[1;5C' forward-word
bindkey '^H' backward-kill-word
bindkey -s '' "clear\n"


########### On Terminal Startup ###########
colorscript random
