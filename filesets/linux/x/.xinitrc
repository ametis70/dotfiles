#!/bin/sh

[ -f ~/.xprofile ] && . ~/.xprofile

if [ $HOST = 'ianmethyst-desktop-arch' ]; then
    xrandr --output DisplayPort-0 --off --output DisplayPort-1 --off --output DisplayPort-2 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-A-0 --off --output DVI-D-0 --off
fi

session=${1:-i3}

case $session in
    i3|i3wm           ) exec i3;;
    steam|steamos     ) exec steamos-session;;
    *                 ) exec $1;;
esac
