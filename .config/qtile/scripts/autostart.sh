#!/bin/bash

#? Proper alignment of monitors
if cat /proc/cpuinfo | grep hypervisor; then
    xrandr -s 1920x1080 &
else
    case $(optimus-manager --print-mode) in
    "Current GPU mode : nvidia") xrandr --output HDMI-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --rate 165 --output eDP-1-1 --mode 1920x1080 --pos 0x0 --rotate normal ;;
    "Current GPU mode : hybrid") xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --rate 165 ;;
    esac
fi

#? Autostart
# Network Manager
nm-applet &
# Power Manager
xfce4-power-manager &
# Bluetooth
blueberry-tray &
# Compositor
picom &
# Session Manager
lxsession &
# Battery Icon --- Credits for this go to https://github.com/valr/cbatticon
~/.config/qtile/cbatticon/cbatticon -i notification &
# Notify Daemon
/usr/lib/xfce4/notifyd/xfce4-notifyd &
# For taking screenshots
flameshot &

#? Setting Background
nitrogen --head=1 --random --set-zoom-fill ~/wallpapers &
sleep 2
nitrogen --head=0 --random --set-zoom-fill ~/wallpapers &
