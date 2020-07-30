#!/bin/bash
killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

BASE_DIR="$HOME/.config/polybar/"
PLUGINS=("marioortizmanero/polybar-pulseaudio-control" "Jvanrhijn/polybar-spotify")

for plugin in "${PLUGINS[@]}"
do
	IFS='/' read -ra psplit <<< "$plugin"
	if [ ! -d "$BASE_DIR${psplit[1]}" ]; then
		git clone https://github.com/$plugin.git "$BASE_DIR${psplit[1]}"
	fi
done

if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		MONITOR=$m polybar example &
	done
else
	polybar example &
fi
