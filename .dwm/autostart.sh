#! /bin/bash
wmname LG3D &
j4-dmenu-desktop --no-exec --dmenu=echo &
picom &
nitrogen --restore &
dunst &
killall dwmblocks
~/suckless/dwmblocks/dwmblocks &
