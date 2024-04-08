#SingleInstance

;;;;;;;;;;;! Variables ;;;;;;;;;;;
panic := True

;;;;;;;;;;;! Key Bindings ;;;;;;;;;;;
#+r::Reload ;* Restart Auto Hotkey ==> Win + Shift + R

;;;;? Window Modifications ;;;;
#+c::Send !{F4} ;* Close a program ==> Win + Shift + C
#^,::Send ^#{Left} ;* Switch to left desktop ==> Win + Control + ,
#^.::Send ^#{Right} ;* Switch to right desktop ==> Win + Control + .
#+,::Send #+{Left} ;* Send window to left screen ==> Win + Shift + ,
#+.::Send #+{Right} ;* Send window to right screen ==> Win + Shift + .
CapsLock::Delete ;* Map Caps Lock to Delete
#+x:: ;* When first pressed, switch to right desktop, mute and pause media. Then, switch back to left desktop, unmute, and unpause media ==> Win + Shift + X
    if panic {
        Send ^#{Right}
        Send #+q
        Send "{Volume_Mute}"
        Send "{Media_Play_Pause}"
        panic := False
    } else {
        Send ^#{Left}
        Send #+q
        Send "{Volume_Mute}"
        Send "{Media_Play_Pause}"
        panic := True
    }
return
