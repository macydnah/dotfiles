-- ~/.config/nvim/lua/plugins/nvim-treesitter.lua

require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'c',
    'css',
    'html',
    'json',
    'latex',
    'lua',
    'markdown',
    'markdown_inline',
    'python',
    'query',
    'rust',
    'supercollider',
    'toml',
    'vim',
    'vimdoc',
  },
  auto_install = false,
  ignore_install = { '' },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = { '' }
  },
  indent = {
    enable = false,
  },
}
