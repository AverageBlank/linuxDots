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
export PATH=/usr/local/bin:$PATH


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
alias ls='ls --color=auto'
alias l='ls -la'
alias ll='ls -la'

#### Setting Vim as NeoVim ####
alias vvim='vi'
alias vim='nvim'

#### Obvous Typos ####
alias cd..='cd ..'
alias pdw='pwd'

#### Grep With Better Colors ####
alias grep='grep --color=auto'

#### Miscellaneous ####
## Python ##
alias python="python3"

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
bindkey '^H' backward-kill-word
bindkey -s '' "clear\n"
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
