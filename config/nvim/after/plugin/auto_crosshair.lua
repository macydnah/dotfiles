---[[ ~/.config/nvim/after/plugin/auto_crosshair.lua

-- Highlight the current cursor coordinate within the active window (crosshair)

local function auto_crosshair()
  vim.opt_local.cursorline = true
  vim.opt_local.cursorcolumn = true

  if vim.opt.background:get() == 'light' then
    vim.cmd.highlight({ 'CursorLine', 'guifg=NONE', 'guibg=#d4d4d4', 'gui=bold,italic' })
    vim.cmd.highlight({ 'CursorColumn', 'guifg=NONE', 'guibg=#d4d4d4', 'gui=NONE' })
  else
    vim.cmd.highlight({ 'CursorLine', 'guifg=NONE', 'guibg=#303030', 'gui=bold,italic' })
    vim.cmd.highlight({ 'CursorColumn', 'guifg=NONE', 'guibg=#303030', 'gui=NONE' })
  end

end

local group = vim.api.nvim_create_augroup('AutoCrossHair', { clear = true })

vim.api.nvim_create_autocmd({'BufWinEnter', 'WinEnter'}, {
  desc = "Enable cursorline and cursorcolumn in the current buffer/window",
  group = group,
  pattern = '*',
  callback = function()
    auto_crosshair()
  end,
})
vim.api.nvim_create_autocmd('WinLeave', {
  desc = "Disable cursorline and cursorcolumn when leaving the current window",
  group = group,
  pattern = '*',
  callback = function()
    vim.opt_local.cursorline = false
    vim.opt_local.cursorcolumn = false
  end,
})
vim.api.nvim_create_autocmd('InsertEnter', {
  desc = "Disable italic cursorline when entering insert mode",
  group = group,
  pattern = '*',
  callback = function()
    vim.cmd.highlight({ 'CursorLine', 'gui=NONE' })
  end,
})
vim.api.nvim_create_autocmd('InsertLeave', {
  desc = "Enable cursorline and cursorcolumn when leaving insert mode",
  group = group,
  pattern = '*',
  callback = function()
    auto_crosshair()
  end,
})

--]]
