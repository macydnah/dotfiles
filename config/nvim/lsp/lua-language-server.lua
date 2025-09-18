---@type vim.lsp.Config
---@brief
---
--- https://luals.github.io/wiki/settings/
--- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls

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
        autoRequire = true,
        callSnippet = 'Disable',
        displayContext = 20,
        enable = true,
        keywordSnippet = 'Both',
        postfix = '@',
        requireSeparator = '.',
        showParams = true,
        showWord = 'Fallback',
        workspaceWord = true,
      },
      diagnostics = {
        enable = true,
      },
      format = {
        enable = true,
      },
      hint = {
        arrayIndex = 'Auto',
        enable = true,
        paramName = 'Disable',
        setType = false,
      },
      hover = {
        enable = true,
      },
      runtime = {
        path = { 'lua/?.lua', 'lua/?/init.lua' },
      },
      workspace = {
        checkThirdParty = 'Disable',
        --[[
        library = {
          vim.env.VIMRUNTIME,
          -- NOTE: this below is a lot slower and will cause issues
          -- when working on your own configuration.
          -- See https://github.com/neovim/nvim-lspconfig/issues/3189
          -- vim.api.nvim_get_runtime_file('', true),
        },
        --]]
      },
    },
  },
}
