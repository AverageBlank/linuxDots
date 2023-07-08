#!/bin/bash
# Defining a function run 
function run {
  if ! pgrep -x $(basename $1 | head -c 15) 1>/dev/null;
  then
    $@&
  fi
}


# Proper alignment of my monitors 
case `optimus-manager --print-mode` in 
    "Current GPU mode : nvidia") xrandr --output HDMI-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output eDP-1-1 --mode 1920x1080 --pos 0x0 --rotate normal ;;
    "Current GPU mode : hybrid") xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal ;;
esac


# Autostart 
nm-applet &
pamac-tray &
xfce4-power-manager &
blueberry-tray &
picom &
lxsession &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
volumeicon &
nitrogen --restore &
