#! /bin/bash

# Volume

killall volumeicon &

volumeicon &

# keybinds

~/.scripts/system/sxhkd-start

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

# Wifi stuff and Bluetooth, not needed for a desktop but why not

nm-applet 2>&1 > /dev/null &
blueman-applet &

# Picom situation

killall picom &

sleep 1

picom --experimental-backends -b &
