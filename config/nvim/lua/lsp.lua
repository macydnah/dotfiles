-- ~/.config/nvim/lua/lsp.lua

vim.lsp.enable({
  'clangd',
  'jdtls',
  'jedi_language_server',
  'lemminx',
  'lua-language-server',
  'rust-analyzer',
  'texlab',
})

---[[ LSP features
local lsp_features = vim.api.nvim_create_augroup('LSPFeatures', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
  desc = "Enable LSP features according to client capabilities",
  group = lsp_features,
  callback = function(ev)

    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client == nil or client.name == 'GitHub Copilot' then
      return
    end

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    -- if client:supports_method('textDocument/diagnostic') then
    if client:supports_method('textDocument/publishDiagnostics') then
      vim.diagnostic.config({
        -- see :help vim.diagnostic.Opts
        underline = true,
        virtual_text = false,
        virtual_lines = { current_line = true },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN] = '▲',
            [vim.diagnostic.severity.HINT] = '⚑',
            [vim.diagnostic.severity.INFO] = '»',
          },
          linehl = {
            -- [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
            -- [vim.diagnostic.severity.WARN] = 'WarningMsg',
            -- [vim.diagnostic.severity.HINT] = 'HintMsg',
            -- [vim.diagnostic.severity.INFO] = 'InfoMsg',
          },
          numhl = {
            -- [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
            -- [vim.diagnostic.severity.WARN] = 'WarningMsg',
            -- [vim.diagnostic.severity.HINT] = 'HintMsg',
            -- [vim.diagnostic.severity.INFO] = 'InfoMsg',
          },
        },
        update_in_insert = true,
        severity_sort = true,
      })
    end
  end,
}) --]]

---[[ LSP key mappings
local lsp_keymaps = vim.api.nvim_create_augroup('LSPKeymaps', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
  desc = "LSP key mappings",
  group = lsp_keymaps,
  callback = function(ev)

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client == nil or client.name == 'GitHub Copilot' then
      return
    end

    local bufmap = function(mode, lhs, rhs, desc)
      local opts = { buffer = ev.buf, desc = 'LSP: ' .. desc }
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    bufmap('n', 'K', function() vim.lsp.buf.hover() end,
      "Displays hover information about the symbol under the cursor")

    bufmap('n', 'gd', function() vim.lsp.buf.definition() end,
      "Jump to the definition")

    bufmap('n', 'gD', function() vim.lsp.buf.declaration() end,
      "Jump to declaration")

    bufmap('n', 'gi', function() vim.lsp.buf.implementation() end,
      "Lists all the implementations for the symbol under the cursor")

    bufmap('n', 'go', function() vim.lsp.buf.type_definition() end,
      "Jumps to the definition of the type symbol")

    bufmap('n', 'gr', function() vim.lsp.buf.references() end,
      "Lists all the references")

    bufmap('n', 'gs', function() vim.lsp.buf.signature_help() end,
      "Displays a function's signature information")

    bufmap('n', '<F2>', function() vim.lsp.buf.rename() end,
      "Renames all references to the symbol under the cursor")

    bufmap('n', '<F4>', function() vim.lsp.buf.code_action() end,
      "Selects a code action available at the current cursor position")

    bufmap('n', 'gl', function() vim.diagnostic.open_float() end,
      "Show diagnostics in a floating window")

  end,

}) --]]
