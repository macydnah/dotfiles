# ~./profile
#

if [ -n "$BASH_VERSION" ]; then
	[[ -f "${HOME}/.bashrc" ]] && . "${HOME}/.bashrc"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$PATH:$HOME/.local/bin"
fi

# Exportar variables
export allext="/run/media/$USER/*"
export ALSOFT_DRIVERS="pulse"
export AUR="$HOME/.local/opt/AUR"
#export EDITOR="vim"
#export MANPAGER="bat -l man -p"
#export MANPAGER="sh -c 'col -bx | bat -l man -p'"
#export MANROFFOPT="-c"
#export MOZ_USE_XINPUT2=1
export OO_PS4_TOOLCHAIN="/home/macydnah/Downloads/v0.5"
export PATH="$PATH:/home/macydnah/Downloads/v0.5/bin"
export OPT="$HOME/.local/opt"

# Turn off kbd_backlight if it's daytime or let them on if nighttime
# if [[ 10#$(date +%H) -gt 10#07 && 10#$(date +%H) -lt 18 ]] ;
# 	then kblight -f ; kblight -f ;
# 	else kblight -f ; kblight -a ;
# fi

# Auto exec graphics (X, Wayland) at login
# [ ! "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ] && exec startx -- >/dev/null 2>&1
# [ ! "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ] && exec startsway -- >/dev/null 2>&1

# TMUX
# auto exec tmux at ssh login
if [ -z "$TMUX" ] && [ -n "$SSH_TTY" ]; then
	declare -r SESSION_NAME='Shession'
	declare -r INITIAL_PANE_CMD='yazi'
	declare -r INITIAL_PANE_CMD_ARGS=''
	declare TARGET_PANE_FOCUS='top'

	tmux has-session -t $SESSION_NAME 2>/dev/null
	if [ $? != 0 ]; then
		if command -v $INITIAL_PANE_CMD >/dev/null 2>&1
		then
			if [ $INITIAL_PANE_CMD_ARGS ]; then
				tmux new-session -d -s $SESSION_NAME "$INITIAL_PANE_CMD $INITIAL_PANE_CMD_ARGS"
			else
				tmux new-session -d -s $SESSION_NAME "$INITIAL_PANE_CMD"
			fi
			tmux split-window -v -t $SESSION_NAME:1
			# warning: focusing the 'bottom' pane makes `yazi` and maybe other
			# programs to flood escape sequences to the host terminal
			# TARGET_PANE_FOCUS='bottom'
		else
			# a simple session with two panes
			tmux new-session -d -s $SESSION_NAME
			tmux split-window -h -t $SESSION_NAME:1
			TARGET_PANE_FOCUS='left'
		fi
	fi

	case $TARGET_PANE_FOCUS in
		top|left)
			declare -r WIN_ID=1
			declare -r PANE_ID=1
			;;
		bottom|right)
			declare -r WIN_ID=1
			declare -r PANE_ID=2
			;;
		*)
			declare -r WIN_ID=1
			declare -r PANE_ID=1
			;;
	esac

	declare -r TARGET=$SESSION_NAME:$WIN_ID.$PANE_ID
    tmux attach-session -t $TARGET
	# exec tmux attach-session -t $TARGET
fi
# auto start tmux at local login in tty2
if [ -z "$TMUX" ] && [ "$XDG_VTNR" -eq 2 ] && [ "$SSH_CONNECTION" == "" ] && [ -z "$DISPLAY" ]
then
	declare -r SESSION_NAME='VTSession'

	tmux has-session -t $SESSION_NAME 2>/dev/null
	if [ $? != 0 ]; then
		# create a simple session with two panes
		tmux new-session -d -s $SESSION_NAME
		tmux split-window -h -t $SESSION_NAME:1
	fi

	declare -r TARGET=$SESSION_NAME:1.1
	tmux attach-session -t $TARGET
	# exec tmux attach-session -t $TARGET
fi
