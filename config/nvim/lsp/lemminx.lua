---@brief
---
--- https://github.com/eclipse/lemminx
--- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lemminx
--- https://github.com/eclipse-lemminx/lemminx/raw/refs/heads/main/docs/Configuration.md
---
--- The easiest way to install the server is to get a binary from https://github.com/redhat-developer/vscode-xml/releases and place it on your PATH.
---
--- NOTE to macOS users: Binaries from unidentified developers are blocked by default. If you trust the downloaded binary, run it once, cancel the prompt, then remove the binary from Gatekeeper quarantine with `xattr -d com.apple.quarantine lemminx`. It should now run without being blocked.


---@type vim.lsp.Config
return {
  cmd = { 'lemminx' },
  filetypes = { 'xml', 'xsd', 'xsl', 'xslt', 'svg' },
  root_markers = { '.git' },
  settings = {
    xml = {
      -- logs = {
      --   client = true,
      --   file = '/tmp/lsp4xml.log',
      -- },
      format = {
        enabled = true,
        splitAttributes = false,
        joinCDATALines = false,
        joinContentLines = false,
        joinCommentLines = false,
        formatComments = true,
        spaceBeforeEmptyCloseTag = true,
        -- insertSpaces = true,
        -- tabSize = 8,
      },
      capabilities = {
        formatting = true,
      },
      completion = {
        autoCloseTags = false,
      },
      useCache = true,
      validation = {
        enabled = true,
        schema = true,
        noGrammar = 'hint',
      },
    },
  },
}
