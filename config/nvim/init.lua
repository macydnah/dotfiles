-- ~/.config/nvim/init.lua

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local colorscheme = vim.cmd.colorscheme
local highlight = vim.cmd.highlight
local map = vim.keymap.set
local set = vim.opt
local setlocal = vim.opt_local

--[[ Plugin manager ]]
local Plug = vim.fn['plug#']
vim.fn['plug#begin']('~/.config/nvim/plugged')
--[[ bg.nvim (Background)     ]] Plug('https://github.com/typicode/bg.nvim.git')
--[[ Colorscheme (PaperColor) ]] Plug('https://github.com/NLKNguyen/papercolor-theme.git')
--[[ Copilot                  ]] Plug('https://github.com/github/copilot.vim.git')
--[[ fzf-lua                  ]] Plug('https://github.com/ibhagwan/fzf-lua')
--[[ nvim-lastplace           ]] Plug('https://github.com/ethanholz/nvim-lastplace.git')
--[[ nvim-treesitter          ]] Plug('https://github.com/nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate'})
--[[ SCVim (SuperCollider)    ]] Plug('https://github.com/supercollider/scvim.git', { ['for'] = 'supercollider' })
--[[ Simplenote               ]] Plug('https://github.com/simplenote-vim/simplenote.vim.git')
--[[ Syntax (Tridactyl)       ]] Plug('https://github.com/tridactyl/vim-tridactyl.git', { ['for'] = 'tridactyl' })
--[[ vim-smoothie             ]] Plug('https://github.com/psliwka/vim-smoothie.git')
vim.fn['plug#end']()

--[[ General Settings ]]
set.title = true
-- set.titlestring['%t%( %M%)%( (%{expand("%:~:.:h")})%)%( %a%)']
set.ignorecase = true
set.smartcase = true
set.wrap = false
set.number = true
set.relativenumber = true
set.splitright = true
set.splitbelow = true
set.clipboard = 'unnamedplus'
set.scrolloff = 8
set.cmdheight = 0
set.foldlevelstart = 0
set.foldmethod = 'marker'
set.shortmess:append('I')
-- Add noselect to completeopt, otherwise autocompletion is annoying
-- set.completeopt:append('noselect')
set.completeopt = { 'menu', 'popup', 'menuone', 'noselect' }
-- Enable rounded borders in floating windows
vim.o.winborder = 'rounded'
-- Language Server Protocol (LSP) enable list
vim.lsp.enable({
  'clangd',
  'jedi_language_server',
  'lemminx',
  'lua-language-server',
  'rust-analyzer',
  'texlab',
})
vim.lsp.config('*', {
  root_markers = { '.git' },
})

--[[ Look and feel ]]
set.termguicolors = true
colorscheme("PaperColor")
autocmd({"BufWinEnter", "WinEnter"}, {
  desc = "Set background color based on time of the day",
  group = vim.api.nvim_create_augroup('AutoLightDarkBackground', { clear = true }),
  pattern = "*",
  callback = function()
    local hour = tonumber(os.date("%H%M"))
    if hour < 1700 and hour > 0730 then
      set.background = "light"
    else
      set.background = "dark"
    end
  end,
})
-- Cursor
set.selection = 'exclusive'
set.guicursor =
  -- blink arguments seems to not work in foot(1)
  'a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,' ..
  'n-v-c:hor20,i-ci-ve:ver25,r-cr:block,o:block-blinkon0,' ..
  'sm:block-blinkwait175-blinkoff150-blinkon175,' ..
  't:hor1,'
-- Diff mode
local diff_mode = vim.opt.diff:get()
if diff_mode then
  colorscheme("evening")
  set.diffopt = { "filler", "context:1000000" }
end

--[[ General Autocommands ]]
local highlight_yank_group = augroup('HighlightYank', { clear = true })
autocmd('TextYankPost', {
  desc = "Briefly highlight yanked text",
  group = highlight_yank_group,
  callback = function() vim.hl.on_yank() end
})
autocmd('LspAttach', {
  desc = 'Enable LSP autocompletion by client capabilities',
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
    end
  end,
})
autocmd('LspAttach', {
  desc = 'LSP key mappings',
  callback = function()
    ---[[ LSP key mappings
    local bufmap = function(mode, lhs, rhs)
      local opts = { buffer = true }
      vim.keymap.set(mode, lhs, rhs, opts)
    end
    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', function() vim.lsp.buf.hover() end)
    -- Jump to the definition
    bufmap('n', 'gd', function() vim.lsp.buf.definition() end)
    -- Jump to declaration
    bufmap('n', 'gD', function() vim.lsp.buf.declaration() end)
    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', function() vim.lsp.buf.implementation() end)
    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', function() vim.lsp.buf.type_definition() end)
    -- Lists all the references
    bufmap('n', 'gr', function() vim.lsp.buf.references() end)
    -- Displays a function's signature information
    bufmap('n', 'gs', function() vim.lsp.buf.signature_help() end)
    -- Renames all references to the symbol under the cursor
    bufmap('n', '<F2>', function() vim.lsp.buf.rename() end)
    -- Selects a code action available at the current cursor position
    bufmap('n', '<F4>', function() vim.lsp.buf.code_action() end)
    -- Show diagnostics in a floating window
    bufmap('n', 'gl', function() vim.diagnostic.open_float() end)
    --]]

    ---[[ Diagnostics config
    vim.diagnostic.config({
      -- see :help vim.diagnostic.Opts
      underline = true,
      virtual_text = false,
      virtual_lines = { current_line = true },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '✘',
          [vim.diagnostic.severity.WARN] = '▲',
          [vim.diagnostic.severity.HINT] = '⚑',
          [vim.diagnostic.severity.INFO] = '»',
        },
        linehl = {
          -- [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
          -- [vim.diagnostic.severity.WARN] = 'WarningMsg',
          -- [vim.diagnostic.severity.HINT] = 'HintMsg',
          -- [vim.diagnostic.severity.INFO] = 'InfoMsg',
        },
        numhl = {
          -- [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
          -- [vim.diagnostic.severity.WARN] = 'WarningMsg',
          -- [vim.diagnostic.severity.HINT] = 'HintMsg',
          -- [vim.diagnostic.severity.INFO] = 'InfoMsg',
        },
      },
      update_in_insert = true,
      severity_sort = true,
    }) --]]
  end,
})

--[[ Plugin Requirements ]]
require'plugins.copilot'
require'plugins.fzf-lua'
require'plugins.nvim-lastplace'
require'plugins.nvim-treesitter'

--[[ User Commands ]]
vim.api.nvim_create_user_command('Realpath', function()
    local filepath = vim.api.nvim_buf_get_name(0)
    if filepath == '' then
      print("No file is currently being edited.")
      return
    end
    vim.fn.setreg('+', filepath)
    print("Copied to clipboard: " .. filepath)
  end,
  { desc = "Copy current file's realpath to the '+' register" }
)
