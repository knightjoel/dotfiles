-- Override the colors that nightfly chooses for showing diffs.
-- In particular, the default 'DiffDelete' color sets a bg that has very low
-- contrast with the default fg color making it all but impossible to read the
-- text.
local custom_highlight = vim.api.nvim_create_augroup("CustomNightflyDiff", {})
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "nightfly",
  callback = function()
    local palette = require("nightfly").palette
    vim.api.nvim_set_hl(0, "DiffAdd", { fg = palette.green })
    -- You can also improve other diff highlights:
    vim.api.nvim_set_hl(0, "DiffDelete", { fg = palette.watermelon })
    vim.api.nvim_set_hl(0, "DiffChange", { fg = palette.regal_blue })
  end,
  group = custom_highlight,
})
vim.cmd("colorscheme nightfly")
