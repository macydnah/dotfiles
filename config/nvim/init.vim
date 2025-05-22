" ~/.config/nvim/init.vim
"
"set runtimepath^=~/.config/vim runtimepath+=~/.config/vim/after
"let &packpath = &runtimepath
"source ~/.config/vim/vimrc

""" Plugins
"call plug#begin('~/.config/vim/plugged')
""" Colorscheme (PaperColor)
"Plug 'https://github.com/NLKNguyen/papercolor-theme.git'
""" Copilot
"Plug 'https://github.com/github/copilot.vim.git'
""" SCVim (SuperCollider)
"Plug 'https://github.com/supercollider/scvim.git', { 'for': 'supercollider' }
""" Simplenote
"Plug 'https://github.com/simplenote-vim/simplenote.vim.git'
""" Syntax (Hyprland)
"Plug 'https://github.com/theRealCarneiro/hyprland-vim-syntax.git', { 'for': 'hypr' }
""" Syntax (Tridactyl)
"Plug 'https://github.com/tridactyl/vim-tridactyl.git', { 'for': 'tridactyl' }
""" vim-smoothie
"Plug 'https://github.com/psliwka/vim-smoothie.git'
"call plug#end()
lua << EOF
local vim = vim
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
EOF

""" General Settings
""
"set title
"set ignorecase
"set smartcase
"set nowrap
"set number
"set splitright
"set splitbelow
"
"" Set terminal title to this titlestring
"set title titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
"
"" Set indentation guidelines chars
"set list
"set listchars=tab:⎽⎽⏌,lead:⎽,trail:·,eol:↵
lua << EOF
local set = vim.opt
set.title = true
set.ignorecase = true
set.smartcase = true
set.wrap = false
set.number = true
set.splitright = true
set.splitbelow = true

-- Set terminal title to this titlestring
-- set.titlestring['%t%( %M%)%( (%{expand("%:~:.:h")})%)%( %a%)']
--
-- Set indentation guidelines chars
-- set.list = true
-- set.listchars = { tab = "⎽⎽⏌", lead = "⎽", trail = "·", eol = "↵" }
EOF

""" Look and feel
""
"set guicursor=
"set t_Co=256
"set termguicolors
"colorscheme PaperColor
"if strftime("%H") < 18 && strftime("%H") > 07
"	set background=light
"else
"	set background=dark
"endif
"if &diff | colorscheme evening | set diffopt=filler,context:1000000 | endif
lua << EOF
local colorscheme = vim.cmd.colorscheme
local set = vim.opt
set.guicursor = ""
set.termguicolors = true
colorscheme("PaperColor")

local hour = tonumber(os.date("%H%M"))
if hour < 1730 and hour > 0730 then
	set.background = "light"
else
	set.background = "dark"
end

local diff_mode = vim.opt.diff:get()
if diff_mode then
	colorscheme("evening")
	set.diffopt = { "filler", "context:1000000" }
end
EOF


""" General Maps & Autocommands
""
"" Open the current file with F12 in Firefox
"map <silent> <F12> :!firefox % <enter><enter>
"
"" Copy from the current buffer to Wayland clipboard (wl-copy)
"map <silent> <F10> :w !wl-copy -n <CR><CR>
"
"" Count the total number of words in the current buffer or visual selection
"map <silent> <F9> :w !wc -w <CR>
"
"" Executes the import-gsettings script when the settings.ini file is saved
"autocmd BufWritePost $HOME/.config/gtk-3.0/settings.ini silent! !import-gsettings
lua << EOF
local map = vim.keymap.set
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
--vim.api.nvim_create_autocmd("BufWritePost", {
--	pattern = "$HOME/.config/gtk-3.0/settings.ini",
--	callback = function()
--		vim.cmd("silent! !import-gsettings")
--	end,
--})
EOF

""" Highlight the current cursor coordinate within the active window
""
"set cursorline
"set cursorcolumn
"if strftime("%H%M") < 1730 && strftime("%H%M") > 0730
"	highlight CursorLine guifg=NONE guibg=LightGray gui=underline,italic
"	highlight CursorColumn guifg=NONE guibg=LightGray gui=bold
"else
"	highlight CursorLine guifg=NONE guibg=#2c2c2c gui=underline,italic
"	highlight CursorColumn guifg=NONE guibg=#2c2c2c gui=bold
"endif
"au WinEnter * setlocal cursorline cursorcolumn
"au WinLeave * setlocal nocursorline nocursorcolumn
"au InsertEnter * highlight CursorLine ctermfg=NONE ctermbg=NONE cterm=NONE
"au InsertLeave * highlight CursorLine ctermfg=NONE ctermbg=NONE cterm=underline,italic
"au InsertEnter * highlight CursorColumn ctermfg=NONE ctermbg=NONE cterm=bold
"au InsertLeave * highlight CursorColumn ctermfg=NONE ctermbg=DarkGray cterm=NONE
lua << EOF
local highlight = vim.cmd.highlight
local set = vim.opt
set.cursorline = true
set.cursorcolumn = true
local function cursor_auto_highlight()
	local hour = tonumber(os.date("%H%M"))
	if hour < 1730 and hour > 0730 then
		highlight({ "CursorLine", "guifg=NONE", "guibg=#d4d4d4", "gui=underline,italic" })
		highlight({ "CursorColumn", "guifg=NONE", "guibg=#d4d4d4", "gui=bold" })
	else
		highlight({ "CursorLine", "guifg=NONE", "guibg=#303030", "gui=underline,italic" })
		highlight({ "CursorColumn", "guifg=NONE", "guibg=#303030", "gui=NONE" })
	end
end
cursor_auto_highlight()

local autocmd = vim.api.nvim_create_autocmd
local setlocal = vim.opt_local
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
		cursor_auto_highlight()
	end,
})
EOF

""" FileType settings
""
"" HTML FileType setting
"au FileType html setlocal tabstop=8 softtabstop=2 shiftwidth=2 noexpandtab autoindent wrap smoothscroll linebreak
"au BufNewFile *.html 0r ~/Templates/skeleton.html
"" JSON FileType setting
"au FileType json setlocal tabstop=4 shiftwidth=4 noexpandtab autoindent
"" SH FileType setting
"au FileType sh setlocal tabstop=4 shiftwidth=4 noexpandtab autoindent
"au BufNewFile *.sh 0r ~/Templates/skeleton.sh
"" SVG FileType setting
"au FileType svg setlocal tabstop=8 softtabstop=2 shiftwidth=2 noexpandtab autoindent
"au BufNewFile *.svg 0r ~/Templates/skeleton.svg | 2
lua << EOF
local autocmd = vim.api.nvim_create_autocmd
local setlocal = vim.opt_local
local set = vim.opt
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
EOF

""" Plugin Settings
""
"" Copilot
"function! ToggleCopilot()
"	if copilot#Enabled()
"		Copilot disable
"	else
"		Copilot enable
"	endif
"	Copilot status
"endfunction
"inoremap <F1> <Esc>:call ToggleCopilot()<CR>a
"nnoremap <F1> :call ToggleCopilot()<CR>
"
"" Simplenote
"source $HOME/.config/vim/simplenoterc.vim
"
"" SuperCollider
"au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd set filetype=supercollider
"au Filetype supercollider packadd scvim
" let g:sclangTerm = "foot"
"let g:sclangTerm = "st"
"let g:scFlash = 1
lua << EOF
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
local map = vim.keymap.set
map({'i', 'n'}, '<F1>', function()
	ToggleCopilot()
	end, { desc = 'Toggle Copilot On/Off', silent = false })

-- nvim-lastplace
--lua require'nvim-lastplace'.setup{}
require'nvim-lastplace'.setup {
    lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
    lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
    lastplace_open_folds = true
}

-- Simplenote
local simplenoterc = os.getenv("HOME") .. "/.config/vim/simplenoterc.vim"
vim.cmd.source(simplenoterc)

-- SuperCollider
local autocmd = vim.api.nvim_create_autocmd
autocmd({"BufEnter", "BufWinEnter", "BufNewFile", "BufRead"}, {
	desc = "Set filetype to supercollider when opening .sc or .scd files",
	pattern = {"*.sc", "*.scd"},
	callback = function()
		vim.o.filetype = "supercollider"
	end,
})
vim.g.sclangTerm = "foot"
vim.g.scFlash = 1
EOF
