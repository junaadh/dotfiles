#!/usr/bin/env bash

# Terminate already running bar instances
pkill polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar
polybar left -c ~/.config/polybar/config &
polybar middle -c ~/.config/polybar/config &
polybar right -c ~/.config/polybar/config 
