#! /bin/bash

# Session manager

killall lxsession
lxsession &

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

killall dunst
exec dunst &

# Lxsession

killall lxsession
lxsession &

# Wifi stuff and Bluetooth

killall nm-applet
nm-applet 2>&1 > /dev/null &
killall blueman-applet
blueman-applet &

# Picom situation

killall picom
picom --experimental-backends -b &

# Volume

killall volumeicon
volumeicon &
