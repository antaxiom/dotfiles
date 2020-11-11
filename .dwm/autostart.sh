#! /bin/bash
wmname LG3D &
j4-dmenu-desktop --dmenu=echo &
killall dwmblocks
~/suckless/dwmblocks/dwmblocks &
~/.scripts/system/keyboardsetup &
picom --experimental-backends -b &
mpd &
mpDris2 &
pgrep -fl 'pidswallow -gl' || pidswallow -gl &
