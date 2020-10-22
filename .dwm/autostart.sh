#! /bin/bash
wmname LG3D &
j4-dmenu-desktop --no-exec --dmenu=echo &
killall dwmblocks
~/suckless/dwmblocks/dwmblocks &
picom -b &
mpd &
mpDris2 &
