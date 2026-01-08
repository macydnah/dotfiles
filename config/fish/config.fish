if status is-interactive
    # Commands to run in interactive sessions can go here

    # Abreviaciones
    abbr --add aur                 -- auracle
    abbr --add bat                 -- 'bat -p'
    abbr --add batdif              -- 'bat -p -l diff'
    abbr --add cls                 -- clear
    abbr --add confhyp             -- '$EDITOR ~/.config/hypr/hyprland.conf'
    abbr --add feh                 -- 'feh --conversion-timeout=0'
    abbr --command git fza         -- "ls-files -m -o --exclude-standard | fzf -m --list-label=' Add files to stage ' --ghost='Search for files...' --print0 | xargs -0 -o -t git add"
    abbr --command git fzap        -- "ls-files -m -o --exclude-standard | fzf -m --list-label=' Add files to stage ' --ghost='Search for files...' --print0 | xargs -0 -o -t git add -p"
    abbr --command git fzl         -- "log --oneline | fzf --accept-nth=1 --tiebreak=index --multi --list-label=' Commits ' --ghost='Search for commits...' --preview='git show --color=always {+1} | bat --plain --color=always -l gitlog' | wl-copy -n"
    abbr --command git log1        -- "log -1 (wl-paste -n) | bat -p -lgitlog"
    abbr --add math --set-cursor=! -- "math '!'"
    # abbr --add mpa                 -- "mpv --no-resume-playback --ytdl-format='bestaudio' --video=no"
    abbr --add mpv --set-cursor=!  -- "mpv '!'"
    abbr --add vim                 -- nvim
    abbr --add wablk               -- "watch -ctn1 'echo ; lsblk'"
    abbr --add wared               -- "watch -ctn1 'nmcli -c yes | head -n20'"
    abbr --add watch               -- "watch -cn0.5"
    abbr --add whois               -- "whois -H"
    # abbr --add yt --set-cursor=!   -- "yt-dlp '!'"

    abbr -a --set-cursor=__CURSOR__ --command mvn simple 'archetype:generate \
        -DinteractiveMode=true \
        -DarchetypeGroupId=org.example.archetypes \
        -DarchetypeArtifactId=simple-archetype \
        -DarchetypeVersion=1.0-SNAPSHOT \
        -DartifactId=__CURSOR__
        '

    abbr -a --set-cursor=__CURSOR__ --command mvn simple-json 'archetype:generate \
        -DinteractiveMode=true \
        -DarchetypeGroupId=org.example.archetypes \
        -DarchetypeArtifactId=simple-json-archetype \
        -DarchetypeVersion=1.0-SNAPSHOT \
        -DartifactId=__CURSOR__
        '

    abbr --add mpa --function _mpa_abbr --regex "mpa"
    function _mpa_abbr --description 'Abbreviation for mpa... to mpv ...'
	set cmd "mpv --no-resume-playback --ytdl-format='bestaudio' --video=no"
	set url (wl-paste -n)
	if string match --quiet --regex '^https\:\/\/you(tube\.com)?(tu\.be)?\/.*$' $url
		set audio_title_channel (yt-dlp --print filename -o "%(title)s — %(channel)s" $url 2>/dev/null)
		echo $cmd \'$url\' '#' $audio_title_channel
		return
	end
	echo $cmd
    end

    abbr --add mpy --function _mpy_abbr --regex "mpy"
    function _mpy_abbr --description 'Abbreviation for mpy... to mpv ...'
	# set cmd (string replace -r '^mpy$' 'mpv' $argv[1])
	set cmd 'mpv'
	set url (wl-paste -n)
	# if string match --quiet --regex '^https\:\/\/you(tube\.com)?(tu\.be)?\/.*$' $url
	if string match --quiet --regex '^https\:\/\/(www\.)?you(tube\.com)?(tu\.be)?\/.*$' $url
		set video_title_channel (yt-dlp --print filename -o "%(title)s — %(channel)s" $url 2>/dev/null)
		echo $cmd \'$url\' '#' $video_title_channel
		return
	end
	echo $cmd
    end

    abbr --add yt --function _yt_abbr --regex "yt"
    function _yt_abbr --description 'Abbreviation for yt... to yt-dlp ...'
	# set cmd (string replace -r '^yt$' 'yt-dlp' $argv[1])
	set cmd 'yt-dlp'
	set url (wl-paste -n)
	# if string match --quiet --regex '^https\:\/\/you(tube\.com)?(tu\.be)?\/.*$' $url
	if string match --quiet --regex '^https\:\/\/(www\.)?you(tube\.com)?(tu\.be)?\/.*$' $url
		echo $cmd \'$url\' '#'
		return
	end
	echo $cmd
    end

    # FZF fuzzy finder
    # https://github.com/junegunn/fzf?tab=readme-ov-file#environment-variables
    # most of these are already set by `~/.profile`
    # set -gx FZF_DEFAULT_COMMAND   "fd --no-hidden --no-follow --type file"
    # set -gx FZF_DEFAULT_OPTS      "--preview-window='right,50%,nowrap,nofollow,nocycle,info,~1,<50(down,60%,border-top,nowrap,nofollow,nocycle,info,~1)'"
    # set -gx FZF_DEFAULT_OPTS_FILE "$HOME/.fzfrc"
    set -gx FZF_CTRL_T_COMMAND    "fd --hidden --follow --type file --type dir --type symlink --exclude .git . \$dir"
    # set -gx FZF_CTRL_T_OPTS       "--preview=''"
    # set -gx FZF_CTRL_R_OPTS       "--ghost='Search for previous command...' --preview=''"
    set -gx FZF_ALT_C_COMMAND     "fd --hidden --no-follow --type dir --type symlink --exclude .git . \$dir"
    # set -gx FZF_ALT_C_OPTS        "--ghost='Search for directory...' --preview='tree -C --dirsfirst --sort name --hyperlink {}'"

end
