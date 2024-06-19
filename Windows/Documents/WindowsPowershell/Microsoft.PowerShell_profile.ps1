########### Prompt ###########
#### Using Starship for Prompt, Check Readme on How to Install ####
function Invoke-Starship-TransientFunction {
  &starship module character
}
Invoke-Expression (& "C:\Program Files\starship\bin\starship.exe" init powershell --print-full-init | Out-String)
Enable-TransientPrompt


########### Aliases ###########
#### Setting Vim as NeoVim ####
Set-Alias vvim 'vi'
Set-Alias vim 'nvim'

#### Superuser do ####
Set-Alias sudo "C:\tools\gsudo\Current\gsudo.exe"
Set-Alias gsudo "C:\tools\gsudo\Current\gsudo.exe"
Set-Alias fucking sudo

### Code Editors ###
Set-Alias v "nvim"
Set-Alias c "code"

#### Shutdown/Reboot ####
function ssn { shutdown -t 0 -s }
function sr { shutdown -t 0 -r }
function sfr { sudo shutdown -t 0 -r -fw }

#### ls ####
Set-Alias l ls
Set-Alias ll ls

#### cd ####
function cdc {cd C:\Coding}
function cdcd {cd C:\Coding\Dotfiles}
function cdcl {cd C:\Coding\LearningCoding}

#### rm ####
function rm {rm $args -r -force}

#### touch ####
function touch {New-Item $args}


#### Package Manager ####
## Aliasing Winget ##
function wgs { sudo winget install $args --accept-source-agreements --accept-package-agreements }
function wgss { winget search $args }
function wgr { sudo winget uninstall $args }
## Aliasing Chocolatey ##
function chs { sudo choco install $args -y }
function chss { choco search $args }
function chr { sudo choco uninstall $args -y }


####  Configurations ####
## Copying Configs ##
# nvim
function cpnvimrc {cp $env:LOCALAPPDATA\nvim\ C:\Coding\Dotfiles\Windows\AppData\local\nvim -r -force}
# Windows Terminal
function cpwt {cp $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState C:\Coding\Dotfiles\Windows\AppData\local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\ -r -force }
# Powershell
function cppwsh {cp $env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 C:\Coding\Dotfiles\Windows\Documents\WindowsPowerShell -r -force }
## Opening Configs ##
# LOCALAPPDATA nvim
function vnvimrc { vim $env:LOCALAPPDATA\nvim\lua }
function cnvimrc { code $env:LOCALAPPDATA\nvim\lua }
# github nvim
function vgnvimrc { vim C:\Coding\Dotfiles\Windows\AppData\local\nvim\lua }
function cgnvimrc { code C:\Coding\Dotfiles\Windows\AppData\local\nvim\lua }
# LOCALAPPDATA Windows Terminal
function vwt { vim $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json }
function cwt { code $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json }
# Github Windows Terminal
function vgwt { vim C:\Coding\Dotfiles\Windows\AppData\local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json}
function cgwt { code C:\Coding\Dotfiles\Windows\AppData\local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json}
# Powershell
function vpwsh { vim $env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 }
function cpwsh { code $env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 }
# Github Powershell
function vgpwsh { vim C:\Coding\Dotfiles\Windows\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 }
function cgpwsh { code C:\Coding\Dotfiles\Windows\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 }
