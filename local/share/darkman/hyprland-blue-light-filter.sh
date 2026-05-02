#!/usr/bin/env bash

case "$1" in
	dark)
		PATH_TO_SHADER=~/.config/hypr/blue-light-filter.frag
		;;
	light)
		PATH_TO_SHADER=' '
		;;
	default)
		exit 1
		;;
esac

hyprctl keyword decoration:screen_shader "$PATH_TO_SHADER"
