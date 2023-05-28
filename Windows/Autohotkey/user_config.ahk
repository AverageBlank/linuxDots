;;;;;;;;;;;! Creating and deleting desktops ;;;;;;;;;;;
;;;;? Windows + Control + c ;;;;
#^c::createVirtualDesktop()                ;* Creates a new desktop

;;;;? Windows + Control + d ;;;;
#^d::deleteVirtualDesktop()                ;* Deletes the current desktop


;;;;;;;;;;;! Switching to desktop ;;;;;;;;;;;
;;;;? Windows + Control + Number ;;;;
#^1::switchDesktopByNumber(1)              ;* Desktop 1
#^2::switchDesktopByNumber(2)              ;* Desktop 2
#^3::switchDesktopByNumber(3)              ;* Desktop 3
#^4::switchDesktopByNumber(4)              ;* Desktop 4
#^5::switchDesktopByNumber(5)              ;* Desktop 5
#^6::switchDesktopByNumber(6)              ;* Desktop 6
#^7::switchDesktopByNumber(7)              ;* Desktop 7
#^8::switchDesktopByNumber(8)              ;* Desktop 8
#^9::switchDesktopByNumber(9)              ;* Desktop 9

;;;;? Windows + Control + NumpadNumber ;;;;
#^Numpad1::switchDesktopByNumber(1)        ;* Desktop 1
#^Numpad2::switchDesktopByNumber(2)        ;* Desktop 2
#^Numpad3::switchDesktopByNumber(3)        ;* Desktop 3
#^Numpad4::switchDesktopByNumber(4)        ;* Desktop 4
#^Numpad5::switchDesktopByNumber(5)        ;* Desktop 5
#^Numpad6::switchDesktopByNumber(6)        ;* Desktop 6
#^Numpad7::switchDesktopByNumber(7)        ;* Desktop 7
#^Numpad8::switchDesktopByNumber(8)        ;* Desktop 8
#^Numpad9::switchDesktopByNumber(9)        ;* Desktop 9

;;;;? Windows + Control + Period ;;;;
#^.::switchDesktopToRight()                ;* Switches desktop to the right

;;;;? Windows + Control + Comma ;;;;
#^,::switchDesktopToLeft()                 ;* Switches desktop to the left

;;;;? Windows + Control + RightArrow ;;;;
#^Right::switchDesktopToRight()            ;* Switches desktop to the right

;;;;? Windows + Control + LeftArrow ;;;;
#^Left::switchDesktopToLeft()              ;* Switches desktop to the left


;;;;;;;;;;;! Moving window to desktop ;;;;;;;;;;;
;;;;? Windows + Shift + Number ;;;;
#+1::MoveCurrentWindowToDesktop(1)         ;* Moves window to desktop 1
#+2::MoveCurrentWindowToDesktop(2)         ;* Moves window to desktop 2
#+3::MoveCurrentWindowToDesktop(3)         ;* Moves window to desktop 3
#+4::MoveCurrentWindowToDesktop(4)         ;* Moves window to desktop 4
#+5::MoveCurrentWindowToDesktop(5)         ;* Moves window to desktop 5
#+6::MoveCurrentWindowToDesktop(6)         ;* Moves window to desktop 6
#+7::MoveCurrentWindowToDesktop(7)         ;* Moves window to desktop 7
#+8::MoveCurrentWindowToDesktop(8)         ;* Moves window to desktop 8
#+9::MoveCurrentWindowToDesktop(9)         ;* Moves window to desktop 9

;;;;? Windows + Shift + NumpadNumber ;;;;
#+Numpad1::MoveCurrentWindowToDesktop(1)   ;* Moves window to desktop 1
#+Numpad2::MoveCurrentWindowToDesktop(2)   ;* Moves window to desktop 2
#+Numpad3::MoveCurrentWindowToDesktop(3)   ;* Moves window to desktop 3
#+Numpad4::MoveCurrentWindowToDesktop(4)   ;* Moves window to desktop 4
#+Numpad5::MoveCurrentWindowToDesktop(5)   ;* Moves window to desktop 5
#+Numpad6::MoveCurrentWindowToDesktop(6)   ;* Moves window to desktop 6
#+Numpad7::MoveCurrentWindowToDesktop(7)   ;* Moves window to desktop 7
#+Numpad8::MoveCurrentWindowToDesktop(8)   ;* Moves window to desktop 8
#+Numpad9::MoveCurrentWindowToDesktop(9)   ;* Moves window to desktop 9

;;;;? Windows + Shift + Period ;;;;
#+.::MoveCurrentWindowToRightDesktop()     ;* Moves window to the desktop on the right

;;;;? Windows + Shift + Comma ;;;;
#+,::MoveCurrentWindowToLeftDesktop()      ;* Moves window to the desktop on the left