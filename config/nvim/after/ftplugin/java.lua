---[[ ~/.config/nvim/after/ftplugin/java.lua

-- JAVA FileType settings ts=8 sts=4 sw=4 et ai

vim.opt_local.tabstop = 8
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4

vim.opt_local.expandtab = true
vim.opt_local.autoindent = true

local _group = vim.api.nvim_create_augroup('JdtlsHighlightOverrides', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
  desc = "Link @type.builtin.java to Type highlight group",
  group = _group,
  callback = function()
    vim.api.nvim_set_hl(0, "@type.builtin.java", { link = "Type" })
  end,
})

--]]
