---[[ ~/.config/nvim/after/plugin/filetype_drawio.lua

-- Map .drawio extension to xml filetype for syntax highlighting
vim.filetype.add({
  extension = {
    drawio = 'xml',
  },
})

--]]
