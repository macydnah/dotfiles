---[[ ~/.config/nvim/after/ftplugin/html.lua

-- XML/HTML/XHTML FileType settings
--
-- XML FileType settings ts=8 sts=2 sw=2 et ai cursorline
--
-- HTML/XHTML FileType settings ts=8 sts=2 sw=2 et ai wrap smoothscroll linebreak breakindent spell

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

-- Common settings for XML/HTML/XHTML
vim.opt_local.tabstop = 8
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2

vim.opt_local.expandtab = true
vim.opt_local.autoindent = true

vim.opt_local.cursorline = true
vim.opt_local.cursorcolumn = false

require('nvim-ts-autotag').setup()

bufmap({''}, '<F12>', "Open current file in Firefox",
  function() os.execute('firefox ' .. vim.fn.expand('%')) end, { silent = true })

-- HTML/XHTML specific settings
local ft = vim.bo.filetype
if ft == 'html' or ft == 'xhtml' then
  vim.opt_local.wrap = true
  vim.opt_local.cursorlineopt = 'screenline'
  vim.opt_local.smoothscroll = true
  vim.opt_local.linebreak = true
  vim.opt_local.breakindent = true

  vim.opt_local.spell = true

  local __group_fix_html_ts_none = vim.api.nvim_create_augroup('FIX_HTML_TS_NONE', { clear = false })
  vim.api.nvim_create_autocmd({ 'BufEnter', 'ColorScheme' }, {
    group = __group_fix_html_ts_none,
    buffer = bufnr,
    callback = function()
      local ns = vim.api.nvim_get_namespaces()['nvim.treesitter.highlighter']
      if not ns then
        return
      end
      vim.api.nvim_set_hl_ns(ns)
      vim.api.nvim_set_hl(ns, '@none.html', { link = 'NONE', force = true })
    end,
  })

  bufmap('n', 'j', "Move down a visual line for wrap enabled lines", 'gj')
  bufmap('n', 'k', "Move up a visual line for wrap enabled lines", 'gk')
end
--]]
