#SingleInstance

;;;;;;;;;;;! Variables ;;;;;;;;;;;
;;;;? Applications ;;;;
browser := "brave" ;* Browser
terminal := "wt" ;* Terminal, wt = Windows Terminal
code := "code" ;* Code editor, code=Visual Studio Code

;;;;;;;;;;;! Key Bindings ;;;;;;;;;;;
;;;;? Auto Hotkey ;;;;
#+r::Reload ;* Restart Auto Hotkey ==> Win + Shift + R

;;;;? Applications ;;;;
#Enter::Run %terminal% ;* Terminal ==> Win + Enter
#^b::Run %browser% ;* Browser ==> Win + Control + B
#^e::Run %code% ;* Code Editor ==> Win + Control + E
