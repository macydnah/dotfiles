#!/usr/bin/env bash

case "$1" in
    dark)
        SHADER="$HOME/.config/hypr/blue-light-filter.frag"
        ;;
    light)
        SHADER=""
        ;;
    *)
        exit 1
        ;;
esac

hyprctl eval "hl.config({ decoration = { screen_shader = \"$SHADER\" } })"
