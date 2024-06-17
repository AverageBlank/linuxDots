#SingleInstance

;;;;;;;;;;;! Variables ;;;;;;;;;;;
panic := True
noPausePanic := True

;;;;;;;;;;;! Key Bindings ;;;;;;;;;;;
;;;;? Flow Launcher ;;;;
#+Return::Send #y ;* Launch flow launcher ==> Win + Shift + Return
#v:: Send ^!{F4} ;* Clipbaord Manager ==> Win + V
#.:: Send ^!{F5} ;* Emoji Picker ==> Win + .
#o:: ;* Starting key chord for flow launcher ==> Win + O

    Input, SingleKey, L1, {Esc} ;* Getting key input

    if (SingleKey = "b") ;* Open bookmarks ==> B
    {
        Send, ^!{F2}
    }
    else if (SingleKey = "s") ;* Open spotify selector ==> S
    {
        Send, ^!{F3}
    }
    else if (SingleKey = "k") ;* Kill a program ==> K
    {
        Send, ^!{F6}
    }
return

;;;;? Window Modifications ;;;;
#+c::Send !{F4} ;* Close a program ==> Win + Shift + C
#^,::Send ^#{Left} ;* Switch to left desktop ==> Win + Control + ,
#^.::Send ^#{Right} ;* Switch to right desktop ==> Win + Control + .
#+,::Send #+{Left} ;* Send window to left screen ==> Win + Shift + ,
#+.::Send #+{Right} ;* Send window to right screen ==> Win + Shift + .
#+t:: ;* If a window is not maximized, maximized it, and vice-versa ==> Win + Shift + T
    WinGet, State, MinMax, A
    if State = 1
        Send #{Down} ;* Un-Maximizing the window
    else
        Send #{Up} ;* Maximizing the window
return

;;;;? Miscelanious ;;;;
CapsLock::Delete ;* Map Caps Lock to Delete
#+/:: ;* Open a file listing all the keybindings. ==> Win + Shift + /
    FilePath := A_MyDocuments "\AutoHotkey\Keybindings.html"

    Run, %FilePath%
return
#+x:: ;* When first pressed, switches to the right desktop, mutes audio, and pauses any media playing. Then, switches back to the left desktop, unmutes audio, and unpauses media ==> Win + Shift + X
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
#+z:: ;* When first pressed, switches to the right desktop, mutes audio. Then, switches back to the left desktop, unmutes audio ==> Win + Shift + X
    if noPausePanic {
        Send ^#{Right}
        Send #+q
        Send "{Volume_Mute}"
        noPausePanic := False
    } else {
        Send ^#{Left}
        Send #+q
        Send "{Volume_Mute}"
        noPausePanic := True
    }
return

;;;;? Power ;;;;
#x:: ;* Starting key chord for power menu ==> Win + X

    Input, SingleKey, L1, {Esc} ;* Getting key input

    if (SingleKey = "u") ;* Shutdown System ==> U
    {
        Shutdown, 1
    }
    else if (SingleKey = "r") ;* Restart System ==> R
    {
        Shutdown, 2
    }
    else if (SingleKey = "h") ;* Hibernate ==> H
    {
        DllCall("PowrProf\SetSuspendState", "Int", 0, "Int", 0, "Int", 0)
    }
    else if (SingleKey = "s") ;* Sign Out ==> S
    {
        Shutdown, 0
    }
    else if (SingleKey = "l") ;* Lock ==> L
    {
        DllCall("LockWorkStation")
    }
return
