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

;;;;? Window Modifications ;;;;
#+c::Send !{F4} ;* Close a program ==> Win + Shift + C
#^,::Send ^#{Left} ;* Switch to left desktop ==> Win + Control + ,
#^.::Send ^#{Right} ;* Switch to right desktop ==> Win + Control + .
#+,::Send #+{Left} ;* Send window to left screen ==> Win + Shift + ,
#+.::Send #+{Right} ;* Send window to right screen ==> Win + Shift + .
#+x::
    if (Panic1) {
        WinShow ahk_id %Panic1%
        WinActivate ahk_id %Panic1%
        Panic1 := False
    } else {
        Panic1 := WinExist("A")
        WinHide ahk_id %Panic1%
    }
return
#+z::
    if (Panic2) {
        WinShow ahk_id %Panic2%
        WinActivate ahk_id %Panic2%
        Panic2 := False
    } else {
        Panic2 := WinExist("A")
        WinHide ahk_id %Panic2%
    }
return

;;;;? Miscellaneous ;;;;
CapsLock::Delete ;* Bind Capslock to delete

