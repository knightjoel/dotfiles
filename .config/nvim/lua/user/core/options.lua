local opt = vim.opt

vim.g.mapleader = " " -- space

-- sane text files
opt.fileformat = "unix"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- sane editing
opt.copyindent = true
opt.background = "dark"
opt.colorcolumn = "88"
opt.cursorline = true -- highlight the current cursor line
opt.expandtab = true
opt.filetype = on
opt.formatoptions:append('n')  -- Recognize numbered lists
opt.formatoptions:append('r')  -- Insert current comment leader after hitting <enter>
opt.mouse = "n" -- Mouse only in normal mode
opt.number = true
opt.tabstop = 2
opt.termguicolors = true
opt.timeout = false
opt.title = true
opt.ttimeout = true
opt.scrolloff = 5  -- 5 lines of offset
opt.shiftwidth = 2
opt.softtabstop = 4

-- splits
opt.splitbelow = true
opt.splitright = true

-- netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_winsize = 30  -- 30%
