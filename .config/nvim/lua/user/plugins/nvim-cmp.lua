-- import nvim-cmp plugin safely
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
  return
end

-- import luasnip plugin safely
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
  return
end

-- import lspkind plugin safely
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
  return
end

-- load vs-code like snippets from plugins (e.g. friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()

-- Only load the CloudFormation snippets if the filetype is appropriate.
local cfn_snippets_dir = "~/.local/share/nvim/vscode-cloudformation-snippets"
if vim.fn.isdirectory(cfn_snippets_dir) then
  vim.api.nvim_create_autocmd({"BufNewFile", "BufRead", "FileType"}, {
    callback = function()
      if vim.o.filetype == "yaml.cloudformation" then
        require("luasnip.loaders.from_vscode").lazy_load({
          paths = { cfn_snippets_dir }
        })
      end
    end
  })
end

vim.opt.completeopt = "menu,menuone,noselect"

luasnip.config.set_config({
  updateevents = "TextChanged,TextChangedI", -- Update dynamic snippets while typing
  history = true -- Allows jumping back into the snippet after leaving it
})
require("user.core.keymaps").setup.luasnip()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert(require("user.core.keymaps").config.nvim_cmp(cmp)),
  -- sources for autocompletion
  sources = cmp.config.sources({
    { name = "nvim_lsp" }, -- lsp
    { name = 'nvim_lsp_signature_help' }, -- function signatures
    { name = "luasnip" }, -- snippets
    { name = "buffer" }, -- text within current buffer
    { name = "emoji" }, -- emoji
    --{ name = "path" }, -- file system paths
  }),
  -- configure lspkind for vs-code like icons
  formatting = {
    format = lspkind.cmp_format({
      maxwidth = 50,
      ellipsis_char = "...",
    }),
  },
})

