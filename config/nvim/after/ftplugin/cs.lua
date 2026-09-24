---[[ ~/.config/nvim/after/ftplugin/cs.lua

-- C# FileType settings  ts=8 sts=4 sw=4 et ai

vim.opt_local.tabstop = 8
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4

vim.opt_local.expandtab = true
vim.opt_local.autoindent = true

-- XML doc comments (///)
-- colorscheme mapea colores de @comment.documentation igual a los de @comment
-- únicamente agregamos itálicas
vim.api.nvim_set_hl(0, '@comment.documentation', { italic = true })

--]]
