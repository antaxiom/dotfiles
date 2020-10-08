#! /bin/bash
wmname LG3D &
j4-dmenu-desktop --no-exec --dmenu=echo &
picom -b &
killall dwmblocks
~/suckless/dwmblocks/dwmblocks &
