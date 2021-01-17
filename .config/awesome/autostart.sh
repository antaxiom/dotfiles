#! /bin/bash

# Session manager

lxsession &

# Volume

killall volumeicon &

volumeicon &

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

# Wifi stuff, not needed for a desktop but why not

nm-applet 2>&1 > /dev/null &


# Picom situation

killall picom &

sleep 1

picom --experimental-backends -b &
