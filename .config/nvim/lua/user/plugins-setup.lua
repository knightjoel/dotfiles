-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

-- add list of plugins to install
return packer.startup(function(use)
  -- packer can manage itself
  use("wbthomason/packer.nvim")

  -- color schemes
  --use("overcache/NeoSolarized")
  use { 'bluz71/vim-nightfly-colors', as = 'nightfly' }

  -- features
  use("romgrk/barbar.nvim") -- buffer bar
  use("numToStr/Comment.nvim")
  use({
    "lewis6991/gitsigns.nvim",
    tag = "v0.6"
  })
  use {
    "nvim-lualine/lualine.nvim", -- status line
    requires = { "nvim-tree/nvim-web-devicons", opt = true }
  }
  use("windwp/nvim-autopairs")  -- Pair up quotes, brackets, etc
  use("booperlv/nvim-gomove") -- Move blocks around
  use("tpope/vim-sensible")
  use("tpope/vim-surround")
  use {
    "nvim-telescope/telescope.nvim", branch = '0.1.x',
    requires = { {"nvim-lua/plenary.nvim"} }
  }
  use("christoomey/vim-tmux-navigator")
  use("nvim-tree/nvim-tree.lua")
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })
  -- autocompletion
  use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
  use("hrsh7th/cmp-buffer") -- source for text in buffer
  use("hrsh7th/cmp-emoji") -- source for emoji
  use("hrsh7th/cmp-path") -- source for file system paths
  use("hrsh7th/cmp-nvim-lsp-signature-help") -- function signatures
  use("hrsh7th/nvim-cmp") -- completion plugin
  -- snippets
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip") -- for autocompletion
  use("rafamadriz/friendly-snippets") -- library of snippets from the community

  -- support/dependencies
  use("nvim-tree/nvim-web-devicons")

  -- file types
  use("mfussenegger/nvim-ansible")
  use("hashivim/vim-terraform")

  -- LSP
  use("jose-elias-alvarez/null-ls.nvim")
  use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
  use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig
  use("neovim/nvim-lspconfig") -- easily configure language servers
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    requires = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  }) -- enhanced LSP UIs
  use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

  if packer_bootstrap then
    require("packer").sync()
  end
end)
