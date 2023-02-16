#!/bin/sh

xrdb merge ~/.Xresources 
xbacklight -set 10 &
feh --bg-fill ~/.wallpapers/wall.jpg &
xset r rate 200 50 &
picom &

~/.config/dwm/scripts/bar.sh &
while type dwm >/dev/null; do dwm && continue || break; done
