#! /bin/bash
wmname LG3D &
picom &
nitrogen --restore &
dunst &
killall dwmblocks
~/suckless/dwmblocks/dwmblocks &
# Setup secondary monitor
xrandr --output HDMI-A-0 --mode 1920x1080 --same-as DisplayPort-2 --scale 2.0x2.0
