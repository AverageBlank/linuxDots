# AutoHotkey

## Application Keybindings
To only use application keybindings run only the user_keybindings.ahk

## Desktop Keybindings
To only use desktop keybindings run only the desktop_switcher.ahk

## Application and Desktop Keybindings
To run both application and desktop keybindings start both the files

## For Autostarting: 
Whichever config(s) you are running, you can autostart them by adding them into your autostart folder.
To do so, run the following command(s) in an elavated(administrator) powershell: 

### Only Application Bindings:
```
New-Item -ItemType SymbolicLink -Path $HOME\"AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\user_keybindings.ahk" -Target .\user_keybindings.ahk
```
### Only Desktop Keybindings: 
```
New-Item -ItemType SymbolicLink -Path $HOME\"AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\desktop_switcher.ahk" -Target .\desktop_switcher.ahk
```
### Both Application and Desktop Keybindings:

```
New-Item -ItemType SymbolicLink -Path $HOME\"AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\user_keybindings.ahk" -Target .\user_keybindings.ahk
New-Item -ItemType SymbolicLink -Path $HOME\"AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\desktop_switcher.ahk" -Target .\desktop_switcher.ahk
```