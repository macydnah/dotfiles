-- ~/.config/nvim/lua/plugins/nvim-treesitter.lua

-- How to migrate from master to main?
-- https://github.com/nvim-treesitter/nvim-treesitter/discussions/7927

local languages = { -- {{{
  'bash',
  'c_sharp',
  'c',
  'cmake',
  'cpp',
  'css',
  'csv',
  'diff',
  'fish',
  'git_config',
  'gitcommit',
  'gitignore',
  'html',
  'java',
  'javadoc',
  'javascript',
  'jsdoc',
  'json', -- también cubre jsonc
  'kconfig',
  -- 'latex',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'regex',
  'rust',
  'ssh_config',
  'supercollider',
  'sql',
  'toml',
  'vim',
  'vimdoc',
  'xml',
  'xresources',
  'yaml',
} -- }}}

-- Pre-instalar parsers (no-op si ya están instalados)
require('nvim-treesitter').install(languages)

-- https://github.com/nvim-treesitter/nvim-treesitter/discussions/8546
-- Enable treesitter highlighting for all filetypes that have an installed parser.
-- pcall() gracefully skips UI/filetype buffers (fzf-lua, telescope, oil.nvim, etc.)
-- that lack a parser, avoiding hard errors when vim.treesitter.start() cannot
-- create a parser for the buffer.
local _group = vim.api.nvim_create_augroup('NvimTreesitter', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  desc = "Enable treesitter highlighting for filetypes with an installed parser",
  group = _group,
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if not lang or lang == '' then
      return
    end
    pcall(vim.treesitter.start, args.buf, lang)
  end,
})
