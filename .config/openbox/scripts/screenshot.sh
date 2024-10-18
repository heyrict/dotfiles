#!/usr/bin/env sh
date=$(date +%Y-%m-%dT%H:%M:%S)

case "$1" in
    Window) 
        scrot -bu ~/Pictures/Screenshots/${date}.png && notify-send -u low -c system "Screenshot saved successfully to  \`${date}.png\`";;
    Full)
        scrot ~/Pictures/Screenshots/${date}.png && notify-send -u low -c system "Screenshot saved successfully to  \`${date}.png\`";;
    Select)
        scrot -s ~/Pictures/Screenshots/${date}.png && notify-send -u low -c system "Screenshot saved successfully to  \`${date}.png\`";;
    *) echo $1;
esac
