-- ~/.config/nvim/lua/plugins/nvim-treesitter.lua

require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'c',
    'css',
    'html',
    'java',
    'json',
    'jsonc',
    -- 'latex',
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
  auto_install = true,
  ignore_install = { '' },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = { 'tmux' }
  },
  indent = {
    enable = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
