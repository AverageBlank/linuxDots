#SingleInstance
 
;;;;;;;;;;;! Variables ;;;;;;;;;;;
;;;;? Applications ;;;;
browser := "brave"         ;* Browser
terminal := "wt"           ;* Terminal, wt = Windows Terminal
code := "code"             ;* Code editor, code=Visual Studio Code


;;;;;;;;;;;! Key Bindings ;;;;;;;;;;;
;;;;? Auto Hotkey ;;;;
#+r::Reload                ;* Restart Auto Hotkey
#+c::Winkill("A")          ;* Close a program

;;;;? Applications ;;;;
#Enter::Run terminal       ;* Terminal
#^b::Run browser           ;* Browser
#^e::Run code              ;* Code Editor
