---[[ ~/.config/nvim/after/ftplugin/text.lua

-- TXT FileType settings ts=8 sts=8 sw=8 noet ai wrap linebreak smoothscroll spell spelllang=es

vim.opt_local.tabstop = 8
vim.opt_local.softtabstop = 8
vim.opt_local.shiftwidth = 8

vim.opt_local.expandtab = false
vim.opt_local.autoindent = true

vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.smoothscroll = true

vim.opt_local.spell = true
vim.opt_local.spelllang = { 'es' }

vim.opt_local.cursorline = true
vim.opt_local.cursorcolumn = false

--]]
