# AGENTS.md - Dotfiles Repository

Personal dotfiles managed with [Dotter](https://github.com/SuperCuber/dotter).
Contains shell, editor, WM, and tool configurations for Arch Linux.

## Project Structure

```
.dotfiles/
├── .dotter/            # Dotter config (global.toml = packages, local.toml = machine-specific)
├── bashrc, profile     # Shell entrypoints
├── fzfrc, xinitrc      # FZF config, X11 init
├── Xresources          # X11 resources
├── cargo/              # Rust/Cargo config
└── config/             # XDG_CONFIG_HOME
    ├── fish/           # Fish shell
    ├── nvim/           # Neovim (Lua)
    ├── hypr/           # Hyprland compositor
    ├── sway/, i3/      # Sway/i3 WMs
    ├── waybar/, rofi/  # Status bar, launcher
    ├── foot/, tmux/    # Terminal, multiplexer
    ├── yazi/, mpv/     # File manager, media player
    └── opencode/       # OpenCode AI (has own AGENTS.md)
```

## Build/Lint/Test Commands

No compilation or test suite. Deployment via Dotter; validation per-file.

### Dotter Operations

```bash
dotter deploy                    # Deploy packages from local.toml
dotter deploy -p shell -p neovim # Deploy specific packages
dotter deploy --dry-run          # Preview changes
dotter undeploy                  # Remove symlinks
dotter deploy --force            # Overwrite existing files
```

### Single-File Validation

```bash
bash -n bashrc                              # Syntax-check Bash
fish --no-execute config/fish/config.fish   # Syntax-check Fish
shellcheck config/waybar/scripts/*.sh       # Lint shell scripts
luac -p config/nvim/init.lua                # Syntax-check Lua
hyprctl reload                              # Validate/reload Hyprland config
dotter deploy --dry-run -p hyprland         # Validate single package
```

### Dotter Packages (in .dotter/global.toml)

- `shell` - bashrc, fish, tmux, vim, fzfrc, profile
- `neovim` - Neovim configuration
- `hyprland` / `sway` - Wayland compositors
- `i3` / `qtile` / `openbox` - X11 WMs (depend on `X11` package)
- `terminal` - alacritty, foot
- `WUtils` - darkman, rofi, waybar, swayimg
- `yazi`, `mpv`, `mpd` - File manager, multimedia
- `opencode` - OpenCode AI assistant
- `all` - Everything (use with caution)

## Code Style Guidelines

### Bash
- **Indentation:** Tabs
- **Quotes:** Double for vars, single for literals
- **Constants:** UPPER_SNAKE_CASE (`declare -r`)
- **Locals:** lower_snake_case
- **Tests:** Use `[[ ]]`
- **Modeline:** `# vim: ft=sh foldmethod=marker`

### Fish
- **Indentation:** Tabs
- **Abbreviations:** Use `abbr` (not `alias`)
- **Functions:** `function name --description 'desc'`

### Lua (Neovim)
- **Indentation:** 2 spaces
- **Quotes:** Single
- **Semicolons:** None
- **Private vars:** `__` prefix (`__group_name`)
- **Annotations:** Use `---@param`, `---@return`

### Hyprland
- **Indentation:** Tabs
- **Variables:** `$prefix` at top of file
- **Windowrule names:** kebab-case (`volume-control`, `firefox-file-upload`)
- **Modeline:** `# vim: ft=hyprlang`

### Config Files
- **TOML/JSONC:** snake_case keys; include `$schema` when available
- **CSS (waybar):** 4-space indent; colors via `@define-color`

## Naming Conventions

| Type              | Convention       | Examples                         |
|-------------------|------------------|----------------------------------|
| Shell constants   | UPPER_SNAKE_CASE | `$EDITOR`, `$TERMINAL`           |
| Shell locals      | lower_snake_case | `last_status`, `prompt_host`     |
| Lua locals        | camelCase        | `augroup`, `bufmap`              |
| Lua private       | __camelCase      | `__group_lsp_features`           |
| Config keys       | snake_case       | `small_model`, `sort_by`         |
| Files             | lowercase/kebab  | `config.fish`, `fzf-lua.lua`     |
| Hyprland rules    | kebab-case       | `volume-control`, `netbeans-*`   |

## Commit Message Convention

Use [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]
```

**Types:** `feat`, `fix`, `refactor`, `docs`, `chore`, `style`
**Scopes:** `hyprland`, `neovim`, `shell`, `fish`, `waybar`, `opencode`, etc.

Examples:
```
feat(hyprland): add battery-friendly config module
refactor(neovim): reorganize LSP configuration
fix(waybar): correct memory calculation script
docs(changelog): add changelog
```

## Error Handling

- **Shell**: Check exit codes; use `set -e` in scripts; guard with `[[ ]]`
- **Lua**: Use `pcall`/`xpcall` for risky operations; validate preconditions
- **Scripts**: Print errors to stderr; exit non-zero on failure

## Hardware-Specific Configuration

**CRITICAL:** Machine-specific settings go in `.dotter/local.toml` (gitignored).

In Hyprland, these are typically hardware-specific (do NOT commit):
- `monitorv2 { }` blocks with specific outputs (eDP-1, HDMI-A-2)
- `device { }` blocks for specific input devices
- GPU-specific environment variables (LIBVA_DRIVER_NAME)
- `cursor { default_monitor }` settings

When committing, ensure working directory changes for hardware configs remain unstaged.

## Comments

- Shell: `#` prefix (Spanish or English OK)
- Lua: `--` single line, `--[[ ]]` blocks
- Include doc URLs for non-obvious settings (wiki.hyprland.org, etc.)
- Use vim modelines at file end when needed

## Environment

- **OS**: Arch Linux
- **Compositor**: Hyprland (Wayland) / Sway / i3 (X11)
- **Terminal**: foot (Wayland), alacritty (X11)
- **Editor**: Neovim
- **Shell**: Fish (interactive), Bash (scripts)
- **Package manager**: pacman/AUR

## Subdirectory Documentation

- `config/opencode/AGENTS.md` - OpenCode plugin development guidelines
