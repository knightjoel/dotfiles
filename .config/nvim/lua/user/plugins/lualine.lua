-- import lualine plugin safely
local status, lualine = pcall(require, "lualine")
if not status then
  return
end

-- configure lualine with modified theme
lualine.setup({
  options = {
    theme = 'ayu_dark',
    component_separators = { left = '', right = '|' },
  },
  sections = {
    lualine_c = {
      {
        'filename',
        path = 1,
      },
    }, 
  },
})
