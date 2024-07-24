# Starting of the configuration
#! --------------------------------------------------
#! ---------- Imports
#! --------------------------------------------------
import os
import subprocess
from libqtile import layout, bar, widget, hook, qtile
from libqtile.config import Drag, Group, Key, Match, Screen, KeyChord
from libqtile.lazy import lazy


# ? Requires qtile-extras package from pacman
# ? sudo pacman -S qtile-extras
from qtile_extras import widget
from qtile_extras.widget.decorations import BorderDecoration


#! --------------------------------------------------
#! ---------- Variables
#! --------------------------------------------------
# ? ---- Mod Keys ----
leader = "mod4"  # ? Windows/Super Key
alt = "mod1"
ctrl = "control"

# ? ---- Special Characters ----
# * -- The home directory
home = os.path.expanduser("~")

# ? ---- Applications ----
browser = "brave"
files = "thunar"
logout = home + "/.config/qtile/rofi/logout.sh"
run = home + "/.config/qtile/rofi/launcher.sh"
terminal = "kitty"
code = f"{terminal} -e nvim"
taskmanager = f"{terminal} -e 'htop'"
calendar = f"{terminal} -e bash -c \"cal -y; read -p 'Press Enter to exit...'\""
chat = "discord"
virtual = "virt-manager"
# music = "apple-music-desktop.sh"
music = "spotify"


#! --------------------------------------------------
#! ---------- Key Bindings
#! --------------------------------------------------
# ? --- A function to minimize all the open windows ---
@lazy.function
def minimize_all(qtile):
    for i in range(0, 9):
        for win in qtile.groups[i].windows:
            if hasattr(win, "toggle_minimize"):
                win.toggle_minimize()


# ? --- A function to maximize current window ---
@lazy.function
def maximize_by_switching_layout(qtile):
    current_layout_name = qtile.current_group.layout.name
    if current_layout_name == "monadtall":
        qtile.current_group.layout = "max"
    elif current_layout_name == "max":
        qtile.current_group.layout = "monadtall"


# ? --- Move Window to Previous Screen
def window_to_previous_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i - 1)


# ? --- Move Window to Next Screen
def window_to_next_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i + 1)


keys = [
    # ? ---- Layout Modifications ----
    ## Switching Between Open Applications ##
    # Switch Between Apps
    Key([leader], "k", lazy.layout.up()),
    # Switch Between Apps
    Key([leader], "j", lazy.layout.down()),
    # Switch Between Apps
    Key([leader], "l", lazy.layout.right()),
    # Switch Between Apps
    Key([leader], "h", lazy.layout.left()),
    # Switch Between Apps
    Key([alt], "Tab", lazy.layout.next()),
    ## Changing the Size of Open Applications ##
    # Increase Size
    Key(
        [leader, "shift"],
        "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
    ),
    # Decrease Size
    Key(
        [leader, "shift"],
        "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
    ),
    ## Split the panes in Master and stack ##
    Key([leader, "shift"], "space", lazy.layout.flip()),
    ## Change the Layout ##
    Key([leader], "Tab", lazy.next_layout()),
    ## Toggle Full Screen ##
    ## Toggle Floating ##
    Key([leader, "shift"], "t", lazy.window.toggle_floating()),
    ## Growing/ Shrinking the layouts ##
    Key([leader], "equal", lazy.layout.grow()),
    Key([leader], "minus", lazy.layout.shrink()),
    ## Hide/Unhide all windows ##
    Key([leader], "d", minimize_all()),
    ## Hide/Unhide a singular window ##
    Key([leader, "shift"], "x", lazy.window.toggle_minimize()),
    ## Maximize Window ##
    Key(
        [leader, "shift"],
        "f",
        maximize_by_switching_layout(),
        lazy.window.toggle_fullscreen(),
        lazy.hide_show_bar(),
    ),
    # ? --- Moving Windows through Screens ---
    ## Move focus to previous Screen ##
    Key([leader], "comma", lazy.prev_screen()),
    ## Move focus to next Screen ##
    Key([leader], "period", lazy.next_screen()),
    ## Move window to previous Screen ##
    Key(
        [leader, "shift"],
        "comma",
        lazy.function(window_to_next_screen, switch_screen=True),
    ),
    ## Move window to next Screen ##
    Key(
        [leader, "shift"],
        "period",
        lazy.function(window_to_previous_screen, switch_screen=True),
    ),
    # ? ---- Qtile ----
    ## Exiting and Restarting ##
    # Restart Qtile
    Key([leader, "shift"], "r", lazy.restart()),
    # Logout Menu
    Key([leader, "shift"], "q", lazy.spawn(logout)),
    # Closing Applications
    Key([leader, "shift"], "c", lazy.window.kill()),
    # ? --- Applications ----
    # Terminal
    Key([leader], "Return", lazy.spawn(terminal)),
    Key([leader], "KP_Enter", lazy.spawn(terminal)),
    # Browser
    Key([leader, ctrl], "b", lazy.spawn(browser)),
    # Text Editing
    Key([leader, ctrl], "e", lazy.spawn(code)),
    # File Manager
    Key([leader], "e", lazy.spawn(files)),
    # Chat Application
    Key([leader, ctrl], "d", lazy.spawn(chat)),
    # X Kill
    Key([leader], "Escape", lazy.spawn("xkill")),
    # Run Launcher
    Key([leader, "shift"], "Return", lazy.spawn(run)),
    # Task Manager
    Key([ctrl, "shift"], "Escape", lazy.spawn(taskmanager)),
    # Virtualization Software
    Key([leader, ctrl], "v", lazy.spawn(virtual)),
    # ScreenShots
    Key([], "Print", lazy.spawn("flameshot gui")),
    Key([leader, ctrl], "s", lazy.spawn(music)),
    # ? -- Multimedia Keys --
    # Increase Volume
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer sset Master 5%+")),
    # Decrease Volume
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer sset Master 5%-")),
    # Mute Volume
    Key([], "XF86AudioMute", lazy.spawn("amixer sset Master 1+ toggle")),
    # Pause/Play
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    # Next
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    # Previous
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    # Increase Brightness
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 5")),
    # Decrease Brightness
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 5")),
    # ? --- Key Chords ---
    # ? --- Spawning Config ---
    KeyChord(
        [leader],
        "c",
        [
            Key([], "o", lazy.spawn(f"{code} {home}/.config/qtile/")),
            Key([], "1", lazy.spawn(f"{code} {home}/.config/qtile/config.py")),
            Key(
                [], "2", lazy.spawn(f"{code} {home}/.config/qtile/scripts/autostart.sh")
            ),
            Key(
                [],
                "h",
                lazy.spawn(f"{browser} {home}/.config/qtile/scripts/keybindings.html"),
            ),
        ],
    ),
    # ? --- Logout Hotkeys ---
    KeyChord(
        [leader, "shift"],
        "x",
        [
            Key([], "u", lazy.spawn("shutdown now")),
            Key([], "r", lazy.spawn("shutdown now -r")),
            Key([], "s", lazy.spawn("killall qtile")),
            Key([], "l", lazy.spawn('betterlockscreen -l dim -- --time-str="%H:%M"')),
            Key(
                [],
                "h",
                lazy.spawn("amixer set Master mute; mpc -q pause; systemctl suspend"),
            ),
        ],
    ),
    # ? --- Changing Wallpaper ---
    KeyChord(
        [leader],
        "w",
        [
            Key(
                [],
                "1",
                lazy.spawn(f"nitrogen --random --set-zoom-fill {home}/wallpapers"),
            ),
            Key(
                [],
                "2",
                lazy.spawn(
                    f"nitrogen --head=0 --random --set-zoom-fill {home}/wallpapers"
                ),
            ),
            Key(
                [],
                "3",
                lazy.spawn(
                    f"nitrogen --head=1 --random --set-zoom-fill {home}/wallpapers"
                ),
                lazy.spawn(
                    f"nitrogen --head=0 --random --set-zoom-fill {home}/wallpapers"
                ),
            ),
        ],
    ),
]


# ? ---- Moving applications across different monitors
def get_monitors():
    xr = (
        subprocess.check_output('xrandr --query | grep " connected"', shell=True)
        .decode()
        .split("\n")
    )
    monitors = len(xr) - 1 if len(xr) > 2 else len(xr)
    return monitors


monitors = get_monitors()
for i in range(monitors):
    keys.extend([Key([leader, alt], str(i + 1), lazy.window.toscreen(i))])


#! --------------------------------------------------
#! ---------- Mouse Bindings
#! --------------------------------------------------
mouse = [
    Drag(
        [leader],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [leader],
        "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size(),
    ),
]


#! --------------------------------------------------
#! ---------- Workspaces
#! --------------------------------------------------
# * The Names of Applications after the Layout is to Move the Application to the Workspace.
group_names = [
    ("1", {"layout": "monadtall"}),
    ("2", {"layout": "monadtall"}),
    ("3", {"layout": "monadtall"}),
    ("4", {"layout": "monadtall"}),
    ("5", {"layout": "monadtall"}),
    ("6", {"layout": "monadtall"}),
    ("7", {"layout": "monadtall"}),
    ("8", {"layout": "monadtall"}),
    ("9", {"layout": "monadtall"}),
]


# ? ---- To switch workspaces ----
groups = [Group(name, **kwargs) for name, kwargs in group_names]
for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([leader], str(i), lazy.group[name].toscreen()))
    keys.append(
        Key(
            [leader, "shift"],
            str(i),
            lazy.window.togroup(name),
            lazy.group[name].toscreen(),
        )
    )
    keys.append(Key([leader, ctrl], str(i), lazy.window.togroup(name)))


#! --------------------------------------------------
#! ---------- Layouts
#! --------------------------------------------------
# ? ---- Colors for the layouts and bar ----
colors = [
    ["#282c34", "#282c34"],  # bg
    ["#bbc2cf", "#bbc2cf"],  # fg
    ["#1c1f24", "#1c1f24"],  # color01
    ["#ff6c6b", "#ff6c6b"],  # color02
    ["#98be65", "#98be65"],  # color03
    ["#da8548", "#da8548"],  # color04
    ["#51afef", "#51afef"],  # color05
    ["#c678dd", "#c678dd"],  # color06
    ["#46d9ff", "#46d9ff"],  # color15
]


layouts = [
    layout.MonadTall(
        margin=8, border_width=2, border_focus=colors[8], border_normal=colors[0]
    ),
    layout.Floating(border_focus=colors[8], border_normal=colors[0]),
    layout.Max(margin=0),
]


#! --------------------------------------------------
#! ---------- Bar
#! --------------------------------------------------

#! CREDITS FOR THE BAR GOES TO DISTROTUBE
#! https://gitlab.com/dwt1
#! https://youtube.com/DistroTube

# ? ---- Widgets for the bar ----
## Defaults ##
widget_defaults = dict(font="Ubuntu Bold", fontsize=12, padding=0, background=colors[0])
extension_defaults = widget_defaults.copy()


## Widgets ##
def init_widgets_list():
    widgets_list = [
        widget.Image(
            filename="~/.config/qtile/icons/python.png",
            scale="False",
            mouse_callbacks={"Button1": lambda: qtile.cmd_spawn(run)},
        ),
        widget.Prompt(font="Ubuntu Mono", fontsize=14, foreground=colors[1]),
        widget.GroupBox(
            fontsize=13,
            margin_y=5,
            margin_x=5,
            padding_y=0,
            padding_x=1,
            borderwidth=3,
            active=colors[8],
            inactive=colors[1],
            hide_unused=True,
            rounded=False,
            highlight_color=colors[2],
            highlight_method="line",
            this_current_screen_border=colors[7],
            this_screen_border=colors[4],
            other_current_screen_border=colors[7],
            other_screen_border=colors[4],
            disable_drag=True,
        ),
        widget.TextBox(
            text="|", font="Ubuntu Mono", foreground=colors[1], padding=2, fontsize=14
        ),
        widget.CurrentLayoutIcon(
            custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
            foreground=colors[1],
            padding=4,
            scale=0.6,
        ),
        widget.CurrentLayout(foreground=colors[1], padding=5),
        widget.TextBox(
            text="|", font="Ubuntu Mono", foreground=colors[1], padding=2, fontsize=14
        ),
        widget.WindowName(foreground=colors[6], max_chars=40),
        widget.CheckUpdates(
            update_interval=60,
            distro="Arch_checkupdates",
            fmt="🗘  {}",
            colour_have_updates=colors[7],
            colour_no_updates=colors[7],
            foreground=colors[7],
            decorations=[
                BorderDecoration(
                    colour=colors[7],
                    border_width=[0, 0, 2, 0],
                )
            ],
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn(
                    terminal
                    + " -e "
                    + home
                    + "/.config/qtile/scripts/TermApps/updates.sh"
                )
            },
        ),
        widget.Spacer(length=8),
        widget.GenPollText(
            update_interval=300,
            func=lambda: subprocess.check_output(
                "printf $(uname -r)", shell=True, text=True
            ),
            foreground=colors[3],
            fmt="❤  {}",
            decorations=[
                BorderDecoration(
                    colour=colors[3],
                    border_width=[0, 0, 2, 0],
                )
            ],
        ),
        widget.Spacer(length=8),
        widget.CPU(
            format="▓  Cpu: {load_percent}%",
            foreground=colors[4],
            decorations=[
                BorderDecoration(
                    colour=colors[4],
                    border_width=[0, 0, 2, 0],
                )
            ],
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn(
                    terminal
                    + " -e "
                    + home
                    + "/.config/qtile/scripts/TermApps/opencpu.sh"
                )
            },
        ),
        widget.Spacer(length=8),
        widget.Memory(
            foreground=colors[8],
            format="{MemUsed: .0f}{mm}",
            fmt="🖥  Mem: {} used",
            decorations=[
                BorderDecoration(
                    colour=colors[8],
                    border_width=[0, 0, 2, 0],
                )
            ],
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn(
                    terminal
                    + " -e "
                    + home
                    + "/.config/qtile/scripts/TermApps/openmem.sh"
                )
            },
        ),
        widget.Spacer(length=8),
        widget.DF(
            update_interval=60,
            foreground=colors[5],
            partition="/",
            # format = '[{p}] {uf}{m} ({r:.0f}%)',
            format="{uf}{m} free",
            fmt="🖴  Disk: {}",
            visible_on_warn=False,
            decorations=[
                BorderDecoration(
                    colour=colors[5],
                    border_width=[0, 0, 2, 0],
                )
            ],
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn(
                    terminal
                    + " -e "
                    + home
                    + "/.config/qtile/scripts/TermApps/opendf.sh"
                )
            },
        ),
        widget.Spacer(length=8),
        widget.Volume(
            foreground=colors[4],
            fmt="🕫  Vol: {}",
            decorations=[
                BorderDecoration(
                    colour=colors[4],
                    border_width=[0, 0, 2, 0],
                )
            ],
            mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("pavucontrol")},
        ),
        widget.Spacer(length=8),
        widget.Clock(
            foreground=colors[8],
            format="⏱  %a, %b %d - %H:%M",
            decorations=[
                BorderDecoration(
                    colour=colors[8],
                    border_width=[0, 0, 2, 0],
                )
            ],
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn(
                    terminal
                    + " -e "
                    + home
                    + "/.config/qtile/scripts/TermApps/opencal.sh"
                )
            },
        ),
        widget.Spacer(length=8),
        widget.Systray(padding=3),
        widget.Spacer(length=8),
    ]
    return widgets_list


## Setting different widget layouts for different screens ##
# * Screen 1 -- With Sys tray
def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1


# * Screen 2 -- Without Sys tray
def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    del widgets_screen2[22:24]
    return widgets_screen2


## Displaying the bar on screens ##
def init_screens():
    return [
        Screen(top=bar.Bar(widgets=init_widgets_screen1(), size=26)),
        Screen(top=bar.Bar(widgets=init_widgets_screen2(), size=30)),
    ]


screens = init_screens()

dgroups_key_binder = None
dgroups_app_rules = []


#! --------------------------------------------------
#! ---------- Assign apps to different screens
#! --------------------------------------------------
@hook.subscribe.client_new
def assign_app_group(client):
    # ? ---- Assigning the applications ----
    d = {}
    d[group_names[0][0]] = [
        "Firefox",
        "Vivaldi-stable",
        "Vivaldi-snapshot",
        "Chromium",
        "Google-chrome",
        "Brave",
        "Brave-browser",
        "firefox",
        "vivaldi-stable",
        "vivaldi-snapshot",
        "chromium",
        "google-chrome",
        "brave",
        "brave-browser",
        "microsoft-edge",
        "Microsoft-edge",
    ]
    d[group_names[1][0]] = [
        "Atom",
        "Subl",
        "Geany",
        "Brackets",
        "Code-oss",
        "Code",
        "TelegramDesktop",
        "Discord",
        "atom",
        "subl",
        "geany",
        "brackets",
        "code-oss",
        "code",
        "telegramDesktop",
        "discord",
    ]
    d[group_names[2][0]] = ["Alacritty", "Konsole", "alacritty", "konsole", "kitty"]
    d[group_names[3][0]] = ["TelegramDesktop", "Discord", "telegramDesktop", "discord"]
    d[group_names[4][0]] = [
        "VirtualBox Manager",
        "VirtualBox Machine",
        "Vmplayer",
        "virtualbox manager",
        "virtualbox machine",
        "vmplayer",
        "virt-manager",
        "Virt-manager",
    ]
    d[group_names[5][0]] = ["Spotify", "spotify", "apple music", "Apple Music"]
    d[group_names[6][0]] = ["Vlc", "Mpv" "vlc", "mpv"]
    d[group_names[7][0]] = []

    # ? ---- Moving them ----
    wm_class = client.window.get_wm_class()[0]
    for i in range(len(d)):
        if wm_class in list(d.values())[i]:
            group = list(d.keys())[i]
            client.togroup(group)
            client.group.cmd_toscreen(toggle=False)


#! --------------------------------------------------
#! ---------- Startup
#! --------------------------------------------------
main = None


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/scripts/autostart.sh"])


@hook.subscribe.startup
def start_always():
    # Set the cursor to something sane in X
    subprocess.Popen(["xsetroot", "-cursor_name", "left_ptr"])


#! --------------------------------------------------
#! ---------- Floating Windows
#! --------------------------------------------------
@hook.subscribe.client_new
def set_floating(window):
    if (
        window.window.get_wm_transient_for()
        or window.window.get_wm_type() in floating_types
    ):
        window.floating = True


floating_types = ["notification", "toolbar", "splash", "dialog"]

floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="Arcolinux-welcome-app.py"),
        Match(wm_class="Arcolinux-calamares-tool.py"),
        Match(wm_class="confirm"),
        Match(wm_class="dialog"),
        Match(wm_class="download"),
        Match(wm_class="error"),
        Match(wm_class="file_progress"),
        Match(wm_class="notification"),
        Match(wm_class="splash"),
        Match(wm_class="toolbar"),
        Match(wm_class="Arandr"),
        Match(wm_class="feh"),
        Match(wm_class="Galculator"),
        Match(wm_class="archlinux-logout"),
        Match(wm_class="xfce4-terminal"),
        Match(wm_class="thunar"),
    ],
    fullscreen_border_width=0,
    border_width=0,
)


auto_fullscreen = True
focus_on_window_activation = "focus"
wmname = "LG3D"
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
