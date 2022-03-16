#!/usr/bin/env sh
date=$(date +%Y-%m-%dT%H:%M:%S)

case "$1" in
    Window) 
        win_pos=$(swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')
        grim -g "${win_pos}" ~/Pictures/Screenshot-${date}.png;;
    Full)
        grim ~/Pictures/Screenshot-${date}.png;;
    Select)
        grim -g "`slurp`" ~/Pictures/Screenshot-${date}.png;;
    *) echo $1;
esac

notify-send -u low -c system "Screenshot saved successfully"
