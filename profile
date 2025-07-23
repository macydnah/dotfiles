# ~./profile
#

if [ -n "$BASH_VERSION" ]; then
	[[ -f "${HOME}/.bashrc" ]] && . "${HOME}/.bashrc"
fi

# Exportar variables
export allext="/run/media/$(whoami)/*"
export ALSOFT_DRIVERS="pulse"
export AUR="${HOME}/.local/opt/AUR"
#export EDITOR="vim"
#export MANPAGER="bat -l man -p"
#export MANPAGER="sh -c 'col -bx | bat -l man -p'"
#export MANROFFOPT="-c"
#export MOZ_USE_XINPUT2=1
export OO_PS4_TOOLCHAIN="/home/macydnah/Downloads/v0.5"
export OPT="${HOME}/.local/opt"
export PATH="${PATH}:/home/macydnah/.local/bin:/home/macydnah/Downloads/v0.5/bin"

# Turn off kbd_backlight if it's daytime or let them on if nighttime
# if [[ 10#$(date +%H) -gt 10#07 && 10#$(date +%H) -lt 18 ]] ;
# 	then kblight -f ; kblight -f ;
# 	else kblight -f ; kblight -a ;
# fi

# Autostart X or Wayland at login
# [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx -- &>/dev/null
# [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startsway -- &>/dev/null

# TMUX
if [ -z "$TMUX" ] && [ -n "$SSH_TTY" ]; then
	declare -r SESSION_NAME="Shession"

	tmux has-session -t $SESSION_NAME 2>/dev/null
	if [ $? != 0 ]; then
		tmux new-session -d -s $SESSION_NAME
		tmux split-window -h -t $SESSION_NAME
		tmux split-window -v -t $SESSION_NAME:1.2
	fi

    exec tmux attach-session -t $SESSION_NAME:1.1
fi
# Autostart tmux at login
# if [[ ! $DISPLAY && $XDG_VTNR -eq 2 ]]\
# && [[ "$TERM" != "screen" ]]\
# && [[ "$SSH_CONNECTION" == "" ]] ; then
#    WHOAMI=$(whoami)
#    if tmux has-session -t $WHOAMI 2>/dev/null ; then
# 	tmux -2 attach-session -t $WHOAMI
#    else
# 	tmux -2 new-session -s $WHOAMI
#    fi
# fi
