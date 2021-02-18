#! /bin/bash

# Session manager

lxsession &

# Power management

xfce4-power-manager &

# keybinds

~/.scripts/system/sxhkd-start &

# Greenclip

killall greenclip
greenclip daemon &

# j4-dmenu preloading
j4-dmenu-desktop --dmenu=echo &

# setupkeyboard
~/.scripts/system/keyboardsetup &

#mpd
mpd &
killall mpDris2 &
mpDris2 &

# Walpaper

exec nitrogen --restore &

# Notifications

exec dunst &

# Lxsession

killall lxsession
lxsession &

# Wifi stuff and Bluetooth

nm-applet 2>&1 > /dev/null &
blueman-applet &

# Picom situation

killall picom

picom --experimental-backends -b &

# Volume

killall volumeicon

volumeicon &
