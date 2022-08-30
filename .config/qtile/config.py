########### Imports ###########
import os
import re
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Drag, Key, KeyChord, Screen, Group, Drag, Click, Rule, Match
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.widget import Spacer


########### Key Shortcuts ###########
#### Mod Keys ####
super       = "mod4"                                             # Super is the Windows Key
alt         = "mod1"
ctrl        = "control"

#### Special Characters ####
home        = os.path.expanduser('~')

#### Applications ####
browser     = "firefox"                                          # Browser
code        = "emacs"                                            # Text Editing
files       = "thunar"                                           # File Manager
logout      = "arcolinux-logout"                                 # Logout Tool
run         = home + '/.config/rofi/Launcher/launcher.sh'        # Run Launcher
taskmanager = "alacritty -e'htop'"                               # Task Manager
terminal    = "alacritty"                                        # Terminal
chat        = "discord"                                          # Chat Application
virtual     = "virt-manager"                                     # Virtualization Software
config      = "emacs '~/.config/qtile/config.py'"                # Qtile Config


########### Key Bindings ###########
keys = [
#### Layout Modifications ####
## Switching Between Open Applications ##
# Switch Up
Key([super], "Up", lazy.layout.up()),
# Switch Down
Key([super], "Down", lazy.layout.down()),
# Switch Left
Key([super], "Left", lazy.layout.left()),
# Switch Right
Key([super], "Right", lazy.layout.right()),
# Switch Between Apps
Key([super], "k", lazy.layout.next()),
# Switch Between Apps
Key([super], "j", lazy.layout.next()),
# Switch Between Apps
Key([alt], "Tab", lazy.layout.next()),
## Changing the Size of Open Applications ##
# Increase Size
Key([super], "l",
    lazy.layout.grow_right(),
    lazy.layout.grow(),
    lazy.layout.increase_ratio(),
    lazy.layout.delete(),
    ),
# Decrease Size
Key([super], "h",
    lazy.layout.grow_left(),
    lazy.layout.shrink(),
    lazy.layout.decrease_ratio(),
    lazy.layout.add(),
    ),
## Change the Layout ##
Key([super], "Tab", lazy.next_layout()),
## Toggle Fullscreen ##
Key([super, "shift"], "f", lazy.window.toggle_fullscreen()),
## Toggle Floating ##
Key([super, "shift"], "t", lazy.window.toggle_floating()),

#### Qtile ####
## Exiting and Restarting ##
# Retart Qtile
Key([super, "shift"], "r", lazy.restart()),
# Quit Qtile
Key([super, "shift"], "q", lazy.shutdown()),
# Closing Applications
Key([super, "shift"], "c", lazy.window.kill()),

#### Applications ####
# Terminal
Key([super], "Return", lazy.spawn(terminal)),
Key([super], "KP_Enter", lazy.spawn(terminal)),
# Browser
Key([alt, "control"], "b", lazy.spawn(browser)),
# Text Editing
Key([alt, "control"], "c", lazy.spawn(code)),
# File Manager
Key([super], "e", lazy.spawn(files)),
# Logout Tool
Key([super], "x", lazy.spawn(logout)),
# Chat Application
Key([alt, "control"], "d", lazy.spawn(chat)),
# X Kill
Key([super], "Escape", lazy.spawn('xkill')),
# Run Launcher
Key([super, "shift"], "Return", lazy.spawn(run)),
# Task Manager
Key([ctrl, "shift"], "Escape", lazy.spawn(taskmanager)),
# Virtualization Software
Key([alt, "control"], "v", lazy.spawn(virtual)),
# ScreenShots
Key([super], "Print", lazy.spawn("scrot 'Screenshot-%Y-%m-%d-%s.jpg' -e 'mv $f $$(xdg-user-dir PICTURES)'")),
# Config
Key([alt, "control"], "h", lazy.spawn(config))]


########### Mouse Bindings ###########
mouse = [
    Drag([super], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([super], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size())
]


########### WorkSpaces ###########
#### WorkSpaces ####
# The Names of Applications after the Layout is to Move the Application to the Workspace.
group_names = [("Web", {'layout': 'max', 'matches':[Match(wm_class=["Brave-browser", "firefox"])]}),
               ("Dev", {'layout': 'max', 'matches':[Match(wm_class=["Emacs"])]}),
               ("Sys", {'layout': 'monadtall', 'matches':[Match(wm_class=["Alacritty"])]}),
               ("Chat", {'layout': 'max', 'matches':[Match(wm_class=["discord"])]}),
               ("Vbox", {'layout': 'max', 'matches':[Match(wm_class=["VirtualBox Manager", "VirtualBox Machine", "Virt-manager", "Vmware"])]}),
               ("Music", {'layout': 'max'}),
               ("Video", {'layout': 'max', 'matches':[Match(wm_class=["kdenlive"])]}),
               ("Misc", {'layout': 'monadtall'})]
## Variable ##
groups = [Group(name, **kwargs) for name, kwargs in group_names]
for i, (name, kwargs) in enumerate(group_names, 1):

#### To switch WorkSpaces ####
    keys.append(Key([super], str(i), lazy.group[name].toscreen()))
    keys.append(Key([super, "shift"], str(i), lazy.window.togroup(name), lazy.group[name].toscreen()))


########### layouts ###########
layouts = [
    layout.MonadTall(margin=8, border_width=2, border_focus="#5e81ac", border_normal="#4c566a"),
    layout.Floating(border_focus="#5e81ac", border_normal="#4c566a"),
    layout.Max()]


########### Bar ###########
#### Colors for the Bar ####
## Colors for the Workspaces ##
colors1 = [["#282828", "#282828"],                         # BackGround Color
           ["#4e8aa0", "#4e8aa0"],                         # Workspaces with Open Applications
           ["#e78a4e", "#e78a4e"],                         # Workspaces with no Open Applictaions
           ["#3d3f4b", "#3d3f4b"],                         # Highlight Current Workspace
           ["#ea6962", "#ea6962"]]                         # Line Color
## Colors for the Widgets ##
colors2 = [["#282828", "#282828"],                         # BackGround Color
           ["#7daea3", "#7daea3"],                         # Window Name Color
           ["#e78a4e", "#e78a4e"],                         # Ram Color
           ["#dfbf8e", "#dfbf8e"],                         # Clock Color
           ["#ea6962", "#ea6962"],                         # Layout Color
           ["#c0c5ce", "#c0c5ce"]]                         # Text Color

#### Widgets for the Bar ####
## Defaults ##
def init_widgets_defaults():
    return dict(font="Noto Sans",
                fontsize = 12,
                padding = 2,
                background=colors2[0])
widget_defaults = init_widgets_defaults()
## Widgets ##
def init_widgets_list():
    widgets_list = [
               widget.Image(
                       filename = home + "/.config/qtile/icons/python.png",
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(run)},
                       ),
               widget.GroupBox(
                        fontsize = 14,
                        margin_y = 3,
                        margin_x = 0,
                        padding_x = 3,
                        active = colors1[1],
                        inactive = colors1[2],
                        rounded = False,
                        highlight_color = colors1[3],
                        highlight_method = "line",
                        disable_drag = "true",
                        this_current_screen_border = colors1[4],
                        background = colors1[0],
                        ),
               widget.Sep(
                        linewidth = 1,
                        padding = 10,
                        foreground = colors2[5],
                        background = colors2[0],
                        ),
               widget.WindowName(
                        fontsize = 12,
                        foreground = colors2[1],
                        background = colors2[0],
                        ),
               widget.TextBox(
                        text="  ",
                        foreground = colors2[2],
                        background = colors2[0],
                        fontsize=16,
                        mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(taskmanager)},
                        ),
               widget.Memory(
                        format = '{MemUsed}M/{MemTotal}M',
                        update_interval = 1,
                        fontsize = 12,
                        foreground = colors2[2],
                        background = colors2[0],
                        mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(taskmanager)},
                       ),
               widget.Sep(
                        linewidth = 1,
                        padding = 10,
                        foreground = colors2[5],
                        background = colors2[0]
                        ),
               widget.TextBox(
                        text="  ",
                        foreground=colors2[3],
                        background=colors2[0],
                        padding = 0,
                        fontsize=16
                        ),
               widget.Clock(
                        foreground = colors2[3],
                        background = colors2[0],
                        fontsize = 12,
                        format="%Y-%m-%d %H:%M"
                        ),
               widget.Sep(
                        linewidth = 1,
                        padding = 10,
                        foreground = colors2[5],
                        background = colors2[0]
                        ),
               widget.Systray(
                        background = colors2[0],
                        icon_size=20,
                        padding = 4
                        ),
               widget.Sep(
                        linewidth = 1,
                        padding = 10,
                        foreground = colors2[5],
                        background = colors2[0]
                        ),
               widget.CurrentLayoutIcon(
                       custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
                       background = colors2[0],
                       padding = 0,
                       scale = 0.7
                       ),
               widget.CurrentLayout(
                        foreground = colors2[4],
                        background = colors2[0]
                        ),
              ]
    return widgets_list

#### Setting up Bar for Multiple Monitors ####
## Variable ##
widgets_list = init_widgets_list()
## Screens ##
# Screen 1
def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1
# Screen 2
def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2
# Screen 3
def init_widgets_screen3():
    widgets_screen3 = init_widgets_list()
    return widgets_screen3
## Making Bar Appear ##
# Screen 1
widgets_screen1 = init_widgets_screen1()
# Screen 2
widgets_screen2 = init_widgets_screen2()
# Screen 3
widgets_screen3 = init_widgets_screen3()
## Size of Bar on Different Screens ##
def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), size=26)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), size=26)),
            Screen(top=bar.Bar(widgets=init_widgets_screen3(), size=26))]
screens = init_screens()


########### Startup ###########
#### AutoStart Script ####
@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])
#### Set Cursor ####
@hook.subscribe.startup
def start_always():
    subprocess.Popen(['xsetroot', '-cursor_name', 'left_ptr'])


########### Floating Windows ###########
#### Variable ####
@hook.subscribe.client_new
def set_floating(window):
    if (window.window.get_wm_transient_for()
            or window.window.get_wm_type() in floating_types):
        window.floating = True

#### Types ####
floating_types = ["notification", "toolbar", "splash", "dialog"]

#### Applications ####
floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},
    {'wmclass': 'makebranch'},
    {'wmclass': 'maketag'},
    {'wmclass': 'Arandr'},
    {'wmclass': 'feh'},
    {'wmclass': 'Galculator'},
    {'wmclass': 'Lxpolkit'},
    {'wmclass': 'thunar'},
    {'wname': 'branchdialog'},
    {'wname': 'Open File'},
    {'wname': 'pinentry'},
    {'wmclass': 'ssh-askpass'},

],  fullscreen_border_width = 0, border_width = 0)

focus_on_window_activation = "focus"

wmname = "LG3D"
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
