---[[ ~/.config/nvim/after/ftplugin/html.lua

-- HTML FileType settings ts=8 sts=2 sw=2 noet ai wrap smoothscroll linebreak

vim.opt_local.tabstop = 8
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2

vim.opt_local.expandtab = false
vim.opt_local.autoindent = true

vim.opt_local.wrap = true
vim.opt_local.smoothscroll = true
vim.opt_local.linebreak = true

vim.keymap.set({''}, '<F12>', function()
  os.execute('firefox ' .. vim.fn.expand('%'))
end, { desc = 'Open current HTML file in Firefox', silent = true, buffer = true })

--]]
