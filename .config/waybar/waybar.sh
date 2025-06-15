#!/usr/bin/env sh

# Terminate already running bar instances
killall -q waybar

# Wait until the processes have been shut down
while pgrep -x waybar >/dev/null; do sleep 1; done

# Launch main
if [ "${XDG_CURRENT_DESKTOP}" = "Hyprland" ]; then
    waybar -c ~/.config/waybar/config-hyprland >/dev/null 2>&1 &
elif [ "${XDG_CURRENT_DESKTOP}" = "Niri" ]; then
    waybar -c ~/.config/waybar/config-niri >/dev/null 2>&1 &
else
    waybar >/dev/null 2>&1 &
fi
