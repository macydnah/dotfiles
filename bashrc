# ~/.bashrc

[[ $- != *i* ]] && return

if [[ -f /tmp/hist ]]; then
	HISTFILE=/tmp/hist
fi

# https://misc.flogisoft.com/bash/tip_colors_and_formatting
declare -r BOLD='\[\e[1m\]'
declare -r RESET='\[\e[0;00m\]'
declare -r BLACK='\[\e[30m\]'
declare -r RED='\[\e[31m\]'
declare -r GREEN='\[\e[32m\]'
declare -r YELLOW='\[\e[33m\]'
declare -r BLUE='\[\e[34m\]'
declare -r MAGENTA='\[\e[35m\]'
declare -r CYAN='\[\e[36m\]'
PS1="${BOLD}${BLUE}\W ${YELLOW}\$${RESET} "
if [[ "${UID}" -eq 0 ]]; then
	PS1="${BOLD}${GREEN}[${RED}\u${BLUE}@${GREEN}\H ${BLUE}\w${GREEN}]${RESET}${RED}#${RESET} "
fi
if [[ "${SSH_CONNECTION}" ]]; then
	PS1="${BOLD}${GREEN}[${YELLOW}\u${BLUE}@${GREEN}\H ${BLUE}\W${GREEN}]${RESET}${YELLOW}\$${RESET} "
fi
if [[ -n "${YAZI_LEVEL}" ]]; then
	declare -r YAZI_PS1="${BOLD}${BLUE}| 🗃️ L${YAZI_LEVEL} |${RESET} "
	PS1="${YAZI_PS1}${PS1}"
fi

# Alianzas
alias bat="bat --plain"
alias cls="clear"
alias confhyp="${EDITOR} ~/.config/hypr/hyprland.conf"
alias diff="diff --color"
alias feh="feh --conversion-timeout=0"
alias grep="grep --color"
alias ip="ip -c=auto"
alias less="/usr/share/vim/vim91/macros/less.sh"
alias ls="ls --color=auto"
alias lsa="ls --color=auto -A"
alias lsl="ls --color=auto -lAGhs"
alias pactree="pactree -c"
alias rmi="rm -I"
alias scrcpy="scrcpy --stay-awake --turn-screen-off --shortcut-mod=lalt --window-borderless -m 1024 --power-off-on-close"
alias sudo="sudo -v; sudo "
alias top="top -u ${USER}"
alias tree="tree -C --dirsfirst --du -h --hyperlink"
alias wablk="watch -ctn1 'echo ; lsblk'"
alias wared="watch -ctn1 'nmcli -c yes | head -n20'"
alias watch="watch -cn0.5"
alias whois="whois -H"
alias zgrep="zgrep --color"

# Funciones
aur() {
	case "${1}" in
		clone)
			cd $(auracle --chdir="${AUR}" "${@}" | awk $'{print $3}');
			printf "Directory changed to:\n$(pwd)\n\nDownloaded files:\n$(ls)";
			;;
		url)
			auracle info "${2}" | grep -o "ht.*pack.*" | sed s"#packages/##" | xsel -ib --trim && echo $(xsel -ob);
			;;
		*)	auracle "${@}"
			;;
	esac
}

dianoche() {
	declare -r SETTINGS="${HOME}/.config/gtk-3.0/settings.ini"
	[[ "$(grep gtk-theme-name "${SETTINGS}" | cut -d'=' -f2)"  =~ dark$ ]] && sed '/gtk-theme-name/s/-dark$//' -i "${SETTINGS}" || sed '/gtk-theme-name/s/$/-dark/' -i "${SETTINGS}" ; import-gsettings
}

firefoxd() {
	if ! pgrep -x firefox; then
		firefox --new-window about:blank &
		foot  --title 'firefoxd' --app-id 'firefoxd' &
	fi
	hyprctl dispatch togglespecialworkspace firefoxd
}

i3mpv() { i3-swallow mpv "${@}"; }

loremipsum() {
	wl-copy -n << "_no_mas_lorem"
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
_no_mas_lorem
}

mpa() {
	case "${1}" in
		-r)	mpv --ytdl-format='bestaudio' --video=no "${@:2}"
			;;
		*)	mpv --no-resume-playback --ytdl-format='bestaudio' --video=no "${@}"
			;;
	esac
}

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

open() { [[ -z "${1}" ]] && xdg-open . || xdg-open "${1}"; }

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
		echo;
		command pactl list | grep 'Active Profile' | sed s'/^\t//';
		echo;
		command pactl list | grep Profiles\: | tr -d '\t';
		command pactl list | grep Profiles\: -A10 | grep -v Profiles\: | awk $'{print $1}' | sed s'/:$//';
		echo;
	else
		command pactl "${@}";
	fi
}

tetemporizador() { (sleep "${1:-5m}" && notify-send -i '/usr/share/icons/breeze/apps/48/kteatime.svg' 'Yastá' 'listo el té') & }

trafego() {
	declare -r ENP0S=$(ip l | grep -o enp0s20u.)
	[[ -n $ENP0S ]] && nload -u H -m $ENP0S -m wlp1s0 || nload -u H -m wlp1s0 ;
}

webdarkmodejs() {
	# Paste in a browser console to darkmod any website
	# Javascript by Jochem Stoel https://dev.to/jochemstoel/re-add-dark-mode-to-any-website-with-just-a-few-lines-of-code-phl
	wl-copy -n << "_no_mas_javascript"
function toggle() {
    let q = document.querySelectorAll('#nightify')
    if(q.length) {
        q[0].parentNode.removeChild(q[0])
        return false
    }
    var h = document.getElementsByTagName('head')[0],
        s = document.createElement('style');
    s.setAttribute('type', 'text/css');
    s.setAttribute('id', 'nightify');
    s.appendChild(document.createTextNode('html{-webkit-filter:invert(100%) hue-rotate(180deg) contrast(70%) !important; background: #fff;} .line-content {background-color: #fefefe;}'));
    h.appendChild(s);
    return true
}

toggle()
_no_mas_javascript
}

webdarkmodepdfjs() {
	# Paste in a browser console to darkmod Firefox's built-in pdf.js
	# Javascript by SynergerySid https://stackoverflow.com/a/61814602
	wl-copy -n << "_no_mas_javascript"
javascript:(function(){var el = typeof viewer !== 'undefined' ? viewer : document.body; el.style.filter = 'grayscale(1) invert(1) sepia(1) contrast(75%)';})()
_no_mas_javascript
}

ytda() { yt-dlp -f "bestaudio" -o "%(playlist_index)s - %(title)s.%(ext)s" --embed-metadata "${@}"; }

# FZF fuzzy finder
# https://github.com/junegunn/fzf?tab=readme-ov-file#setting-up-shell-integration
eval "$(fzf --bash)"
# https://github.com/junegunn/fzf#customizing-fzf-options-for-completion
_fzf_comprun() {
	local command=$1
	shift

	case "$command" in
		cd)
			fzf --ghost='Search for directory...' --preview='tree -C --dirsfirst --sort name --hyperlink {}' "$@"
			;;
		export|unset)
			fzf --ghost='Search for variable...' --preview="eval 'echo \$'{}" "$@"
			;;
		ssh)
			fzf --ghost='Search for host to connect...' --preview='' "$@"
			;;
		*)
			fzf --preview='bat --plain --color=always {}' "$@"
			;;
	esac
}
# https://github.com/junegunn/fzf#customizing-completion-source-for-paths-and-directories
# Use fd for listing path candidates.
_fzf_compgen_path() {
	fd --hidden --follow --type file --type dir --type symlink --exclude ".git" . "${1}"
}
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
	fd --hidden --follow --type dir --type symlink --exclude ".git" . "${1}"
}

# Turn off kbd_backlight if it's daytime or let them on if nighttime
# if [[ 10#$(date +%H) -gt 10#07 && 10#$(date +%H) -lt 18 ]]; then
# 	kblight -f ; kblight -f ;
# else
# 	kblight -f ; kblight -a ;
# fi

# vim: ft=sh foldmethod=marker
