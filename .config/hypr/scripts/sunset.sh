#!/bin/bash
CMD=$1
DELTA=$2
TOGGLE=$3
if [ -z "$CMD" ]; then
  echo "Set or get gamma and color temperature through hyprsunset IPC socket"
  echo "Usage: sunset.sh <gamma/temperature> [+-][value] [toggle]"
  exit 1
fi
if [[ ! -z "$TOGGLE" ]]; then
  CUR=$(hyprctl hyprsunset $CMD)
  FMT=$(LC_NUMERIC="en_US.UTF-8" printf "%.0f" $CUR 2>/dev/null)
  if [ "$FMT" = "$DELTA" ]; then
    if [ "$CMD" = "gamma" ]; then
      DELTA=100
    else
      DELTA=6500
    fi
  fi
fi
[ "$CMD" = "gamma" ] && LEN=3 || LEN=4
if [[ ! -z "$DELTA" ]]; then
  # rate limit and queue commands to workaround nvidia freezing on ctm spam
  flock /tmp/sunset.lock sleep 0.1
  # tell waybar to update after a change
  pkill -SIGRTMIN+$LEN waybar
fi
if NUM=$(hyprctl hyprsunset $CMD $DELTA); then
  if FMT=$(LC_NUMERIC="en_US.UTF-8" printf "%$LEN.0f" $NUM 2>/dev/null); then
    echo "$FMT"
  fi
fi
