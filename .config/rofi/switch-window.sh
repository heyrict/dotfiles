#!/usr/bin/env sh

ROFI_PATH=$(which rofi 2>/dev/null)
WOFI_PATH=$(which wofi 2>/dev/null)
if [ -x "$ROFI_PATH" ]; then
    ROFI_COMMAND="$ROFI_PATH -dmenu -i"
elif [ -x "$WOFI_PATH" ]; then
    ROFI_COMMAND="$WOFI_PATH --dmenu -i"
else
    notify-send "Neither rofi or wofi is found, exit."
    exit 1
fi

swaymsg -t get_tree |
 jq -r '.nodes[].nodes[] | if .nodes then [recurse(.nodes[])] else [] end +  .floating_nodes | .[] | select(.nodes==[]) | ((.id | tostring) + " " + .name)' | $ROFI_COMMAND | {
 read -r id name
 swaymsg "[con_id=$id]" focus
}
