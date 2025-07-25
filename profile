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
	declare -r DEFAULT_TARGET=$SESSION_NAME:1
	declare -r DEFAULT_TARGET_PANE_FOCUS='top'
	declare -r INITIAL_PROGRAM='yazi'
	declare -r INITIAL_PROGRAM_ARGS=''
	declare    TARGET=''
	declare    TARGET_PANE_FOCUS=''

	tmux has-session -t $SESSION_NAME 2>/dev/null
	if [ $? != 0 ]; then
		tmux new-session -d -s $SESSION_NAME

		TARGET=$DEFAULT_TARGET
		if command -v $INITIAL_PROGRAM >/dev/null 2>&1
		then
			# run a command in the initial pane
			if [ $INITIAL_PROGRAM_ARGS ]; then
				tmux respawn-pane -k -t $TARGET "$INITIAL_PROGRAM $INITIAL_PROGRAM_ARGS"
				# sleeping here to wait for INITIAL_PROGRAM execution seems to help
				sleep 1.25
			else
				tmux respawn-pane -k -t $TARGET "$INITIAL_PROGRAM"
				# sleeping here to wait for INITIAL_PROGRAM execution seems to help
				sleep 1.25
			fi
			# and a simple shell above
			tmux split-window -v -b -l '5%' -t $TARGET

			# warning: focusing any other pane than the one with an INITIAL_PROGRAM
			# makes `yazi` and maybe other programs to flood escape sequences
			# to the host terminal (see comment in line 56)
			TARGET_PANE_FOCUS='top'
		else
			# a simple session with two panes
			tmux split-window -h -l '33%' -t $TARGET
			TARGET_PANE_FOCUS='left'
		fi
	else
		# session already exists, use defaults
		TARGET=$DEFAULT_TARGET
		TARGET_PANE_FOCUS=$DEFAULT_TARGET_PANE_FOCUS
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

	TARGET=$SESSION_NAME:$WIN_ID.$PANE_ID
    tmux attach-session -t $TARGET
	# exec tmux attach-session -t $TARGET
fi
# auto start tmux at local login in tty2
# if [ -z "$TMUX" ] && [ "$XDG_VTNR" -eq 2 ] && [ "$SSH_CONNECTION" == "" ] && [ -z "$DISPLAY" ]
# then
# 	declare -r SESSION_NAME='VTSession'
#
# 	tmux has-session -t $SESSION_NAME 2>/dev/null
# 	if [ $? != 0 ]; then
# 		# create a simple session with two panes
# 		tmux new-session -d -s $SESSION_NAME
# 		tmux split-window -h -t $SESSION_NAME:1
# 	fi
#
# 	declare -r TARGET=$SESSION_NAME:1.1
# 	tmux attach-session -t $TARGET
# 	# exec tmux attach-session -t $TARGET
# fi
