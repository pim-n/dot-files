#!/bin/sh

xrdb merge ~/.Xresources 
xbacklight -set 10 &
feh --bg-fill ~/.wallpapers/wall.jpg &
xset r rate 200 50 &
picom --no-fading-openclose &
setxkbmap -layout us -variant altgr-intl -option nodeadkeys

~/.config/dwm/scripts/bar.sh &
while type dwm >/dev/null; do dwm && continue || break; done
