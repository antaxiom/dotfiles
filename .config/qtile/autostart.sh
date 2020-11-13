#! /bin/bash

picom --experimental-backends -b &

# keybinds

sxhkd &

# j4-dmenu preloading
j4-dmenu-desktop --dmenu=echo &

# setupkeyboard
~/.scripts/system/keyboardsetup &

#mpd
mpd &
mpDris2 &

#pidswallow
pgrep -fl 'pidswallow -gl' || pidswallow -gl &

# Walpaper

exec nitrogen --restore &

# Notifications

exec dunst &

# Hotkeys
sxhkd &
