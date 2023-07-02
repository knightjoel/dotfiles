vim.g.barbar_auto_setup = false -- disable auto-setup

require'barbar'.setup {
  clickable = false,
}

require("user.core.keymaps").setup.barbar()
