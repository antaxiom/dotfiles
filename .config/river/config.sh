#!/bin/sh

# Autostart
riverctl spawn 'waybar'
riverctl spawn 'mako'
riverctl spawn 'nm-applet --indicator'
riverctl spawn '/usr/bin/lxsession'
riverctl spawn '/usr/lib/kdeconnectd'
riverctl spawn 'mpd'
# riverctl spawn 'mkfifo /tmp/riverwob'
riverctl spawn '/usr/lib/xdg-desktop-portal-wlr'
riverctl spawn 'mpDris2'
riverctl spawn 'volumeicon'
riverctl spawn 'blueman-applet'
riverctl spawn 'kanshi'
# riverctl spawn 'syncthing -no-browser'
if -z $SWAYSOCK; then
  riverctl spawn "swayidle -w\
    timeout 1070 'swaylock -f'\
    after-resume 'swaylock'"
fi

# Wallpaper
riverctl spawn "swaybg -o* -c#111111"


# Use the "logo" key as the primary modifier
mod="Mod4"

# Mod+Shift+Return to start an instance of alacritty
riverctl map normal $mod Return spawn alacritty

# Launch wofi -run
riverctl map normal $mod R spawn "dmenu_path | wofi --dmenu | sh"

# Launc wofi -drun
riverctl map normal $mod D spawn "wofi --show drun"

# Screen lock
riverctl map normal $mod f1 spawn 'swaylock -c ~/.config/swaylock/config'

# Cursor behaviour
riverctl focus-follows-cursor normal
riverctl xcursor-theme "elementary"

# Mod+Q to close the focused view
riverctl map normal $mod Q close

# Mod+E to exit river
riverctl map normal $mod+Shift E spawn ~/.local/bin/eww open power-menu

# Mod+C for wofi-emoji
riverctl map normal $mod+Mod1 C spawn "fish -C 'wofi-emoji'"

# Mod+J and Mod+K to focus the next/previous view in the layout stack
riverctl map normal $mod J focus-view next
riverctl map normal $mod K focus-view previous

# Mod+Shift+J and Mod+Shift+K to swap the focused view with the next/previous
# view in the layout stack
riverctl map normal $mod+Shift J swap next
riverctl map normal $mod+Shift K swap previous

# Screenshot with Swappy
# riverctl map normal None print spawn 'fish -c "slurpshot -g"'
riverctl map normal Shift print spawn 'grim - | swappy -f -'

# Screen recording with wf-recorder
# riverctl map normal $mod+Mod1 R spawn 'fish -c "slurpshot -wf"'

# Mod+Period and Mod+Comma to focus the next/previous output
riverctl map normal Control+Mod1 L focus-output next
riverctl map normal Control+Mod1 H focus-output previous

riverctl map normal $mod+Shift L spawn "riverctl send-to-output next; riverctl focus-output next"
riverctl map normal $mod+Shift H spawn "riverctl send-to-output previous; riverctl focus-output previous"

# Mod+Return to bump the focused view to the top of the layout stack, making
# it the new master
riverctl map normal $mod+Shift Return zoom

# Mod+H and Mod+L to decrease/increase the width of the master column by 5%
riverctl map normal $mod H spawn "riverctl mod-option -focused-output main_factor -0.05"
riverctl map normal $mod L spawn "riverctl mod-option -focused-output main_factor +0.05"

# Mod+Shift+H and Mod+Shift+L to increment/decrement the number of
# master views in the layout
riverctl map normal $mod+Control K spawn "riverctl mod-option -focused-output main_amount +1"
riverctl map normal $mod+Control J spawn "riverctl mod-option -focused-output main_amount -1"

# Mod+Alt+{H,J,K,L} to move views
riverctl map normal $mod+Mod1 H move left 100
riverctl map normal $mod+Mod1 J move down 100
riverctl map normal $mod+Mod1 K move up 100
riverctl map normal $mod+Mod1 L move right 100

# Mod+Alt+Control+{H,J,K,L} to snap views to screen edges
riverctl map normal $mod+Mod1+Control H snap left
riverctl map normal $mod+Mod1+Control J snap down
riverctl map normal $mod+Mod1+Control K snap up
riverctl map normal $mod+Mod1+Control L snap right

# Mod+Alt+Shif+{H,J,K,L} to resize views
riverctl map normal $mod+Mod1+Shift H resize horizontal -100
riverctl map normal $mod+Mod1+Shift J resize vertical 100
riverctl map normal $mod+Mod1+Shift K resize vertical -100
riverctl map normal $mod+Mod1+Shift L resize horizontal 100

# Mod + Left Mouse Button to move views
riverctl map-pointer normal $mod BTN_LEFT move-view

# Mod + Right Mouse Button to resize views
riverctl map-pointer normal $mod BTN_RIGHT resize-view

# Mod + Scroll up to switch to previous output
riverctl map-pointer normal $mod KEY_SCROLLUP focus-output previous

# Mod + Scroll up to switch to next output
riverctl map-pointer normal $mod KEY_SCROLLDOWN focus-output next

for i in $(seq 1 9); do
    tagmask=$((1 << ($i - 1)))

    # Mod+[1-9] to focus tag [0-8]
    riverctl map normal $mod $i set-focused-tags $tagmask

    # Mod+Shift+[1-9] to tag focused view with tag [0-8]
    riverctl map normal $mod+Shift $i set-view-tags $tagmask

    # Mod+Ctrl+[1-9] to toggle focus of tag [0-8]
    riverctl map normal $mod+Control $i toggle-focused-tags $tagmask

    # Mod+Shift+Ctrl+[1-9] to toggle tag [0-8] of focused view
    riverctl map normal $mod+Shift+Control $i toggle-view-tags $tagmask
done

# Mod+0 to focus all tags
# Mod+Shift+0 to tag focused view with all tags
all_tags_mask=$(((1 << 32) - 1))
riverctl map normal $mod 0 set-focused-tags $all_tags_mask
riverctl map normal $mod+Shift 0 set-view-tags $all_tags_mask

# Mod+Space to toggle float
riverctl map normal Mod1 Space toggle-float

# Mod+F to toggle fullscreen
riverctl map normal $mod F toggle-fullscreen


# Custom layouts
riverctl map normal $mod+Shift D spawn "riverctl set-option -focused-output inner_layout vd"
riverctl map normal $mod I spawn "riverctl set-option -focused-output inner_layout hD"
riverctl map normal $mod U spawn "riverctl set-option -focused-output inner_layout hhh"
riverctl map normal $mod Y spawn "riverctl set-option -focused-output inner_layout hh"

# Main index
riverctl map normal Control+Mod1 K spawn "riverctl mod-option -focused-output main_index +1"
riverctl map normal Control+Mod1 J spawn "riverctl mod-option -focused-output main_index -1"

# Declare a passthrough mode. This mode has only a single mapping to return to
# normal mode. This makes it useful for testing a nested wayland compositor
riverctl declare-mode passthrough

# Mod+F11 to enter passthrough mode
riverctl map normal $mod F11 enter-mode passthrough

# Mod+F11 to return to normal mode
riverctl map passthrough $mod F11 enter-mode normal

# Various media key mapping for both normal and locked mode
for mode in normal locked
do
	riverctl map "${mode}" None XF86Eject             spawn eject -T
	riverctl map "${mode}" None XF86AudioRaiseVolume  spawn pamixer -i 5
	riverctl map "${mode}" None XF86AudioLowerVolume  spawn pamixer -d 5
	riverctl map "${mode}" None XF86AudioMute         spawn pamixer --toggle-mute
	riverctl map "${mode}" None XF86AudioMedia        spawn playerctl play-pause
	riverctl map "${mode}" None XF86AudioPlay         spawn playerctl play-pause
	riverctl map "${mode}" None XF86AudioPrev         spawn playerctl previous
	riverctl map "${mode}" None XF86AudioNext         spawn playerctl next
	riverctl map "${mode}" None XF86MonBrightnessUp   spawn light -A 5
	riverctl map "${mode}" None XF86MonBrightnessDown spawn light -U 5
done

# Set repeat rate
riverctl set-repeat 50 300

# Set the layout on startup

# Set new windows at the bottom of the stack
riverctl attach-mode bottom

# Set app-ids of views which should float
riverctl float-filter-add "float"
riverctl float-filter-add "popup"

# Set app-ids of views which should use client side decorations
# riverctl csd-filter-add "swappy"
riverctl float-filter-add "swappy"
# riverctl csd-filter-add "firefox"

# Set opacity and fade effect
riverctl opacity 1.0 0.95 0.0 0.1 20

# Border color focused
riverctl border-color-focused '#61afef'

# Border color focused
riverctl border-color-unfocused '#33333'

# Border width
riverctl border-width 3

# River-option
for output in "DP-1" "HDMI-A-1"
do
  # River options
  riverctl set-option -focused-output outer_padding 8
  riverctl set-option -focused-output view_padding 8
  riverctl set-option -focused-output main_factor 0.6
  riverctl declare-option -focused-output main_amount uint 1
  riverctl declare-option -focused-output smart_padding uint 0
  riverctl declare-option -focused-output xoffset int 0
  riverctl declare-option -focused-output outer_layout string v
  riverctl declare-option -focused-output inner_layout string hh
  riverctl declare-option -focused-output main_index int 0
  case $output in
    DP-2 )
      riverctl spawn "~/.local/bin/kile -n kile_dp1 -m 0"
      riverctl set-option -focused-output layout kile_dp2
      riverctl declare-option -focused-output layout_per_tag string '1:f:tv'
      ;;
    HDMI-A-1 )
      riverctl spawn "~/.local/bin/kile -n kile_hdmi1 -m 1"
      riverctl set-option -focused-output layout kile_hdmi1
      riverctl declare-option -focused-output layout_per_tag string '32:v:hth'
      ;;
  esac
  riverctl attach-mode bottom
  riverctl focus-output next
done

riverctl focus-output next

# Eww Widgets
riverctl spawn '~/.local/bin/eww daemon'
~/.local/bin/eww ping
