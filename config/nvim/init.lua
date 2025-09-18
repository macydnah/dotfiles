-- ~/.config/nvim/init.lua

-- local vim = vim
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
-- set.list = true
set.listchars = { tab = "⎽⎽⏌", lead = "⎽", trail = "·", eol = "↵" }
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

--[[ Look and feel ]]
set.termguicolors = true
colorscheme("PaperColor")
autocmd({"BufWinEnter", "WinEnter"}, {
  desc = "Set background color based on time of the day",
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

--[[ General Mappings ]]

-- Use ctrl-[hjkl] to select the active split
-- http://vim.wikia.com/wiki/Switch_between_Vim_window_splits_easily
-- https://stackoverflow.com/questions/6053301/easier-way-to-navigate-between-vim-split-panes
map({'n'}, '<c-h>', function()
  vim.cmd('wincmd h')
end, { desc = "Move cursor to Nth window left of current one", silent = true })
map({'n'}, '<c-j>', function()
  vim.cmd('wincmd j')
end, { desc = "Move cursor to Nth window below current one", silent = true })
map({'n'}, '<c-k>', function()
  vim.cmd('wincmd k')
end, { desc = "Move cursor to Nth window above current one", silent = true })
map({'n'}, '<c-l>', function()
  vim.cmd('wincmd l')
end, { desc = "Move cursor to Nth window right of current one", silent = true })

--[[ General Autocommands ]]
autocmd('TextYankPost', {
  desc = "Briefly highlight yanked text",
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
--[[ Executes the import-gsettings script when the settings.ini file is saved
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "$HOME/.config/gtk-3.0/settings.ini",
  callback = function()
    vim.cmd("silent! !import-gsettings")
  end,
}) --]]

--[[ Highlight the current cursor coordinate within the active window (crosshair) ]]
local function auto_crosshair()
  setlocal.cursorline = true
  setlocal.cursorcolumn = true
  if set.background:get() == "light" then
    highlight({ "CursorLine", "guifg=NONE", "guibg=#d4d4d4", "gui=bold,italic" })
    highlight({ "CursorColumn", "guifg=NONE", "guibg=#d4d4d4", "gui=NONE" })
  else
    highlight({ "CursorLine", "guifg=NONE", "guibg=#303030", "gui=bold,italic" })
    highlight({ "CursorColumn", "guifg=NONE", "guibg=#303030", "gui=NONE" })
  end
end
augroup('CrossHair', { clear = true })
autocmd({"BufWinEnter", "WinEnter"}, {
  desc = "Enable cursorline and cursorcolumn in the current buffer/window",
  group = 'CrossHair',
  pattern = "*",
  callback = function()
    auto_crosshair()
  end,
})
autocmd("WinLeave", {
  desc = "Disable cursorline and cursorcolumn when leaving the current window",
  group = 'CrossHair',
  pattern = "*",
  callback = function()
    setlocal.cursorline = false
    setlocal.cursorcolumn = false
  end,
})
autocmd("InsertEnter", {
  desc = "Disable underline and italic cursorline when entering insert mode",
  group = 'CrossHair',
  pattern = "*",
  callback = function()
    highlight({ "CursorLine", "gui=NONE" })
  end,
})
autocmd("InsertLeave", {
  desc = "Enable cursorline and cursorcolumn when leaving insert mode",
  group = 'CrossHair',
  pattern = "*",
  callback = function()
    auto_crosshair()
  end,
})

--[[ FileType settings ]]
-- augroup('FileTypeSetting', { clear = true })
-- HTML FileType settings
-- autocmd('FileType', {
--   desc = 'HTML FileType settings ts=8 sts=2 sw=2 noet ai wrap smoothscroll linebreak',
--   group = 'FileTypeSetting',
--   pattern = { 'html', 'xml', 'xhtml' },
--   callback = function()
--     setlocal.tabstop = 8
--     setlocal.softtabstop = 2
--     setlocal.shiftwidth = 2
--     setlocal.expandtab = false
--     setlocal.autoindent = true
--     setlocal.wrap = true
--     setlocal.smoothscroll = true
--     setlocal.linebreak = true
--     map({''}, '<F12>', function()
--       os.execute('firefox ' .. vim.fn.expand('%'))
--     end,
--     { desc = 'Open current HTML file in Firefox', silent = true, buffer = true })
--   end,
-- })
-- autocmd('BufNewFile', {
--   desc = 'Insert skeleton HTML template',
--   group = 'FileTypeSetting',
--   pattern = '*.html',
--   callback = function()
--     vim.cmd("0r ~/Templates/skeleton.html")
--   end,
-- })
-- autocmd('BufNewFile', {
--   desc = 'Insert skeleton XML template',
--   group = 'FileTypeSetting',
--   pattern = '*.xml',
--   callback = function()
--     vim.cmd("0r ~/Templates/skeleton.xml")
--   end,
-- })
-- JSON FileType settings
-- autocmd('FileType', {
--   desc = 'JSON FileType settings ts=4 sts=2 sw=2 noet ai',
--   group = 'FileTypeSetting',
--   pattern = 'json',
--   callback = function()
--     setlocal.tabstop = 4
--     setlocal.softtabstop = 2
--     setlocal.shiftwidth = 2
--     setlocal.expandtab = false
--     setlocal.autoindent = true
--   end,
-- })
-- LUA FileType settings
-- autocmd('FileType', {
--   desc = 'LUA FileType settings ts=8 sw=2 sts=2 et ai',
--   group = 'FileTypeSetting',
--   pattern = 'lua',
--   callback = function()
--     setlocal.tabstop = 8
--     setlocal.softtabstop = 2
--     setlocal.shiftwidth = 2
--     setlocal.expandtab = true
--     setlocal.autoindent = true
--   end,
-- })
-- RS FileType settings
-- autocmd('FileType', {
--   desc = 'Rust FileType settings ts=8 sts=4 sw=4 et ai',
--   group = 'FileTypeSetting',
--   pattern = 'rust',
--   callback = function()
--     setlocal.tabstop = 8
--     setlocal.softtabstop = 4
--     setlocal.shiftwidth = 4
--     setlocal.expandtab = true
--     setlocal.autoindent = true
--   end,
-- })
-- SH FileType settings
-- autocmd('FileType', {
--   desc = 'SH FileType settings ts=4 sw=4 noet ai',
--   group = 'FileTypeSetting',
--   pattern = 'sh',
--   callback = function()
--     setlocal.tabstop = 4
--     setlocal.shiftwidth = 4
--     setlocal.expandtab = false
--     setlocal.autoindent = true
--   end,
-- })
-- autocmd('BufNewFile', {
--   desc = 'Insert skeleton bash script template',
--   group = 'FileTypeSetting',
--   pattern = '*.sh',
--   callback = function()
--     vim.cmd("0r ~/Templates/skeleton.sh")
--   end,
-- })
-- SQL FileType settings
-- autocmd('FileType', {
--   desc = 'SQL FileType settings ts=8 sts=4 sw=4 et ai',
--   group = 'FileTypeSetting',
--   pattern = 'sql',
--   callback = function()
--     setlocal.tabstop = 8
--     setlocal.softtabstop = 4
--     setlocal.shiftwidth = 4
--     setlocal.expandtab = true
--     setlocal.autoindent = true
--   end,
-- })
-- SVG FileType settings
-- autocmd('FileType', {
--   desc = 'SVG FileType settings ts=8 sts=2 sw=2 noet ai',
--   group = 'FileTypeSetting',
--   pattern = 'svg',
--   callback = function()
--     setlocal.tabstop = 8
--     setlocal.softtabstop = 2
--     setlocal.shiftwidth = 2
--     setlocal.expandtab = false
--     setlocal.autoindent = true
--   end,
-- })
-- autocmd('BufNewFile', {
--   desc = 'Insert skeleton SVG template',
--   group = 'FileTypeSetting',
--   pattern = '*.svg',
--   callback = function()
--     vim.cmd("0r ~/Templates/skeleton.svg")
--     vim.cmd("2")
--   end,
-- })
-- TEX FileType settings
-- autocmd('FileType', {
--   desc = 'TEX FileType settings ts=8 sts=8 sw=8 noet noai wrap linebreak smoothscroll',
--   group = 'FileTypeSetting',
--   pattern = 'tex',
--   callback = function()
--     setlocal.tabstop = 8
--     setlocal.softtabstop = 8
--     setlocal.shiftwidth = 8
--     setlocal.expandtab = false
--     setlocal.autoindent = false
--     setlocal.wrap = true
--     setlocal.linebreak = true
--     setlocal.smoothscroll = true
--     setlocal.cursorcolumn = false
--     colorscheme("unokai")
--   end,
-- })
-- TXT FileType settings
-- autocmd('FileType', {
--   desc = 'TXT FileType settings ts=8 sts=8 sw=8 noet ai wrap linebreak smoothscroll spell spelllang=es',
--   group = 'FileTypeSetting',
--   pattern = 'text',
--   callback = function()
--     setlocal.tabstop = 8
--     setlocal.softtabstop = 8
--     setlocal.shiftwidth = 8
--     setlocal.expandtab = false
--     setlocal.autoindent = true
--     setlocal.wrap = true
--     setlocal.linebreak = true
--     setlocal.smoothscroll = true
--     setlocal.cursorline = true
--     setlocal.cursorcolumn = false
--     setlocal.spell = true
--     setlocal.spelllang = { 'es' }
--   end,
-- })

--[[ Plugin Settings ]]

---[[ Copilot
vim.g.copilot_enabled = false
-- vim.b.copilot_enabled = true
local function ToggleCopilot()
  -- 0 and 1 are both truthy in Lua, can't rely on just calling the
  -- Vimscript copilot function to retrieve its enabled/disabled state
  -- https://github.com/neovim/neovim/issues/26983
  if vim.fn['copilot#Enabled']() == 1 then
    vim.cmd('Copilot disable')
  else
    vim.cmd('Copilot enable')
  end
  vim.cmd('Copilot status')
end
map({'i', 'n'}, '<F1>', function()
  ToggleCopilot()
end, { desc = "Toggle Copilot On/Off", silent = false })
--]]

---[[ nvim-lastplace
require'nvim-lastplace'.setup {
  lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
  lastplace_ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' },
  lastplace_open_folds = true
} --]]

---[[ nvim-treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'c',
    'css',
    'html',
    'json',
    'latex',
    'lua',
    'markdown',
    'markdown_inline',
    'python',
    'query',
    'rust',
    'supercollider',
    'toml',
    'vim',
    'vimdoc',
  },
  auto_install = false,
  ignore_install = { '' },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = { '' }
  },
  indent = {
    enable = false,
  },
} --]]

--[[ Simplenote
local simplenoterc = os.getenv('HOME') .. '/.config/vim/simplenoterc.vim'
vim.cmd.source(simplenoterc) --]]

---[[ SuperCollider
-- vim.g.sclangTerm = 'footclient --title sclang'
-- vim.g.scFlash = 1
-- autocmd('FileType', {
--   desc = 'SuperCollider FileType settings ts=4 sts=2 sw=2 noet ai',
--   group = 'FileTypeSetting',
--   pattern = 'supercollider',
--   callback = function()
--     setlocal.tabstop = 8
--     setlocal.softtabstop = 4
--     setlocal.shiftwidth = 4
--     setlocal.expandtab = false
--     setlocal.autoindent = true
--     map({''}, '<s-enter>', vim.fn['SClang_line'], { desc = "Send line to SuperCollider", silent = true, buffer = true })
--     map({''}, '<c-enter>', vim.fn['SClang_block'], { desc = "Send block to SuperCollider", silent = true, buffer = true })
--     map({''}, '<c-.>', vim.fn['SClangHardstop'], { desc = "Hard stop SuperCollider", silent = true, buffer = true })
--   end,
-- }) --]]

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
