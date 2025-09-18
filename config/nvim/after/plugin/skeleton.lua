---[[ ~/.config/nvim/after/plugin/skeleton.lua

-- Insert a template in buffer when a editing a new file
-- that has a skeleton template in ~/Templates (e.g. ~/Templates/skeleton.sh)

local enable_filetype_skeleton = {
  'html',
  'xml',
  'sh',
  'svg',
}

local group = vim.api.nvim_create_augroup('FileTypeSkeleton', { clear = true })

local function insert_skeleton(filetype)
  vim.api.nvim_create_autocmd('BufNewFile', {
    desc = "Insert " .. filetype .. " skeleton template",
    group = group,
    pattern = '*.' .. filetype,
    callback = function()
      local dir = os.getenv('HOME') .. '/Templates/skeleton' .. '.'
      vim.cmd('0r ' .. dir .. filetype)
    end,
  })
end

for _, filetype in ipairs(enable_filetype_skeleton) do
  insert_skeleton(filetype)
end

--]]
