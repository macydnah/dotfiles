-- ~/.config/nvim/lua/plugins/fzf-lua.lua

-- if an ALTERNATIVE_LAYOUT is set as an argument for the 'preview-window' option in the `fzf` command
-- it'll conflict with fzf-lua layout management (note: fzf-lua will still load FZF_DEFAULT_OPTS_FILE)
vim.env.FZF_DEFAULT_OPTS = nil

local actions = require('fzf-lua').actions

require('fzf-lua').setup {
  -- https://github.com/ibhagwan/fzf-lua/raw/refs/heads/main/OPTIONS.md
  winopts = {
    height = 0.85,
    width = 0.80,
    row = 0.35,
    col = 0.50,
    border = 'none',
    backdrop = 70,
    -- title = "Title",
    title_pos = 'left',
    title_flags = false,
    fullscreen = false,
    preview = {
      default = 'builtin',
      border = 'rounded',
      wrap = false,
      hidden = false,
      vertical = 'up:45%',
      horizontal = 'right:60%',
      layout = 'flex',
      flip_columns = 100,
      -- Only used with the builtin previewer:
      title = false,
      title_pos = 'center',
      scrollbar = 'float',
      scrolloff = -1,
      delay = 20,
      winopts = {
        number = true,
        relativenumber = false,
        cursorline = true,
        cursorlineopt = 'both',
        cursorcolumn = false,
        signcolumn = 'no',
        list = false,
        foldenable = false,
        foldmethod = 'manual',
      },
    },
  },

  keymap = {
    builtin = {
      ['<M-Esc>']     = 'hide',     -- hide fzf-lua, `:FzfLua resume` to continue
      ['<F1>']        = 'toggle-help',
      ['<F2>']        = 'toggle-fullscreen',
      -- Only valid with the 'builtin' previewer
      ['<F3>']        = 'toggle-preview-wrap',
      ['<F4>']        = 'toggle-preview',
      -- Rotate preview clockwise/counter-clockwise
      ['<F5>']        = 'toggle-preview-cw',
      -- Preview toggle behavior default/extend
      ['<F6>']        = 'toggle-preview-behavior',
      -- `ts-ctx` binds require `nvim-treesitter-context`
      ['<F7>']        = 'toggle-preview-ts-ctx',
      ['<F8>']        = 'preview-ts-ctx-dec',
      ['<F9>']        = 'preview-ts-ctx-inc',
      ['<M-j>']       = 'preview-page-down',
      ['<M-k>']       = 'preview-page-up',
      ['<M-S-j>']     = 'preview-down',
      ['<M-S-k>']     = 'preview-up',
      ['<S-Left>']    = 'preview-reset',
      ['<S-down>']    = 'preview-page-down',
      ['<S-up>']      = 'preview-page-up',
      ['<M-S-down>']  = 'preview-down',
      ['<M-S-up>']    = 'preview-up',
    },
    fzf = {
      ['ctrl-z']      = 'abort',
      ['ctrl-u']      = 'unix-line-discard',
      ['ctrl-f']      = 'half-page-down',
      ['ctrl-b']      = 'half-page-up',
      ['ctrl-a']      = 'beginning-of-line',
      ['ctrl-e']      = 'end-of-line',
      ['alt-a']       = 'toggle-all',
      ['alt-g']       = 'first',
      ['alt-G']       = 'last',
      -- Only valid with fzf previewers (bat/cat/git/etc)
      ['f3']          = 'toggle-preview-wrap',
      ['f4']          = 'toggle-preview',
      ['shift-down']  = 'preview-page-down',
      ['shift-up']    = 'preview-page-up',
    },
  },

  actions = {
    files = {
      ['enter']       = actions.file_edit,
      ['ctrl-s']      = actions.file_split,
      ['ctrl-v']      = actions.file_vsplit,
      ['ctrl-t']      = actions.file_tabedit,
      ['alt-q']       = actions.file_sel_to_qf,
      ['alt-Q']       = actions.file_sel_to_ll,
      ['alt-i']       = actions.toggle_ignore,
      ['alt-h']       = actions.toggle_hidden,
      ['alt-f']       = actions.toggle_follow,
    },
  },

  fzf_opts = {
    -- ['--list-border'] = 'none',
    -- ['--input-border'] = 'none',
    -- ['--ghost'] = " ",
    -- ['--pointer'] = "➤ ",
    -- ['--marker'] = "✓ ",
    -- ['--marker'] = "🗹 ",
  },

  previewers = {
    bat = {
      cmd = 'bat',
      args = '--plain --color=always',
    },
    builtin = {
      syntax = true,
      syntax_limit_l = 0,
      syntax_limit_b = 1024*1024,
      limit_b = 1024*1024*10,
      toggle_behavior = 'default',
    },
  },

  files = {
    prompt = '📝 ',
    multiprocess = true,
    git_icons = false,
    file_icons = false,
    color_icons = false,
    fd_opts = [[--color=never --type file --type symlink --exclude .git]],
    cwd_prompt = true, -- this overrides 'prompt' option
    cwd_prompt_shorten_len = 32,
    cwd_prompt_shorten_val = 1,
    toggle_ignore_flag = '--no-ignore',
    toggle_hidden_flag = '--hidden',
    toggle_follow_flag = '-L',
    hidden = true,
    follow = false,

    winopts = {
      title = "",
      border = 'none',
    },
    fzf_opts = {
      ['--ghost'] = " ",
    },
  },

  buffers = {
    prompt = '📌 ',
    file_icons = false,
    color_icons = false,
    sort_lastused = true,
    show_unloaded = true,
    cwd_only = false,
    cwd = nil,

    winopts = {
      title = "",
      border = 'none',
    },
    actions = {
      ['ctrl-x'] = false,
      ['ctrl-d'] = { fn = actions.buf_del, reload = true },
    },
    fzf_opts = {
      ['--ghost'] = "Buffers...",
      -- ['--no-input'] = false,
    },
  },

  helptags = {
    winopts = {
      title = "",
      border = 'none',
      fullscreen = true,
    },
    actions = {
      ['enter'] = function(selected)
        if vim.opt_local.filetype:get() == 'help' then
          return actions.help(selected)
        else
          return actions.help_tab(selected)
        end
      end,
    },
    fzf_opts = {
      ['--ghost'] = "Search for help...",
    },
  },
}

require('fzf-lua').register_ui_select()

---Wrapper around |vim.keymap.set| to set keymaps for FzfLua functions
---@param mode string|string[] Mode "short-name" (see nvim_set_keymap()), or a list thereof.
---@param lhs string Left-hand side |{lhs}| of the mapping.
---@param desc string Description of the mapping.
---@param rhs string|function Right-hand side |{rhs}| of the mapping, can be a Lua function.
---@param opts table? Additional options for the mapping.
local function keymap(mode, lhs, desc, rhs, opts)
  local defaults = { silent = true, desc = 'FzfLua: ' .. desc }
  opts = vim.tbl_extend('force', defaults, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

keymap('n', '<C-\\>', "List open buffers",
  function() require('fzf-lua').buffers() end)

-- keymap('n', '<C-k>', "Fuzzy search fzf-lua functions",
--   function() require('fzf-lua').builtin() end)

keymap('n', '<C-p>', "Fuzzy search files in cwd",
  function() require('fzf-lua').files() end)

-- keymap('n', '<C-l>', "Live grep in cwd",
--   function() require('fzf-lua').live_grep() end)

keymap('n', '<C-g>', "Grep in project",
  function() require('fzf-lua').grep_project() end)

keymap('n', '<F1>', "Search help tags",
  function() require('fzf-lua').help_tags() end)
