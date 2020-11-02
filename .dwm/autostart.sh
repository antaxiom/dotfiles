#! /bin/bash
wmname LG3D &
j4-dmenu-desktop --no-exec --dmenu=echo &
killall dwmblocks
pgrep -fl 'pidswallow -gl' || pidswallow -gl
~/suckless/dwmblocks/dwmblocks &
picom -b &
mpd &
mpDris2 &
