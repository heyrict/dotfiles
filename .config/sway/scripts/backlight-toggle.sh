#!/bin/sh
read oled < /tmp/oled
if [ "$oled" -eq "0" ]; then
    swaymsg "output eDP-1 dpms on"
    brightnessctl set `brightnessctl get`
    echo 1 > /tmp/oled
else
    swaymsg "output eDP-1 dpms off"
    echo 0 > /tmp/oled
fi
