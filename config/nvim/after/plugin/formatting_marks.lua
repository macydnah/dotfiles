---[[ ~/.config/nvim/after/plugin/formatting_marks.lua

vim.opt.list = false

vim.opt.listchars = {
  -- eol = '↵',
  tab = '│ ',
  -- space = '·',
  -- multispace = '·',
  lead = '⎽',
  trail = '·',
  extends = '»',
  precedes = '«',
  nbsp = '⍽',
}

local group = vim.api.nvim_create_augroup('FormattingMarks', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  group = group,
  pattern = '*',
  callback = function()
    if vim.opt_local.expandtab:get() then
      local shiftwidth = vim.opt_local.shiftwidth:get()
      local spaces = string.rep(' ', shiftwidth - 1)
      vim.opt_local.listchars:append({ leadmultispace = '│' .. spaces })
    end
  end,
})

local CTRL_F10 = '<F34>'
vim.keymap.set({'n'}, CTRL_F10, function()
  if vim.opt_local.list:get() then
    vim.opt_local.list = false
    vim.opt_local.cursorcolumn = true
  else
    vim.opt_local.list = true
    vim.opt_local.cursorcolumn = false
  end
end, { desc = "Toggle formatting marks On/Off" })

--]]
