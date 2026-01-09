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
--[[ Colorscheme (PCSlim)     ]] Plug('https://github.com/pappasam/papercolor-theme-slim')
--[[ Copilot                  ]] Plug('https://github.com/github/copilot.vim.git')
--[[ fzf-lua                  ]] Plug('https://github.com/ibhagwan/fzf-lua')
--[[ indent-blankline         ]] Plug('https://github.com/lukas-reineke/indent-blankline.nvim')
--[[ nvim-lastplace           ]] Plug('https://github.com/ethanholz/nvim-lastplace.git')
--[[ nvim-treesitter          ]] Plug('https://github.com/nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate', ['branch'] = 'master'})
--[[ nvim-ts-autotag          ]] Plug('https://github.com/windwp/nvim-ts-autotag')
---[[ render-markdown          ]] Plug('https://github.com/MeanderingProgrammer/render-markdown.nvim', {['for'] = 'markdown'})
--[[ SCVim (SuperCollider)    ]] Plug('https://github.com/supercollider/scvim.git', {['for'] = 'supercollider' })
--[[ Simplenote               ]] Plug('https://github.com/simplenote-vim/simplenote.vim.git')
--[[ Syntax (Tridactyl)       ]] Plug('https://github.com/tridactyl/vim-tridactyl.git', {['for'] = 'tridactyl' })
--[[ vim-smoothie             ]] Plug('https://github.com/psliwka/vim-smoothie.git')
vim.fn['plug#end']()

--[[ General Settings ]]
set.title = true
set.titlestring = '%t%( %M%)%( (%{expand("%:~:h")})%)%a - Nvim'
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
set.completeopt = { 'fuzzy', 'menuone', 'noinsert', 'popup' }
-- Spelling
set.spell = false
set.spelllang = { 'es', 'en' }
-- set.spelloptions = { 'camel', 'noplainbuffer' }
set.spellsuggest = { 'best', 10 }

--[[ UI ]]
set.termguicolors = true
set.winborder = 'rounded'
-- Cursor
set.selection = 'exclusive'
set.guicursor =
  -- blink arguments seems to not work in foot(1)
  'a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,' ..
  'n-v-c:hor20,i-ci-ve:ver25,r-cr:block,o:block-blinkon0,' ..
  'sm:block-blinkwait175-blinkoff150-blinkon175,' ..
  't:hor1,'
-- VimDiff UI
if vim.opt.diff:get() then
  colorscheme('evening')
  set.diffopt = { 'filler', 'context:1000000' }
end

--[[ General Autocommands ]]
local __group_hl_yank = augroup('HighlightYank', { clear = true })
autocmd('TextYankPost', {
  desc = "Briefly highlight yanked text",
  group = __group_hl_yank,
  callback = function() vim.hl.on_yank() end
})

--[[ User Commands ]]
vim.api.nvim_create_user_command('Realpath', function()
    local __filepath = vim.api.nvim_buf_get_name(0)
    if __filepath == '' then
      print("No file is currently being edited.")
      return
    end
    vim.fn.setreg('+', __filepath)
    print("Copied to clipboard: " .. __filepath)
  end,
  { desc = "Copy current file's realpath to the '+' register" }
)

--[[ Requirables ]]
require('plugins.nvim-lastplace')
require('plugins.nvim-treesitter')
require('lsp')
require('plugins.indent-blankline')
require('plugins.copilot')
require('plugins.fzf-lua')
