-- ~/.config/nvim/lua/lsp.lua

vim.lsp.enable({
  'clangd',
  'basedpyright',
  'jdtls',
  -- 'jedi_language_server',
  'lemminx',
  'lua-language-server',
  'rust-analyzer',
  'texlab',
})

vim.diagnostic.config({
  -- see :help vim.diagnostic.Opts
  underline = true,
  virtual_text = false,
  virtual_lines = { current_line = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
    linehl = {
      -- [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      -- [vim.diagnostic.severity.WARN] = 'WarningMsg',
      -- [vim.diagnostic.severity.INFO] = 'InfoMsg',
      -- [vim.diagnostic.severity.HINT] = 'HintMsg',
    },
    numhl = {
      -- [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      -- [vim.diagnostic.severity.WARN] = 'WarningMsg',
      -- [vim.diagnostic.severity.INFO] = 'InfoMsg',
      -- [vim.diagnostic.severity.HINT] = 'HintMsg',
    },
  },
  update_in_insert = false,
  severity_sort = true,
})

---[[ LSP features
local _g_lsp_features = vim.api.nvim_create_augroup('LspFeatures', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
  desc = "Enable LSP features according to client capabilities",
  group = _g_lsp_features,
  callback = function(event)

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if not client or client.name == 'GitHub Copilot' then
      return
    end

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end

    -- if client:supports_method('textDocument/documentHighlight') then
    --   vim.opt_local.updatetime = 100
    --   local _g_doc_hl = vim.api.nvim_create_augroup('LspDocumentHighlight', { clear = true })
    --   vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
    --     desc = "Highlight symbol under cursor",
    --     group = _g_doc_hl,
    --     buffer = event.buf,
    --     callback = function()
    --       vim.lsp.buf.document_highlight()
    --     end,
    --   })
    --   vim.api.nvim_create_autocmd('CursorMoved', {
    --     desc = "Clear symbol highlight",
    --     group = _g_doc_hl,
    --     buffer = event.buf,
    --     callback = function()
    --       vim.lsp.buf.clear_references()
    --     end,
    --   })
    -- end
  end,
}) --]]

---[[ LSP key mappings
local _g_lsp_keymaps = vim.api.nvim_create_augroup('LspKeymaps', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
  desc = "Set LSP key mappings",
  group = _g_lsp_keymaps,
  callback = function(event)

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if not client or client.name == 'GitHub Copilot' then
      return
    end

    ---Set a keymap for the current buffer.
    ---@param mode string|string[] Mode "short-name" (see nvim_set_keymap()), or a list thereof.
    ---@param lhs string Left-hand side |{lhs}| of the mapping.
    ---@param desc string Description of the mapping.
    ---@param rhs string|function Right-hand side |{rhs}| of the mapping, can be a Lua function.
    ---@param opts table? Additional options for the mapping.
    local function bufmap(mode, lhs, desc, rhs, opts)
      local defaults = { buffer = event.buf, desc = "LSP: " .. desc }
      opts = vim.tbl_extend('force', defaults, opts or {})
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    bufmap('n', 'gO', "Lists all symbols in the current document",
      function() vim.lsp.buf.document_symbol() end)

    bufmap('n', 'grt', "Jumps to the definition of the type symbol",
      function() vim.lsp.buf.type_definition() end)

    bufmap('n', 'gri', "Lists all the implementations for the symbol under the cursor",
      function() vim.lsp.buf.implementation() end)

    bufmap('n', 'grr', "Lists all the references to the symbol under the cursor",
      function() vim.lsp.buf.references() end)

    bufmap({'n','x'}, 'gra', "Selects a code action available at cursor position",
      function() vim.lsp.buf.code_action({ apply = false }) end)

    bufmap('n', 'grn', "Renames all references to the symbol under the cursor",
      function() vim.lsp.buf.rename() end)

    bufmap('n', 'K', "Displays hover information about the symbol under the cursor",
      function() vim.lsp.buf.hover() end)

    bufmap('n', 'grd', "Jumps to the definition of the symbol under the cursor",
      function() vim.lsp.buf.definition() end)

    bufmap('n', 'grD', "Jumps to the declaration of the symbol under the cursor",
      function() vim.lsp.buf.declaration() end)

    bufmap('n', 'grs', "Displays a function's signature information",
      function() vim.lsp.buf.signature_help() end)

  end,
}) --]]
