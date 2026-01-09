---[[ ~/.config/nvim/after/plugin/time_based_theme.lua

-- Set colorscheme (and/or background color) based on time of the day

vim.g.manual_colorscheme = nil

if vim.g.colorscheme_timer == nil then
  vim.g.colorscheme_timer = true

  local function update_colorscheme()
    if vim.g.manual_colorscheme then
      return
    end

    local hour = tonumber(os.date('%H%M'))
    if hour < 1600 and hour > 0730 then
      vim.cmd('colorscheme PaperColorSlimLight')
      vim.opt.background = 'light'
    else
      vim.cmd('colorscheme PaperColorSlim')
      vim.opt.background = 'dark'
    end

    vim.defer_fn(update_colorscheme, 5*60*1000)
  end

  update_colorscheme()
end
--]]
