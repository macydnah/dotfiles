-- ~/.config/nvim/lua/plugins/copilot.lua

vim.g.copilot_enabled = false

local function ToggleCopilot()
  -- https://github.com/neovim/neovim/issues/26983
  -- 0 and 1 are both truthy in Lua, can't check `if vim.cmd('Copilot status') ...`
  if vim.fn['copilot#Enabled']() == 1 then
    vim.cmd('Copilot disable')
  else
    vim.cmd('Copilot enable')
  end
  vim.cmd('Copilot status')
end

local group = vim.api.nvim_create_augroup('CopilotKeymaps', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  desc = "Copilot key mappings",
  group = group,
  callback = function(ev)

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client == nil then
      return
    end
    if client.name == 'GitHub Copilot' then

      local SHIFT_F1 = '<F13>'
      vim.keymap.set({'i', 'n'}, SHIFT_F1, function() ToggleCopilot() end,
        { buffer = true, desc = "Copilot: Toggle On/Off" })

      vim.keymap.set({'i'}, '<C-f>', '<Plug>(copilot-accept-line)',
        { buffer = true, desc = "Copilot: Accept line" })

      vim.keymap.set({'i'}, '<M-f>', '<Plug>(copilot-accept-word)',
        { buffer = true, desc = "Copilot: Accept word" })
    end

  end
})
