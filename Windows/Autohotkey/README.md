# AutoHotkey

## Application Keybindings
To only use application keybindings run only the user_keybindings.ahk

## Desktop Keybindings
To only use desktop keybindings run only the desktop_switcher.ahk

## Application and Desktop Keybindings
To run both application and desktop keybindings start both the files

## For Autostarting: 
Whichever config(s) you are running, you can autostart them by adding them into your autostart folder.
To do so, run the following command(s) in the shell of your choice: 
### Bash/Zsh:
<b>Only Application Keybindings: </b>
```
ln user_keybindings.ahk ~/"AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
```
<b>Only Desktop Keybindings: </b>
```
ln desktop_switcher.ahk ~/"AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
```
<b>Both Application and Desktop Keybindings: </b>

```
ln user_keybindings.ahk ~/"AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
ln desktop_switcher.ahk ~/"AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
```

### Powershell:
<b>Only Application Keybindings: </b>
```
New-Item -ItemType SymbolicLink -Path $HOME\"AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\user_keybindings.ahk" -Target .\user_keybindings.ahk
```
<b>Only Desktop Keybindings: </b>
```
New-Item -ItemType SymbolicLink -Path $HOME\"AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\desktop_switcher.ahk" -Target .\desktop_switcher.ahk
```
<b>Both Application and Desktop Keybindings: </b>

```
New-Item -ItemType SymbolicLink -Path $HOME\"AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\user_keybindings.ahk" -Target .\user_keybindings.ahk
New-Item -ItemType SymbolicLink -Path $HOME\"AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\desktop_switcher.ahk" -Target .\desktop_switcher.ahk
```