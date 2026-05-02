#!/usr/bin/env bash

case "$1" in
	dark)
		THEME=Adwaita-dark
		;;
	light)
		THEME=Adwaita
		;;
	default)
		exit 1
		;;
esac

gsettings set org.gnome.desktop.interface gtk-theme "$THEME"
