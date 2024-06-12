#!/bin/bash

if xprop -name "Polybar tray window" >/dev/null 2>&1 ; then estado=on ; else estado=off ; fi

if [[ $1 == "-q" ]] ; then estado=on ; fi


case $estado in

    "on")
	kill $(xprop -name "Polybar tray window" _NET_WM_PID 2>>/tmp/polybar2.log | grep -o '[[:digit:]]*') >/dev/null 2>&1
	;;

   "off")
	echo "---" | tee -a /tmp/polybar2.log ;
	polybar --config=/home/macydnah/.config/polybar/tray/config tray >>/tmp/polybar2.log 2>&1
	;;
esac
