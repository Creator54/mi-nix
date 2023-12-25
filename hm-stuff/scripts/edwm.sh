#!/usr/bin/env bash

dwm_dir=~/dwm
kittyConfig=(
	"layout tall:bias=70"
	""
	"# first kitty window"
	"launch --title \"Source\" vim config.def.h"
	""
	"# second kitty window"
	"launch --title \"Compilation Output\" bash -c \"ls config.def.h | entr nix-shell --run 'make clean;make'\""
)

if [[ -d "$dwm_dir" ]]; then
	cd "$dwm_dir" || exit

	configFile=$(mktemp)

	printf "%s\n" "${kittyConfig[@]}" >"$configFile"

	kitty --session "$configFile"
else
	echo "Local Dwm not found at $dwm_dir"
fi
