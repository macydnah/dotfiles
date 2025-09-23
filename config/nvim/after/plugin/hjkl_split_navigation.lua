---[[ ~/.config/nvim/after/plugin/hjkl_split_navigation.lua

-- Use ctrl-[hjkl] to select the active split

-- http://vim.wikia.com/wiki/Switch_between_Vim_window_splits_easily
-- https://stackoverflow.com/questions/6053301/easier-way-to-navigate-between-vim-split-panes

vim.keymap.set({'n'}, '<C-h>', function() vim.cmd('wincmd h') end,
  { desc = "Move cursor to Nth window left of current one", silent = true })

vim.keymap.set({'n'}, '<C-j>', function() vim.cmd('wincmd j') end,
  { desc = "Move cursor to Nth window below current one", silent = true })

vim.keymap.set({'n'}, '<C-k>', function() vim.cmd('wincmd k') end,
  { desc = "Move cursor to Nth window above current one", silent = true })

vim.keymap.set({'n'}, '<C-l>', function() vim.cmd('wincmd l') end,
  { desc = "Move cursor to Nth window right of current one", silent = true })

--]]
