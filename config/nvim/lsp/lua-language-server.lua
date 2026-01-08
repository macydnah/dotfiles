---@brief
---
--- https://luals.github.io/wiki/settings/
--- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
--- https://raw.githubusercontent.com/sumneko/vscode-lua/master/setting/schema.json

---@type vim.lsp.Config
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
        enable = true,
        autoRequire = true,
        callSnippet = 'Replace',
        displayContext = 10,
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
        enable = true,
        arrayIndex = 'Auto',
        paramName = 'Disable',
        setType = false,
      },
      hover = {
        enable = true,
      },
      runtime = {
        path = {
          -- 'lua/?.lua',
          -- 'lua/?/init.lua'
          '?.lua',
          '?/init.lua'
        },
      },
      semantic = {
        enable = false,
        annotation = true,
        keyword = false,
        variable = true,
      },
      signatureHelp = {
        enable = true,
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
  -- on_init = function(client)
  --   client.server_capabilities.semanticTokensProvider = nil
  -- end,
}
