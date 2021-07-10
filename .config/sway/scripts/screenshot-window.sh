#!/usr/bin/env sh
grim -g "`swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"'`" ~/Pictures/Screenshot-`date -Is | cut -d+ -f1`.png && notify-send -u low -c system "Screenshot saved successfully"
