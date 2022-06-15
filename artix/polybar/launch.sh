#!/bin/bash

# Terminate already running bar instances
pkill polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config
polybar top | tee -a /tmp/polybar.log & disown

echo "Polybar launched..."
