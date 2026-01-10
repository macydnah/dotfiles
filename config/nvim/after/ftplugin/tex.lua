---[[ ~/.config/nvim/after/ftplugin/tex.lua

-- TEX FileType settings ts=8 sts=4 sw=4 et ai wrap linebreak smoothscroll spell

vim.g.tex_flavor = 'latex'
vim.g.tex_comment_nospell = 1

vim.opt_local.tabstop = 8
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4

vim.opt_local.expandtab = true
vim.opt_local.autoindent = true

vim.opt_local.spell = true

vim.opt_local.cursorline = true
vim.opt_local.cursorcolumn = false
vim.opt_local.list = true

vim.opt_local.wrap = true
vim.opt_local.cursorlineopt = 'screenline'
vim.opt_local.smoothscroll = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true

local bufnr = vim.api.nvim_get_current_buf()

---Set a keymap for the current buffer.
---@param mode string|string[] Mode "short-name" (see nvim_set_keymap()), or a list thereof.
---@param lhs string Left-hand side |{lhs}| of the mapping.
---@param desc string Description of the mapping.
---@param rhs string|function Right-hand side |{rhs}| of the mapping, can be a Lua function.
---@param opts table? Additional options for the mapping.
local function bufmap(mode, lhs, desc, rhs, opts)
  local defaults = { buffer = bufnr, desc = 'XML/HTML/XHTML: ' .. desc }
  opts = vim.tbl_extend('force', defaults, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

bufmap('n', 'j', "Move down a visual line for wrap enabled lines", 'gj')

bufmap('n', 'k', "Move up a visual line for wrap enabled lines", 'gk')
--]]
