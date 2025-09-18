---[[ ~/.config/nvim/after/ftplugin/supercollider.lua

vim.g.sclangTerm = 'footclient --title sclang'
vim.g.scFlash = 1

-- SUPERCOLLIDER FileType settings ts=8 sts=4 sw=4 noet ai

vim.opt_local.tabstop = 8
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4

vim.opt_local.expandtab = false
vim.opt_local.autoindent = true

vim.keymap.set({''}, '<s-enter>', vim.fn['SClang_line'],
  { desc = "Send line to SuperCollider", silent = true, buffer = true })

vim.keymap.set({''}, '<c-enter>', vim.fn['SClang_block'],
  { desc = "Send block to SuperCollider", silent = true, buffer = true })

vim.keymap.set({''}, '<c-.>', vim.fn['SClangHardstop'],
  { desc = "Hard stop SuperCollider", silent = true, buffer = true })

--]]
