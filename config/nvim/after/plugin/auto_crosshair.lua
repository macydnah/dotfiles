---[[ ~/.config/nvim/after/plugin/auto_crosshair.lua

-- Highlight the current cursor coordinate within the active window (crosshair)

---Filetypes where cursorcolumn should be disabled
---@type string[]
local no_cursorcolumn_filetypes = {
  'gitcommit',
  'help',
  'html',
  'markdown',
  'plaintex',
  'qf',
  'tex',
  'text',
  'xhtml',
  'xml',
}

---@return boolean true In case cursorcolumn is needed in the current buffer; false otherwise
local function __need_cursorcolumn()
  if vim.opt_local.list:get() then
    return false
  end

  for _, blacklisted in ipairs(no_cursorcolumn_filetypes) do
    if vim.opt_local.filetype:get() == blacklisted then
      return false
    end
  end

  return true
end

---Enable cursorline (and cursorcolumn if needed) in the current buffer
local function __crosshair_on()
  vim.opt_local.cursorline = true

  if __need_cursorcolumn() then
    vim.opt_local.cursorcolumn = true
  else
    vim.opt_local.cursorcolumn = false
  end
end

---Disable cursorline and cursorcolumn in the current buffer
local function __crosshair_off()
  vim.opt_local.cursorline = false
  vim.opt_local.cursorcolumn = false
end

---Highlight the current cursor coordinate within the active window (crosshair)
---@param enable boolean? true to enable; false to disable; defaults to true
local function auto_crosshair(enable)
  if enable == false then
    __crosshair_off()
  else
    __crosshair_on()
  end
end

local __group = vim.api.nvim_create_augroup('AutoCrossHair', { clear = true })
vim.api.nvim_create_autocmd({'BufWinEnter', 'FocusGained', 'InsertLeave', 'WinEnter'}, {
  desc = "Enable cursorline and cursorcolumn in the current buffer/window",
  group = __group,
  pattern = '*',
  callback = function()
    auto_crosshair()
  end,
})
vim.api.nvim_create_autocmd({'FocusLost', 'WinLeave'}, {
  desc = "Disable cursorline and cursorcolumn when leaving the current window",
  group = __group,
  pattern = '*',
  callback = function()
    auto_crosshair(false)
  end,
})
-- vim.api.nvim_create_autocmd('InsertEnter', {
--   desc = "Disable cursorcolumn when entering insert mode",
--   group = __group,
--   pattern = '*',
--   callback = function()
--     vim.opt_local.cursorcolumn = false
--   end,
-- })
--]]
