---[[ ~/.config/nvim/after/plugin/import_gsettings_on_save.lua

-- Execute the import-gsettings script when the 'gtk-3.0/settings.ini' file is saved

local import_gsettings_on_save = vim.api.nvim_create_augroup('ImportGSettingsOnSave', { clear = true })

vim.api.nvim_create_autocmd('BufWritePost', {
  desc = "Execute the import-gsettings script when the 'gtk-3.0/settings.ini' file is saved",
  group = import_gsettings_on_save,
  pattern = os.getenv('HOME') .. '/.config/gtk-3.0/settings.ini',
  callback = function()
    os.execute('import-gsettings &>/dev/null')
  end,
})

--]]
