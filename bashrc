# ~/.bashrc
#
[[ $- != *i* ]] && return
[[ -f /tmp/hist ]] && export HISTFILE=/tmp/hist

PS1='\[\e[1;32m\][\[\e[1;33m\]\u\[\e[1;34m\]@\[\e[1;32m\]\h \[\e[1;34m\]\W\[\e[1;32m\]]\[\e[0;33m\]§\[\e[0;00m\] '

# Alianzas
alias bat="bat -p"
alias cls="clear"
alias confhyp="vim ~/.config/hypr/hyprland.conf"
alias diff="diff --color"
alias feh="feh --conversion-timeout=0"
alias grep="grep --color"
alias ip="ip -c=auto"
alias less="/usr/share/vim/vim91/macros/less.sh"
alias ls="ls --color=auto"
alias lsa="ls --color=auto -A"
alias lsl="ls --color=auto -lAGhs"
alias pactree="pactree -c"
alias scrcpy="scrcpy --stay-awake --turn-screen-off --shortcut-mod=lalt --window-borderless -m 1024 --power-off-on-close"
alias sudo="sudo -v; sudo "
alias tmux="tmux new-session -A -s shession"
alias top="top -u $(whoami)"
alias tree="tree --dirsfirst --du -h"
alias tremc="tremc -c user:password@HuaaaliP0NKH-ER0S"
alias wablk="watch -ctn1 'echo ; lsblk'"
alias wared="watch -ctn1 'nmcli -c yes | head -n20'"
alias watch="watch -cn0.5"
alias whois="whois -H"
alias zgrep="zgrep --color"

# Funciones
aur() {
    case "${1}" in
	clone)	cd $(auracle --chdir="${AUR}" "${@}" | awk $'{print $3}'); printf "Directory changed to:\n$(pwd)\n\nDownloaded files:\n"; ls ;;
	url)	auracle info "${2}" | grep -o "ht.*pack.*" | sed s"#packages/##" | xsel -ib --trim && echo $(xsel -ob) ;;
	*)	auracle "${@}" ;;
    esac
}

i3mpv() { i3-swallow mpv "${@}"; }

mpa() { mpv --no-resume-playback --ytdl-format='bestaudio' "${@}"; }

mpf() { mpv --fs "${@}"; }

mpy() {
	declare -r OPT="${1}"
	declare -r URI="$(wl-paste -n)"
	if [[ "${URI}" =~ ^https\:\/\/you(tube\.com)?(tu\.be)?\/.* ]]; then
		case "${OPT}" in
			-f)	mpv --fs "${URI}"
				;;
			*)	mpv "${URI}"
				;;
		esac
	else
		>&2 printf "Error! Invalid URI in the clipboard:\n\n${URI}\n\n"
	fi
}

osc7_cwd() {
    local strlen=${#PWD}
    local encoded=""
    local pos c o
    for (( pos=0; pos<strlen; pos++ )); do
        c=${PWD:$pos:1}
        case "$c" in
            [-/:_.!\'\(\)~[:alnum:]] ) o="${c}" ;;
            * ) printf -v o '%%%02X' "'${c}" ;;
        esac
        encoded+="${o}"
    done
    printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
}
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }osc7_cwd

pactl() {
    if [[ $1 == "profiles" ]]; then
	echo; command pactl list | grep 'Active Profile' | sed s'/^\t//';
	echo; command pactl list | grep Profiles\: | tr -d '\t';
	command pactl list | grep Profiles\: -A10 | grep -v Profiles\: | awk $'{print $1}' | sed s'/:$//';
	echo;
    else
        command pactl "${@}";
    fi
}

tetemporizador() { (sleep "${1:-5m}" && notify-send -i '/usr/share/icons/breeze/apps/48/kteatime.svg' 'Yastá' 'listo el té') & }

trafego() { ENP0S=$(ip l | grep -o enp0s20u.); [[ -n $ENP0S ]] && nload -u H -m $ENP0S -m wlp1s0 || nload -u H -m wlp1s0; }

ytda() { yt-dlp -f "bestaudio" -o "%(playlist_index)s - %(title)s.%(ext)s" "${@}"; }
