-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
  require("user.core.keymaps").setup.lsp_config(bufnr)
end


-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Set default root markers for all clients
vim.lsp.config("*", {
  -- used to enable autocompletion (assign to every lsp server config)
  capabilities = cmp_nvim_lsp.default_capabilities(),
  root_markers = { ".git" },
  on_attach = on_attach,
})

-- Configure servers (alphabetical order).
vim.lsp.config("yaml.ansible", {
  cmd = { "ansible-language-server", "--stdio" },
})

vim.lsp.config("pyright", {
  cmd = { "pyright" }
})

vim.lsp.config("yamlls", {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml.cloudformation" },
  settings = {
    yaml = {
      format = {
        enable = true,
      },
      hover = true,
      completion = true,
      validate = true,
      customTags = {
        -- For CloudFormation
        "!fn",
        "!And",
        "!If",
        "!If sequence",
        "!Not",
        "!Equals",
        "!Equals sequence",
        "!Or",
        "!FindInMap sequence",
        "!Base64",
        "!Cidr",
        "!Ref",
        "!Ref Scalar",
        "!Sub",
        "!GetAtt",
        "!GetAZs",
        "!ImportValue",
        "!Select",
        "!Split",
        "!Join sequence"
      },
      schemas = {
        ["https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json"] = {
          "cloudformation.yml",
          "cloudformation.yaml",
          "*.cf.yml",
          "cf.yaml",
          "*.yaml",
        },
      },
      redhat = {
        telemetry = {
          enabled = false
        },
      },
    },
  },
})

