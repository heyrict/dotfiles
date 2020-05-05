#!/usr/bin/env bash

current_wid=$(xdotool getactivewindow)
selection=$(rofi -i -dmenu -p kaomoji $@ < $(dirname $0)/kaomoji.txt)
kaomoji=$(echo $selection | sed "s/\t.*//")
xdotool type --window $current_wid --clearmodifiers "$kaomoji"
