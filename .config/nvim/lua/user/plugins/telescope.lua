local status, telescope = pcall(require, "telescope")
if not status then
  return
end

local status, actions = pcall(require, "telescope.actions")
if not status then
  return
end

telescope.setup({
  defaults = {
    mappings = {
      i = {
        -- c-j moves down in the picker
        ["<c-j>"] = {
          actions.move_selection_next, type = "action",
            opts = { nowait = true, silent = true }
        },                                                        
        -- c-k moves up in the picker
        ["<c-k>"] = {
          actions.move_selection_previous, type = "action",
            opts = { nowait = true, silent = true }
        },                                                        
      }
    }
  }
})

require("user.core.keymaps").setup.telescope()
