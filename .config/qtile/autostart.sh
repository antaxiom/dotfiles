#! /bin/bash

# If picom is running, kill it to prevent multiple instances
if ps -A | grep picom; then
	killall -q picom
fi


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
