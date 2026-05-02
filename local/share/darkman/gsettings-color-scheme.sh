#!/usr/bin/env bash

case "$1" in
	dark)
		PREFERENCE=prefer-dark
		;;
	light)
		PREFERENCE=prefer-light
		;;
	default)
		exit 1
		;;
esac

gsettings set org.gnome.desktop.interface color-scheme "$PREFERENCE"
