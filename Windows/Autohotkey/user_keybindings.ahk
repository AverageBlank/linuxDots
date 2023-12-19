#SingleInstance
 
;;;;;;;;;;;! Variables ;;;;;;;;;;;
;;;;? Applications ;;;;
browser := "brave"         ;* Browser
terminal := "wt"           ;* Terminal, wt = Windows Terminal
code := "code"             ;* Code editor, code=Visual Studio Code


;;;;;;;;;;;! Key Bindings ;;;;;;;;;;;
;;;;? Auto Hotkey ;;;;
#+r::Reload                ;* Restart Auto Hotkey ==> Win + Shift + R

;;;;? Applications ;;;;
#Enter::Run terminal       ;* Terminal ==> Win + Enter
#^b::Run browser           ;* Browser ==> Win + Control + B
#^e::Run code              ;* Code Editor ==> Win + Control + E

;;;;? Window Modifications ;;;;
#+c::Send !{F4}            ;* Close a program ==> Win + Shift + C
#^,::Send ^#{Left}         ;* Switch to left desktop ==> Win + Control + ,
#^.::Send ^#{Right}        ;* Switch to right desktop ==> Win + Control + .
#+,::Send #+{Left}         ;* Send window to left screen ==> Win + Shift + ,
#+.::Send #+{Right}        ;* Send window to right screen ==> Win + Shift + .

;;;;? Miscellaneous ;;;;
CapsLock::Delete           ;* Bind Capslock to delete

