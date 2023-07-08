# Starting of the configuration
#! --------------------------------------------------
#! ---------- Imports
#! --------------------------------------------------
import os
import socket
import subprocess
from typing import List
from libqtile import layout, bar, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen, Rule
from libqtile.command import lazy
import arcobattery

#! --------------------------------------------------
#! ---------- Key Shortcuts
#! --------------------------------------------------
#? ---- Mod Keys ----
super       = "mod4"                                             # Super is the Windows Key
alt         = "mod1"
ctrl        = "control"

#? ---- Special Characters ----
home        = os.path.expanduser('~')

#? ---- Applications ----
browser     = "brave"                                            # Browser
code        = "code"                                             # Text Editing
files       = "thunar"                                           # File Manager
logout      = "arcolinux-logout"                                 # Logout Tool
run         = "dmenu -p run"                                     # Run Launcher
taskmanager = "alacritty -e'htop'"                               # Task Manager
terminal    = "alacritty"                                        # Terminal
chat        = "discord"                                          # Chat Application
virtual     = "virt-manager"                                     # Virtualization Software
config      = "emacs '~/.config/qtile/config.py'"                # Qtile Config


#! --------------------------------------------------
#! ---------- Key Bindings
#! --------------------------------------------------
keys = [
    #? ---- Layout Modifications ----
    ## Switching Between Open Applications ##
    # Switch Between Apps
    Key([super], "k", lazy.layout.up()),
    # Switch Between Apps
    Key([super], "j", lazy.layout.down()),
    # Switch Between Apps
    Key([super], "l", lazy.layout.right()),
    # Switch Between Apps
    Key([super], "h", lazy.layout.left()),
    # Switch Between Apps
    Key([alt], "Tab", lazy.layout.next()),
    ## Changing the Size of Open Applications ##
    # Increase Size
    Key([super, "shift"], "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        ),
    # Decrease Size
    Key([super, "shift"], "h",
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

    #? ---- Qtile ----
    ## Exiting and Restarting ##
    # Restart Qtile
    Key([super, "shift"], "r", lazy.restart()),
    # Quit Qtile
    Key([super, "shift"], "q", lazy.shutdown()),
    # Closing Applications
    Key([super, "shift"], "c", lazy.window.kill()),

    #? --- Applications ----
    # Terminal
    Key([super], "Return", lazy.spawn(terminal)),
    Key([super], "KP_Enter", lazy.spawn(terminal)),
    # Browser
    Key([super, "shift"], "b", lazy.spawn(browser)),
    # Text Editing
    Key([super, "shift"], "e", lazy.spawn(code)),
    # File Manager
    Key([super], "e", lazy.spawn(files)),
    # Logout Tool
    Key([super], "x", lazy.spawn(logout)),
    # Chat Application
    Key([super, "shift"], "d", lazy.spawn(chat)),
    # X Kill
    Key([super], "Escape", lazy.spawn('xkill')),
    # Run Launcher
    Key([super, "shift"], "Return", lazy.spawn(run)),
    # Task Manager
    Key([ctrl, "shift"], "Escape", lazy.spawn(taskmanager)),
    # Virtualization Software
    Key([super, "shift"], "v", lazy.spawn(virtual)),
    # ScreenShots
    Key([], "Print", lazy.spawn("flameshot gui")),
    # Config
    Key([super, "shift"], "h", lazy.spawn(config))
]

#? ---- Moving applications across different monitors
def get_monitors():
    xr = subprocess.check_output('xrandr --query | grep " connected"', shell=True).decode().split('\n')
    monitors = len(xr) - 1 if len(xr) > 2 else len(xr)
    return monitors
    

monitors = get_monitors()
for i in range(monitors):

    keys.extend([Key([super, ctrl], str(i+1), lazy.window.toscreen(i))])


#! --------------------------------------------------
#! ---------- Mouse Bindings
#! --------------------------------------------------
mouse = [
    Drag([super], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([super], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size())
]


#! --------------------------------------------------
#! ---------- Workspaces
#! --------------------------------------------------
def window_to_previous_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i - 1)


def window_to_next_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i + 1)


#* The Names of Applications after the Layout is to Move the Application to the Workspace.
group_names = [
                ("Web", {'layout': 'max'}),
                ("Dev", {'layout': 'monadtall'}),
                ("Sys", {'layout': 'monadtall'}),
                ("Chat", {'layout': 'max'}),
                ("Vbox", {'layout': 'max'}),
                ("Music", {'layout': 'max'}),
                ("Video", {'layout': 'max'}),
                ("Misc", {'layout': 'monadtall'})
               ]

keys.extend([
    #* Move window to next screen
    Key([super,"shift"], "Right", lazy.function(window_to_next_screen, switch_screen=True)),
    Key([super,"shift"], "Left", lazy.function(window_to_previous_screen, switch_screen=True)),
])
#? ---- To switch workspaces ----
groups = [Group(name, **kwargs) for name, kwargs in group_names]
for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([super], str(i), lazy.group[name].toscreen()))
    keys.append(Key([super, "shift"], str(i), lazy.window.togroup(name), lazy.group[name].toscreen()))


#! --------------------------------------------------
#! ---------- Layouts
#! --------------------------------------------------
layouts = [
    layout.MonadTall(margin=8, border_width=2, border_focus="#5e81ac", border_normal="#4c566a"),
    layout.Floating(border_focus="#5e81ac", border_normal="#4c566a"),
    layout.Max(margin=0)]


#! --------------------------------------------------
#! ---------- Bar
#! --------------------------------------------------
#? ---- Colors for the bar ----
## Colors for the Workspaces ##
colors1 = [["#282828", "#282828"],                         # BackGround Color
           ["#4e8aa0", "#4e8aa0"],                         # Workspaces with Open Applications
           ["#e78a4e", "#e78a4e"],                         # Workspaces with no Applications
           ["#3d3f4b", "#3d3f4b"],                         # Highlight Current Workspace
           ["#ea6962", "#ea6962"]]                         # Line Color
## Colors for the Widgets ##
colors2 = [["#282828", "#282828"],                         # BackGround Color
           ["#7daea3", "#7daea3"],                         # Window Name Color
           ["#e78a4e", "#e78a4e"],                         # Ram Color
           ["#dfbf8e", "#dfbf8e"],                         # Clock Color
           ["#ea6962", "#ea6962"],                         # Layout Color
           ["#c0c5ce", "#c0c5ce"]]                         # Text Color

#? ---- Widgets for the bar ----
## Defaults ##
def init_widgets_defaults():
    return dict(font="Noto Sans",
                fontsize = 12,
                padding = 2,
                background=colors2[0])
widget_defaults = init_widgets_defaults()
## Widgets ##
#* Screen 1
def init_widgets_list1():
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


#* Screen 2
def init_widgets_list2():
    widgets_list2 = [
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
    return widgets_list2

    #? ---- Setting up the bar for multiple monitors ----
## Variable ##
widgets_list = init_widgets_list1()
widgets_list2 = init_widgets_list2()
## Screens ##
# Screen 1
def init_widgets_screen1():
    widgets_screen1 = init_widgets_list1()
    return widgets_screen1
# Screen 2
def init_widgets_screen2():
    widgets_screen2 = init_widgets_list2()
    return widgets_screen2
## Making Bar Appear ##
# Screen 1
widgets_screen1 = init_widgets_screen1()
# Screen 2
widgets_screen2 = init_widgets_screen2()
## Size of Bar on Different Screens ##
def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), size=26)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), size=26))]
screens = init_screens()


#! --------------------------------------------------
#! ---------- Assign apps to different screens
#! --------------------------------------------------
@hook.subscribe.client_new
def assign_app_group(client):
    #? ---- Assigning the applications ----
    d = {}
    d[group_names[0][0]] = ["Firefox", "Vivaldi-stable", "Vivaldi-snapshot", "Chromium", "Google-chrome", "Brave", "Brave-browser",
                            "firefox", "vivaldi-stable", "vivaldi-snapshot", "chromium", "google-chrome", "brave", "brave-browser"]
    d[group_names[1][0]] = ["Atom", "Subl", "Geany", "Brackets", "Code-oss", "Code", "TelegramDesktop", "Discord",
                            "atom", "subl", "geany", "brackets", "code-oss", "code", "telegramDesktop", "discord"]
    d[group_names[2][0]] = ["Alacritty", "Konsole", "alacritty", "konsole"]
    d[group_names[3][0]] = ["TelegramDesktop", "Discord", "telegramDesktop", "discord"]
    d[group_names[4][0]] = ["VirtualBox Manager", "VirtualBox Machine", "Vmplayer",
                            "virtualbox manager", "virtualbox machine", "vmplayer"]
    d[group_names[5][0]] = ["Spotify", "spotify"]
    d[group_names[6][0]] = ["Vlc", "Mpv"
                            "vlc", "mpv"]
    d[group_names[7][0]] = []

    #? ---- Moving them ----
    wm_class = client.window.get_wm_class()[0]
    for i in range(len(d)):
        if wm_class in list(d.values())[i]:
            group = list(d.keys())[i]
            client.togroup(group)
            client.group.cmd_toscreen(toggle=False)


#! --------------------------------------------------
#! ---------- Startup
#! --------------------------------------------------
@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

@hook.subscribe.startup
def start_always():
    # Set the cursor to something sane in X
    subprocess.Popen(['xsetroot', '-cursor_name', 'left_ptr'])


#! --------------------------------------------------
#! ---------- Floating Windows
#! --------------------------------------------------
@hook.subscribe.client_new
def set_floating(window):
    if (window.window.get_wm_transient_for()
            or window.window.get_wm_type() in floating_types):
        window.floating = True

floating_types = ["notification", "toolbar", "splash", "dialog"]

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
    Match(wm_class='Arcolinux-welcome-app.py'),
    Match(wm_class='Arcolinux-calamares-tool.py'),
    Match(wm_class='confirm'),
    Match(wm_class='dialog'),
    Match(wm_class='download'),
    Match(wm_class='error'),
    Match(wm_class='file_progress'),
    Match(wm_class='notification'),
    Match(wm_class='splash'),
    Match(wm_class='toolbar'),
    Match(wm_class='Arandr'),
    Match(wm_class='feh'),
    Match(wm_class='Galculator'),
    Match(wm_class='archlinux-logout'),
    Match(wm_class='xfce4-terminal'),
    Match(wm_class='thunar'),

],  fullscreen_border_width = 0, border_width = 0)


auto_fullscreen = True
focus_on_window_activation = "focus"
wmname = "LG3D"
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

