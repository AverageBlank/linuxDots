########### Setting NeoVim as defualt editor ###########
export EDITOR='nvim'
export VISUAL='nvim'


########### Oh My Zsh ###########
export ZSH="$HOME/.oh-my-zsh/"
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  )  
source $ZSH/oh-my-zsh.sh
source $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.oh-my-zsh/custom/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
setopt GLOB_DOTS
export HISTCONTROL=ignoreboth:erasedups


########### Paths ###########
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi
export PATH=/usr/local/bin:$PATH

########### prompt ###########
#### Using Starship for Prompt, Check Readme on How to Install ####
eval "$(starship init zsh)"


########### Aliases ###########
#### Ls Commands Better ####
alias ls='ls --color=auto'
alias l='ls -a'
alias ll='ls -la'

#### Setting Vim as NeoVim ####
alias vvim='vi'
alias vim='nvim'

#### Obvous Typos ####
alias cd..='cd ..'
alias pdw='pwd'

#### Grep With Better Colors ####
alias grep='grep --color=auto'


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
cd $HOME
