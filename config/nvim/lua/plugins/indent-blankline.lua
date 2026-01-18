-- ~/.config/nvim/lua/plugins/indent-blankline.lua

require('ibl').setup {
  enabled = true,
  indent = {
    -- char = '│',
    char = '┊',
    highlight = { 'Whitespace' },
    smart_indent_cap = true,
    priority = 1,
  },
  whitespace = {
    highlight = { 'Whitespace' },
    remove_blankline_trail = true,
  },
  scope = {
    enabled = false,
    show_start = false,
    show_end = false,
    injected_languages = false,
  },
}

-- local CTRL_F10 = '<F34>'
-- local SHIFT_F10 = '<F22>'
local CTRL_SHIFT_F10 = '<F46>'
vim.keymap.set({'n'}, CTRL_SHIFT_F10, function()
    vim.cmd('IBLToggle')
end, { desc = "Toggle identation lines On/Off" })
