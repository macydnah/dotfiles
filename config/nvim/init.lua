-- ~/.config/nvim/init.lua

local vim = vim
local autocmd = vim.api.nvim_create_autocmd
local colorscheme = vim.cmd.colorscheme
local highlight = vim.cmd.highlight
local map = vim.keymap.set
local set = vim.opt
local setlocal = vim.opt_local

--[[ Plugin manager
--]]
local Plug = vim.fn['plug#']
vim.fn['plug#begin']('~/.config/nvim/plugged')
-- Colorscheme (PaperColor)
Plug('https://github.com/NLKNguyen/papercolor-theme.git')
-- Copilot
Plug('https://github.com/github/copilot.vim.git')
-- nvim-lastplace
Plug('https://github.com/ethanholz/nvim-lastplace.git')
-- SCVim (SuperCollider)
Plug('https://github.com/supercollider/scvim.git', { ['for'] = 'supercollider' })
-- Simplenote
Plug('https://github.com/simplenote-vim/simplenote.vim.git')
-- Syntax (Hyprland)
Plug('https://github.com/theRealCarneiro/hyprland-vim-syntax.git', { ['for'] = 'hypr' })
-- Syntax (Tridactyl)
Plug('https://github.com/tridactyl/vim-tridactyl.git', { ['for'] = 'tridactyl' })
-- vim-smoothie
Plug('https://github.com/psliwka/vim-smoothie.git')
vim.fn['plug#end']()

--[[ General Settings
--]]
set.title = true
-- set.titlestring['%t%( %M%)%( (%{expand("%:~:.:h")})%)%( %a%)']
set.ignorecase = true
set.smartcase = true
set.wrap = false
set.number = true
set.splitright = true
set.splitbelow = true
-- set.list = true
-- set.listchars = { tab = "⎽⎽⏌", lead = "⎽", trail = "·", eol = "↵" }

--[[ Look and feel
--]]
set.guicursor = ""
set.termguicolors = true
colorscheme("PaperColor")
autocmd("WinEnter", {
	desc = "Set background color based on time of day",
	pattern = "*",
	callback = function()
		local hour = tonumber(os.date("%H%M"))
		if hour < 1730 and hour > 0730 then
			set.background = "light"
		else
			set.background = "dark"
		end
	end,
})
local diff_mode = vim.opt.diff:get()
if diff_mode then
	colorscheme("evening")
	set.diffopt = { "filler", "context:1000000" }
end

--[[ General Maps & Autocommands
--]]
-- Open the current file with F12 in Firefox
map({''}, '<F12>', function()
	os.execute('firefox ' .. vim.fn.expand('%'))
	end,
	{ desc = 'Open current file in Firefox', silent = false })
-- Copy from the current buffer to Wayland clipboard (wl-copy)
map({'n', 'v', 'o'}, '<F10>',
	'<cmd>w !wl-copy -n<cr><cr>',
	{ desc = 'Copy to Wayland clipboard', silent = true })
-- Count the total number of words in the current buffer or visual selection
map({'n', 'v', 'o'}, '<F10>',
	'<cmd>w !wc -w<cr><cr>',
	{ desc = 'Count words in buffer/visual selection', silent = true })
-- Executes the import-gsettings script when the settings.ini file is saved
--[[
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "$HOME/.config/gtk-3.0/settings.ini",
	callback = function()
		vim.cmd("silent! !import-gsettings")
	end,
})
--]]

--[[ Highlight the current cursor coordinate within the active window (crosshair)
--]]
set.cursorline = true
set.cursorcolumn = true
local function auto_crosshair()
	local hour = tonumber(os.date("%H%M"))
	if hour < 1730 and hour > 0730 then
		highlight({ "CursorLine", "guifg=NONE", "guibg=#d4d4d4", "gui=underline,italic" })
		highlight({ "CursorColumn", "guifg=NONE", "guibg=#d4d4d4", "gui=bold" })
	else
		highlight({ "CursorLine", "guifg=NONE", "guibg=#303030", "gui=underline,italic" })
		highlight({ "CursorColumn", "guifg=NONE", "guibg=#303030", "gui=NONE" })
	end
end
auto_crosshair()
autocmd("WinEnter", {
	desc = "Enable cursorline and cursorcolumn in the current window",
	pattern = "*",
	callback = function()
		setlocal.cursorline = true
		setlocal.cursorcolumn = true
	end,
})
autocmd("WinLeave", {
	desc = "Disable cursorline and cursorcolumn when leaving the current window",
	pattern = "*",
	callback = function()
		setlocal.cursorline = false
		setlocal.cursorcolumn = false
	end,
})
autocmd("InsertEnter", {
	desc = "Disable cursorline and cursorcolumn when entering insert mode",
	pattern = "*",
	callback = function()
		highlight({ "CursorLine", "guifg=NONE", "guibg=NONE", "gui=NONE" })
		highlight({ "CursorColumn", "guifg=NONE", "guibg=NONE", "gui=NONE" })
	end,
})
autocmd("InsertLeave", {
	desc = "Enable cursorline and cursorcolumn when leaving insert mode",
	pattern = "*",
	callback = function()
		auto_crosshair()
	end,
})

--[[ FileType settings
--]]
-- HTML FileType settings
autocmd("FileType", {
	pattern = "html",
	callback = function()
		setlocal.tabstop = 8
		setlocal.softtabstop = 2
		setlocal.shiftwidth = 2
		setlocal.expandtab = false
		setlocal.autoindent = true
		setlocal.wrap = true
		setlocal.smoothscroll = true
		setlocal.linebreak = true
	end,
})
autocmd("BufNewFile", {
	pattern = "*.html",
	callback = function()
		vim.cmd("0r ~/Templates/skeleton.html")
	end,
})
-- JSON FileType settings
autocmd("FileType", {
	pattern = "json",
	callback = function()
		setlocal.tabstop = 4
		setlocal.shiftwidth = 4
		setlocal.expandtab = false
		setlocal.autoindent = true
	end,
})
-- SH FileType settings
autocmd("FileType", {
	pattern = "sh",
	callback = function()
		setlocal.tabstop = 4
		setlocal.shiftwidth = 4
		setlocal.expandtab = false
		setlocal.autoindent = true
	end,
})
autocmd("BufNewFile", {
	pattern = "*.sh",
	callback = function()
		vim.cmd("0r ~/Templates/skeleton.sh")
	end,
})
-- SVG FileType settings
autocmd("FileType", {
	pattern = "svg",
	callback = function()
		setlocal.tabstop = 8
		setlocal.softtabstop = 2
		setlocal.shiftwidth = 2
		setlocal.expandtab = false
		setlocal.autoindent = true
	end,
})
autocmd("BufNewFile", {
	pattern = "*.svg",
	callback = function()
		vim.cmd("0r ~/Templates/skeleton.svg")
		vim.cmd("2")
	end,
})

--[[ Plugin Settings
--]]
-- Copilot
local function ToggleCopilot()
	-- 0 and 1 are both truthy in Lua, can't rely
	-- on just calling the Vimscript copilot function
	-- https://github.com/neovim/neovim/issues/26983
	if vim.fn['copilot#Enabled']() == 1 then
		vim.cmd("Copilot disable")
	else
		vim.cmd("Copilot enable")

	end
	vim.cmd("Copilot status")
end
map({'i', 'n'}, '<F1>', function()
	ToggleCopilot()
	end, { desc = 'Toggle Copilot On/Off', silent = false })

-- nvim-lastplace
require'nvim-lastplace'.setup {
    lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
    lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
    lastplace_open_folds = true
}

-- Simplenote
local simplenoterc = os.getenv("HOME") .. "/.config/vim/simplenoterc.vim"
vim.cmd.source(simplenoterc)

-- SuperCollider
autocmd({"BufEnter", "BufWinEnter", "BufNewFile", "BufRead"}, {
	desc = "Set filetype to supercollider when opening .sc or .scd files",
	pattern = {"*.sc", "*.scd"},
	callback = function()
		vim.o.filetype = "supercollider"
	end,
})
vim.g.sclangTerm = "foot"
vim.g.scFlash = 1
