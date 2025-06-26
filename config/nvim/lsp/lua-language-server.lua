---@type vim.lsp.Config
--
-- https://luals.github.io/wiki/settings/

return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
        displayContext = 0,
        enable = true,
        keywordSnippet = 'Both',
      },
      diagnostic = {
        enable = true,
      },
      format = {
        enable = true,
      },
      hints = {
        enable = true,
      },
      hover = {
        enable = true,
      },
      runtime = {
        path = { 'lua/?.lua', 'lua/?/init.lua' },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- NOTE: this below is a lot slower and will cause issues
          -- when working on your own configuration.
          -- See https://github.com/neovim/nvim-lspconfig/issues/3189
          -- vim.api.nvim_get_runtime_file('', true),
        },
      },
    },
  },
}
