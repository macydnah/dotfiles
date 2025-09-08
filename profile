# ~/.profile

if [ -d "$HOME/.local/bin" ]; then
    PATH="$PATH:$HOME/.local/bin"
fi

# Perfil
export AUR="$HOME/.local/opt/AUR"
export EDITOR="vim"
export MANPAGER="sh -c 'col -bx | bat --plain --language=man'"
export MANROFFOPT="-c"
export OPT="$HOME/.local/opt"

# Misc
export allext="/run/media/$USER/*"

# OpenOrbis Toolchain
export OO_PS4_TOOLCHAIN="/home/macydnah/Downloads/v0.5"
export PATH="$PATH:/home/macydnah/Downloads/v0.5/bin"

# PulseAudio
export ALSOFT_DRIVERS="pulse"

# FZF fuzzy finder
# https://github.com/junegunn/fzf?tab=readme-ov-file#environment-variables
export FZF_DEFAULT_COMMAND='fd --no-hidden --no-follow --type file'
export FZF_DEFAULT_OPTS_FILE="$HOME/.fzfrc"
export FZF_CTRL_T_COMMAND='fd --hidden --follow --type file --type dir --type symlink --exclude .git .'
export FZF_CTRL_T_OPTS="--preview=''"
export FZF_CTRL_R_OPTS="--ghost='Search for previous command...' --preview=''"
export FZF_ALT_C_COMMAND='fd --hidden --no-follow --type dir --type symlink --exclude .git .'
export FZF_ALT_C_OPTS="--ghost='Search for directory...' --preview='tree -C --dirsfirst --sort name --hyperlink {}'"
# https://github.com/junegunn/fzf#customizing-fzf-options-for-completion
export FZF_COMPLETION_TRIGGER='**'
# export FZF_COMPLETION_OPTS="--preview='bat --plain --color=always {}'"
# export FZF_COMPLETION_PATH_OPTS="--ghost='Search for...' --preview='bat --plain --color=always {}'"
# export FZF_COMPLETION_DIR_OPTS="--ghost='Search for directory...' --preview='tree -C --dirsfirst --sort name --hyperlink {}'"

# TMUX
_tmux_auto_session() {
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
	case "$1" in
		--exec)
			exec tmux attach-session -t $TARGET
			;;
		*)
			tmux attach-session -t $TARGET
			;;
	esac
}
_tmux_auto_session_mini() {
	declare -r SESSION_NAME='VTSession'

	tmux has-session -t $SESSION_NAME 2>/dev/null
	if [ $? != 0 ]; then
		# create a simple session with two panes
		tmux new-session -d -s $SESSION_NAME
		tmux split-window -h -t $SESSION_NAME:1
	fi

	declare -r TARGET=$SESSION_NAME:1.1
	case "$1" in
		--exec)
			exec tmux attach-session -t $TARGET
			;;
		*)
			tmux attach-session -t $TARGET
			;;
	esac
}
# auto start tmux at ssh login
if [ -z "$TMUX" ] && [ -n "$SSH_TTY" ]; then
	# _tmux_auto_session
	_tmux_auto_session --exec
fi
# auto start tmux at local login in tty6
if [ -z "$TMUX" ] && [ "$XDG_VTNR" -eq 6 ] && [ "$SSH_CONNECTION" == "" ] && [ -z "$DISPLAY" ]
then
	# _tmux_auto_session_mini
	_tmux_auto_session_mini --exec
fi

# Source ~/.bashrc at the end
if [ -n "$BASH_VERSION" ]; then
	export HISTCONTROL=ignorespace
	export HISTFILE="${HOME}/.bash_history"
	export HISTFILESIZE=-1
	export HISTSIZE=-1

	[[ -f "${HOME}/.bashrc" ]] && . "${HOME}/.bashrc"
fi

# Auto exec graphics (X, Wayland) at login
# [ ! "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ] && exec startx -- >/dev/null 2>&1
# [ ! "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ] && exec startsway -- >/dev/null 2>&1
# [ ! "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ] && exec hyrland -- >/dev/null 2>&1

# vim: ft=sh foldmethod=marker
