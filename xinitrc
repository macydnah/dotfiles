#!/bin/sh
#
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

[ -f $sysresources ] && xrdb -merge $sysresources
[ -f $sysmodmap ] && xmodmap $sysmodmap
[ -f "$userresources" ] && xrdb -merge "$userresources"
[ -f "$usermodmap" ] && xmodmap "$usermodmap"

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
	[ -x "$f" ] && . "$f"
    done
    unset f
fi

export TERMINAL="st"
export BROWSER="firefox"
feh --no-fehbg --bg-fill /usr/share/backgrounds/fgm.png &
#feh --no-fehbg --bg-fill --geometry +0+20 /usr/share/backgrounds/empate.jpg &
pcmanfm -d &
unclutter --ignore-buttons 4,5,6,7 --timeout 2 --jitter 10 --start-hidden -b &
/usr/lib/xfce-polkit/xfce-polkit &
#[[ $(acpi -a | grep on) ]] && picom -b &
#exec st -g 120x36+200+75
#exec uxterm -g 80x24+360+150
#exec "/home/macydnah/.local/opt/dwm/dwm"
#exec openbox-session
exec i3
