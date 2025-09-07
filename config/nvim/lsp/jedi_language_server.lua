---@brief
---
--- https://github.com/pappasam/jedi-language-server
---
--- `jedi-language-server`, a language server for Python, built on top of jedi
return {
  cmd = { 'jedi-language-server' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },
  settings = {
    initializationOptions = {
      markupKindPreferred = 'markdown',
      jediSettings = {
        autoImportModules = {},
        caseInsensitiveCompletion = true,
        debug = false,
      },
      codeAction = {
        nameExtractFunction = 'jls_extract_def',
        nameExtractVariable = 'jls_extract_var',
      },
      completion = {
        disableSnippets = false,
        resolveEagerly = false,
        ignorePatterns = {},
      },
      diagnostics = {
        enable = false,
        didOpen = true,
        didChange = true,
        didSave = true,
      },
      hover = {
        enable = true,
        disable = {
          class = { all = false, names = {}, fullNames = {} },
          ['function'] = { all = false, names = {}, fullNames = {} }, -- function is a reserved word
          instance = { all = false, names = {}, fullNames = {} },
          keyword = { all = false, names = {}, fullNames = {} },
          module = { all = false, names = {}, fullNames = {} },
          param = { all = false, names = {}, fullNames = {} },
          path = { all = false, names = {}, fullNames = {} },
          property = { all = false, names = {}, fullNames = {} },
          statement = { all = false, names = {}, fullNames = {} },
        },
      },
      workspace = {
        extraPaths = {},
        -- environmentPath = '',
        symbols = {
          ignoreFolders = { '.nox', '.tox', '.venv', '__pycache__', 'venv' },
          maxSymbols = 20,
        },
      },
      semanticTokens = {
        enable = false,
      },
    },
  },
}
