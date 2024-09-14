########### Prompt ###########
#### Using Starship for Prompt ####
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi


########### Zoxide ###########
#### Using zoxide as a better cd ####
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
    alias cd='z'
fi

########### Shell-Color-Scripts ###########
#### If it exists, run ####
if command -v colorscript &> /dev/null; then
    colorscript random
fi
