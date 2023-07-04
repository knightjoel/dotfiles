-- import plugin safely
local status, null_ls = pcall(require, "null-ls")
if not status then
  return
end

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.cfn_lint.with({
      filetypes = { "yaml.cloudformation", "json.cloudformation" }
    }),
  }
})
