#!/bin/sh

polybar-msg cmd quit || true

echo "---" | tee -a /tmp/polybar1.log
pkill polybar
polybar example --config=~/.config/polybar/config.ini 2>&1 | tee -a /tmp/polybar1.log & disown

echo "Bars launched..."
