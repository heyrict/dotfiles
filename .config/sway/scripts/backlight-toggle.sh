#!/bin/sh

# Running state lock to avoid repeated call from sway
if [ -f /tmp/backlight-toggle-running ]; then exit 1; fi
touch /tmp/backlight-toggle-running

session_type=$(loginctl show-session $(awk '/tty/ {print $1}' <(loginctl)) -p Type | awk -F= '{print $2}')

if [ $(echo "$session_type" | grep "wayland") ]; then
    ## Workaround as dpms doesn't work
    #read oled < /tmp/oled
    #if [ "$oled" -eq "0" ]; then
    #    echo `brightnessctl get` > /tmp/oled
    #    brightnessctl set 0
    #else
    #    brightnessctl set $oled
    #    echo 0 > /tmp/oled
    #fi

    read oled < /tmp/oled
    if [ "$oled" -eq "0" ]; then
        swaymsg output eDP-1 dpms on
        brightnessctl set `brightnessctl get`
        echo 1 > /tmp/oled
    else
        swaymsg output eDP-1 dpms off
        echo 0 > /tmp/oled
    fi
else
    sleep 1 && xset dpms force off
fi

rm /tmp/backlight-toggle-running
