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
dotter deploy --dry-run -p hyprland         # Validate single package
```

### Dotter Packages (in .dotter/global.toml)

- `shell` - bashrc, fish, tmux, vim, fzfrc, profile
- `neovim` - Neovim configuration
- `hyprland` / `sway` - Wayland compositors
- `i3` / `qtile` / `openbox` - X11 WMs (depend on `X11` package)
- `terminal` - alacritty, foot
- `yazi`, `mpv`, `mpd` - File manager, multimedia

## Code Style Guidelines

### Bash

```bash
# Indentation: Tabs | Quotes: double for vars, single for literals
declare -r BOLD='\[\e[1m\]'  # Constants: UPPER_SNAKE_CASE

my_function() {
    local var="value"        # Locals: lower_snake_case
    if [[ -f "$file" ]]; then
        # Use [[ ]] for tests
    fi
}
# vim: ft=sh foldmethod=marker
```

### Fish

```fish
# Indentation: Tabs | Use abbr (not alias)
abbr --add vim -- nvim

function my_func --description 'Description'
    set local_var "value"
end
```

### Lua (Neovim)

```lua
-- ~/.config/nvim/filename.lua
-- Indentation: 2 spaces | Quotes: single | No semicolons

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set

local __group_name = augroup('GroupName', { clear = true })  -- Private: __prefix

autocmd('Event', {
  desc = 'Description',
  group = __group_name,
  callback = function() end
})

---Brief description.
---@param name type Description
---@return type
local function my_func(name)
  return name
end
```

### Config Files

- **TOML**: Use `$schema` when available; snake_case keys
- **JSONC**: Double quotes; snake_case keys; include `$schema`
- **Hyprland/Sway/i3**: Tabs; `$var` declarations at top; doc URLs in comments
- **CSS** (waybar): 4-space indent; colors via `@define-color`

## Naming Conventions

| Type             | Convention       | Examples                        |
|------------------|------------------|---------------------------------|
| Shell constants  | UPPER_SNAKE_CASE | `$EDITOR`, `$TERMINAL`          |
| Shell locals     | lower_snake_case | `last_status`, `prompt_host`    |
| Lua locals       | camelCase        | `augroup`, `bufmap`             |
| Lua private      | __camelCase      | `__group_lsp_features`          |
| Config keys      | snake_case       | `small_model`, `sort_by`        |
| Files            | lowercase/kebab  | `config.fish`, `fzf-lua.lua`    |

## Error Handling

- **Shell**: Check exit codes; use `set -e` in scripts; guard with `[[ ]]`
- **Lua**: Use `pcall`/`xpcall` for risky operations; validate preconditions
- **Scripts**: Print errors to stderr; exit non-zero on failure

## Comments

- Shell: `#` prefix (Spanish or English OK)
- Lua: `--` single line, `--[[ ]]` blocks
- Include doc URLs for non-obvious settings
- Use vim modelines at file end when needed

## Hardware-Specific Configuration

- Machine-specific settings go in `.dotter/local.toml` (gitignored)
- In Hyprland: isolate monitor/device/GPU configs; don't commit host-specific values
- The `[all]` package deploys everything (use with caution)

## Environment

- Compositor: Hyprland (Wayland) / Sway / i3 (X11)
- Terminal: foot (Wayland), alacritty (X11)
- Editor: Neovim
- Shell: Fish (interactive), Bash (scripts)
- Package manager: pacman/AUR (Arch Linux)

## Subdirectory Documentation

- `config/opencode/AGENTS.md` - OpenCode plugin development guidelines
