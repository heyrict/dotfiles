#!/bin/sh

battery=$(acpi -bi | grep 4209 | cut -d' ' -f2)
acpi -b | grep "$battery" | awk -F'[,:%]' '{print $3, $2}' | {
    read -r capacity status

    if [ "$status" = Discharging -a "$capacity" -lt 10 ]; then
        logger "Critical battery threshold: $capacity"
        systemctl poweroff
    elif [ "$status" = Discharging -a "$capacity" -lt 15 ]; then
        logger "Low battery threshold: $capacity"
        systemctl suspend
    fi
}
