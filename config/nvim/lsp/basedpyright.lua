---@brief
---
--- https://detachhead.github.io/basedpyright
---
--- `basedpyright`, a static type checker and language server for python
---
--- https://docs.basedpyright.com/latest/configuration/language-server-settings/
---
--- https://github.com/neovim/nvim-lspconfig/raw/refs/heads/master/lsp/basedpyright.lua

local function set_python_path(command)
  local path = command.args
  local clients = vim.lsp.get_clients {
    bufnr = vim.api.nvim_get_current_buf(),
    name = 'basedpyright',
  }
  for _, client in ipairs(clients) do
    if client.settings then
      ---@diagnostic disable-next-line: param-type-mismatch
      client.settings.python = vim.tbl_deep_extend('force', client.settings.python or {}, { pythonPath = path })
    else
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
    end
    client:notify('workspace/didChangeConfiguration', { settings = nil })
  end
end

---@type vim.lsp.Config
return {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    'pyrightconfig.json',
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },
  ---@type lspconfig.settings.basedpyright
  settings = {
    python = {
      pythonPath = '/usr/bin/python',
    },
    basedpyright = {
      disableLanguageServices = false,
      disableOrganizeImports = false,
      disableTaggedHints = false,
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = 'openFilesOnly',
        -- Explicitly setting `basedpyright.analysis.useLibraryCodeForTypes` is **discouraged** by the official docs.
        -- Because it will override per-project configurations like `pyproject.toml`.
        -- If left unset, its default value is `true`, and it can be correctly overridden by project config files.
        logLevel = 'Information',
        inlayHints = {
          variableTypes = false,
          callArgumentNames = false,
          callArgumentNamesMatching = false,
          functionReturnTypes = true,
          genericTypes = true,
        },
        useTypingExtensions = false, -- https://docs.basedpyright.com/latest/benefits-over-pyright/language-server-improvements/#autocomplete-improvements
        autoFormatStrings = false, -- https://docs.basedpyright.com/latest/benefits-over-pyright/pylance-features/#automatic-conversion-to-f-string-when-typing-inside-a-string
        baselineMode = 'auto', -- https://docs.basedpyright.com/latest/benefits-over-pyright/baseline/
      },
    },
  },
  on_init = function(client)
    -- tell the client there are no semantic tokens
    client.server_capabilities.semanticTokensProvider = nil
  end,
  on_attach = function(client, bufnr)
    -- tell the client to enable its inlay hints
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

    -- LSP Util user commands
    vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightOrganizeImports', function()
      local params = {
        command = 'basedpyright.organizeimports',
        arguments = { vim.uri_from_bufnr(bufnr) },
      }
      -- Using client.request() directly because "basedpyright.organizeimports" is private
      -- (not advertised via capabilities), which client:exec_cmd() refuses to call.
      -- https://github.com/neovim/neovim/blob/c333d64663d3b6e0dd9aa440e433d346af4a3d81/runtime/lua/vim/lsp/client.lua#L1024-L1030
      ---@diagnostic disable-next-line: param-type-mismatch
      client.request('workspace/executeCommand', params, nil, bufnr)
    end, {
      desc = 'Organize Imports',
    })

    vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightSetPythonPath', set_python_path, {
      desc = 'Reconfigure basedpyright with the provided python path',
      nargs = 1,
      complete = 'file',
    })
  end,
}
