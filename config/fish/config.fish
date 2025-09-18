if status is-interactive
    # Commands to run in interactive sessions can go here

    # Abreviaciones
    abbr --add aur          -- auracle
    abbr --add confhyp      -- '$EDITOR ~/.config/hypr/hyprland.conf'
    abbr --command git fza  -- "ls-files -m -o --exclude-standard | fzf -m --list-label=' Add files to stage ' --ghost='Search for files...' --print0 | xargs -0 -o -t git add"
    abbr --command git fzap -- "ls-files -m -o --exclude-standard | fzf -m --list-label=' Add files to stage ' --ghost='Search for files...' --print0 | xargs -0 -o -t git add -p"
    abbr --command git fzl  -- "log --oneline | fzf --accept-nth=1 --tiebreak=index --multi --list-label=' Commits ' --ghost='Search for commits...' --preview='git show --color=always {+1} | bat --plain --color=always -l gitlog' | wl-copy -n"
    abbr --command git log1 -- "log -1 (wl-paste -n) | bat -p -lgitlog"
    abbr --add vim          -- nvim

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
