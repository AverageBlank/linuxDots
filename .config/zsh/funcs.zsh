########### Extracting Files ###########
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


########### Python Virtual Environment ###########
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


########### Toggle Disable Sleep for MacOS ###########
# `st` for "Sleep Toggle"
# To run, `st {user password}`
function st() {
    current_status=$(pmset -g | grep SleepDisabled | awk '{print $2}')
    stty -echo

    if [ "$current_status" -eq 1 ]; then
        # Enable Sleep if Disabled
        echo -e "$1" | sudo -S pmset -a disablesleep 0 > /dev/null 2>&1
        stty echo
        echo "Sleep Enabled."
    else
        # Disable Sleep if Enabled
        echo -e "$1" | sudo -S pmset -a disablesleep 1 > /dev/null 2>&1
        stty echo
        echo "Sleep Disabled."
    fi
}


########### Tmux Script ###########
# This script launches a tmux session based on selection
function tmuxthing() {
    if [[ $# -eq 1 ]]; then
        selected=$1
    else
        selected=$(find ~/ ~/coding -mindepth 1 -maxdepth 1 -type d | fzf)
    fi

    if [[ -z $selected ]]; then
        exit 0
    fi

    selected_name=$(basename "$selected" | tr . _)

    if ! tmux has-session -t=$selected_name 2> /dev/null; then
        tmux new-session -ds $selected_name -c $selected
    fi

    tmux switch-client -t $selected_name > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        tmux attach-session -t "$selected_name"
    fi
}


########### NeoVim Script ###########
# This script launches a nvim instance with the selected file
function vimthing() {
    if [[ $# -eq 1 ]]; then
        selected=$1
    else
        selected=$(rg --files --hidden | fzf)
    fi

    if [[ $selected ]]; then
        nvim "$selected"
    fi
}


########### Yazi Script ###########
# This script launches a yazi instance with the selected directory
function yazithing() {
    if [[ $# -eq 1 ]]; then
        selected=$1
    else
        selected=$(find . -maxdepth 1 -type d \( ! -path '*/.*' -o -path './.*' \) | fzf)
    fi

    if [[ $selected ]]; then
        yazi "$selected"
    fi
}


########### Change Dir Script ###########
# This script changes into the selected directory
function cdthing() {
    if [[ $# -eq 1 ]]; then
        selected=$1
    else
        selected=$(find . -maxdepth 1 -type d \( ! -path '*/.*' -o -path './.*' \) | fzf)
    fi

    if [[ $selected ]]; then
        cd "$selected"
    fi
}
