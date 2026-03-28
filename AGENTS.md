# AGENTS.md - Dotfiles Repository

Personal dotfiles repository managed with [Dotter](https://github.com/SuperCuber/dotter).
Contains configuration files for shell, editors, window managers, and various tools.

## Project Structure

```
.dotfiles/
├── .dotter/                # Dotter deployment configuration
│   ├── global.toml         # Package definitions and file mappings
│   └── local.toml          # Machine-specific package selection (gitignored)
├── bashrc                  # Bash shell configuration
├── profile                 # Login shell profile
├── fzfrc                   # FZF fuzzy finder config
├── xinitrc                 # X11 initialization
├── Xresources              # X11 resources
├── cargo/                  # Rust/Cargo configuration
└── config/                 # XDG_CONFIG_HOME configurations
    ├── fish/               # Fish shell
    ├── nvim/               # Neovim (Lua-based config)
    ├── hypr/               # Hyprland compositor
    ├── sway/               # Sway compositor
    ├── i3/                 # i3 window manager
    ├── waybar/             # Waybar status bar
    ├── rofi/               # Rofi launcher
    ├── alacritty/          # Alacritty terminal
    ├── foot/               # Foot terminal
    ├── tmux/               # Tmux multiplexer
    ├── yazi/               # Yazi file manager
    ├── mpv/                # MPV video player
    ├── opencode/           # OpenCode AI assistant (has its own AGENTS.md)
    └── ...                 # Other tool configs
```

## Build/Lint/Test Commands

This is a dotfiles repository - no compilation or tests. Deployment is managed by Dotter.

```bash
# Deploy all packages defined in local.toml
dotter deploy

# Deploy specific packages only
dotter deploy -p shell -p neovim

# Dry run - show what would be deployed
dotter deploy --dry-run

# Undeploy (remove symlinks)
dotter undeploy

# Force deploy (overwrite existing files)
dotter deploy --force
```

### Dotter Package Organization

Packages are defined in `.dotter/global.toml`. Common packages:
- `shell` - bashrc, fish, tmux, vim, fzfrc, profile
- `neovim` - Neovim configuration
- `hyprland` / `sway` - Wayland compositors
- `i3` / `qtile` / `openbox` - X11 window managers (depend on `X11` package)
- `terminal` - alacritty, foot
- `yazi` - File manager
- `mpv` / `mpd` - Multimedia

## Code Style Guidelines

### Shell Scripts (Bash)

```bash
# Indentation: Tabs
# Quotes: Double for variables, single for literals
# Constants: UPPER_SNAKE_CASE with declare -r
declare -r BOLD='\[\e[1m\]'
declare -r RESET='\[\e[0;00m\]'

# Functions: name() { ... } style
my_function() {
    local var="value"
    # ...
}

# Conditionals: Use [[ ]] for tests
if [[ -f "$file" ]]; then
    # ...
fi

# Modeline at end of file
# vim: ft=sh foldmethod=marker
```

### Fish Shell

```fish
# Indentation: Tabs
# Use abbr for command shortcuts (not alias)
abbr --add vim -- nvim
abbr --add cls -- clear

# Functions: function name; ...; end
function my_func --description 'Description'
    set local_var "value"
    # ...
end
```

### Lua (Neovim)

```lua
-- File header comment
-- ~/.config/nvim/filename.lua

-- Indentation: 2 spaces
-- Quotes: Single quotes preferred
-- No semicolons
-- Always use local keyword

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set

-- Group names: __double_underscore_prefix for private groups
local __group_name = augroup('GroupName', { clear = true })

-- Autocommands with descriptive comments
autocmd('Event', {
  desc = 'Description of what this does',
  group = __group_name,
  callback = function() end
})

-- LSP type annotations
---@type vim.lsp.Config
local config = { ... }

-- Function documentation
---Brief description.
---@param name type Description
---@return type
local function my_func(name)
  return name
end
```

### Configuration Files

**TOML** (dotter, yazi, alacritty, cargo):
```toml
# Indentation: 2 spaces or tabs (varies by tool)
# Use $schema when available
'$schema' = 'https://...'

[section]
key = "value"
```

**JSONC** (opencode):
```jsonc
{
  "$schema": "https://...",
  "snake_case_keys": "value"
}
```

**Window Manager Configs** (Hyprland, Sway, i3):
```
# Indentation: Tabs
# Variables: $variable = value
# Group related settings with blank lines
# Include documentation URLs in comments

$terminal = foot
$menu = rofi -show drun

# vim: ft=hyprlang ts=4 sts=0 sw=4 noet
```

### Naming Conventions

| Type              | Convention        | Examples                           |
|-------------------|-------------------|------------------------------------|
| Shell constants   | UPPER_SNAKE_CASE  | `$EDITOR`, `$TERMINAL`             |
| Shell local vars  | lower_snake_case  | `last_status`, `prompt_host`       |
| Lua locals        | camelCase         | `augroup`, `bufmap`, `setlocal`    |
| Lua private vars  | __camelCase       | `__group_lsp_features`             |
| Config keys       | snake_case        | `small_model`, `sort_by`           |
| Directories       | lowercase         | `config`, `plugins`, `lsp`         |
| Files             | lowercase/kebab   | `config.fish`, `fzf-lua.lua`       |

### Comments

- Shell: `#` prefix, Spanish or English
- Lua: `--` single line, `--[[ ]]` blocks
- Include URLs to documentation where helpful
- Use vim modelines at end of files when needed

### Error Handling

- Shell: Check exit codes, use `set -e` in scripts when appropriate
- Lua: Use pcall/xpcall for error-prone operations
- Prefer defensive checks over try/catch patterns

## File Organization

- Each application config is self-contained in `config/<app>/`
- Dotter handles symlink deployment to target locations
- Machine-specific settings go in `.dotter/local.toml` (gitignored)
- The `[all]` package in global.toml deploys everything (use with caution)

## Environment

- Primary compositor: Hyprland (Wayland)
- Fallback: Sway (Wayland) or i3 (X11)
- Terminal: foot (Wayland), alacritty (X11)
- Editor: Neovim
- Shell: Fish (interactive), Bash (scripts)
- Package manager: pacman/AUR (Arch Linux)

## Subdirectory Documentation

- `config/opencode/AGENTS.md` - OpenCode AI assistant plugin development guidelines
