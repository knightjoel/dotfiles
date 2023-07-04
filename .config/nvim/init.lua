require("user.core.filetype")

require("user.plugins-setup")

require("user.core.colors")
require("user.core.options")

require("user.plugins.autopairs")
require("user.plugins.barbar")
require("user.plugins.comment")
require("user.plugins.gitsigns")
require("user.plugins.lualine")
require("user.plugins.telescope")
require("user.plugins.treesitter")
require("user.plugins.nvim-cmp")
require("user.plugins.nvim-gomove")
require("user.plugins.nvim-tree")

-- after plugins are loaded.
require("user.core.keymaps").setup.standard()

require("user.plugins.lsp.mason")
require("user.plugins.lsp.null-ls")
require("user.plugins.lsp.lspsaga")
require("user.plugins.lsp.lspconfig")
