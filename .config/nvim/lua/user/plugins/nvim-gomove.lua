local status, move = pcall(require, "gomove")
if not status then
  return
end

move.setup({
  map_defaults = true -- load default key mappings
})
