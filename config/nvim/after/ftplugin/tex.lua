---[[ ~/.config/nvim/after/ftplugin/tex.lua

-- TEX FileType settings ts=8 sts=8 sw=8 noet noai wrap linebreak smoothscroll spell

vim.g.tex_flavor = 'latex'
vim.g.tex_comment_nospell = 1

vim.opt_local.tabstop = 8
vim.opt_local.softtabstop = 8
vim.opt_local.shiftwidth = 8

vim.opt_local.expandtab = false
vim.opt_local.autoindent = false

vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.smoothscroll = true

vim.opt_local.spell = true

vim.opt_local.cursorline = true
vim.opt_local.cursorcolumn = false
vim.opt_local.list = true

vim.api.nvim_create_autocmd({'BufWinEnter', 'WinEnter'}, {
  desc = "Set background color based on time of the day",
  group = vim.api.nvim_create_augroup('AutoLightDarkBackground', { clear = true }),
  pattern = '*',
  callback = function()
    local hour = tonumber(os.date('%H%M'))
    if hour < 1500 and hour > 0730 then
      vim.cmd.colorscheme('lunaperche')
      vim.opt.background = 'light'
    else
      vim.cmd.colorscheme('PaperColor')
      vim.opt.background = 'dark'
    end
  end,
})

--]]
