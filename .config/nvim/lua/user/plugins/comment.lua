-- import comment plugin safely
local setup, comment = pcall(require, "Comment")
if not setup then
  return
end

-- enable comment
comment.setup({
  toggler = {
    line = "gcl",  -- "Go comment line"
    block = "gcb", -- "Go comment block"
  }
})
