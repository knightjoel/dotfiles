local M = {}

local function map(mode, l, r, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, l, r, opts)
end

-- Tables which hold key mapping information in a format which the consuming
-- plugin expects to receive. The plugin configures the maps, using this config
-- as an input.
M.config = {
  nvim_cmp = function(cmp) 
    return {
      ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
      ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
      ["<C-e>"] = cmp.mapping.abort(), -- close completion window
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
    }
  end
}

-- Functions set key mappings
M.setup = {
  standard = function()
    -- reduce keystrokes :)
    map("n", ";", ":", { noremap = true })

    -- don't skip over wrapped lines when moving up/down
    map("n", "j", "gj")
    map("n", "<down>", "gj")
    map("n", "k", "gk")
    map("n", "<up>", "gk")

    -- turn off highlighted search results (in all modes)
    map("", "<Esc>", ":nohl<CR>")
    map("n", "<Leader>e", ":NvimTreeToggle<CR>")

    -- Better indentation/deindentation of code blocks
    map("v", "<", "<gv")
    map("v", ">", ">gv")

    -- split creation
    map("n", "<C-w>|", ":vsp<CR>")  -- vertical
    map("n", "<C-w>%", ":sp<CR>")   -- horizontal

    -- indent/unindent with tab/shift-tab
    map("n", "<Tab>", ">>")
    map("n", "<S-tab>", "<<")
    map("i", "<S-tab>", "<Esc><<i")
    map("v", "<Tab>", ">gv")
    map("v", "<S-tab>", "<gv")

    -- delete single character without copying into register
    map("n", "x", '"_x')

    -- increment/decrement numbers
    map("n", "<Leader>+", "<C-a>") -- increment
    map("n", "<Leader>-", "<C-x>") -- decrement
  end, -- standard

  barbar = function()
    -- Move to vpreious/next
    map("n", "<Leader>,", "<Cmd>BufferPrevious<CR>")
    map("n", "<Leader>.", "<Cmd>BufferNext<CR>")
    -- Re-order to previous/next
    map("n", "<Leader>[", "<Cmd>BufferMovePrevious<CR>")
    map("n", "<Leader>]", "<Cmd>BufferMoveNext<CR>")
    -- Goto buffer in position...
    map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>")
    map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>")
    map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>")
    map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>")
    map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>")
    map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>")
    map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>")
    map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>")
    map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>")
    map("n", "<A-0>", "<Cmd>BufferLast<CR>")
    -- Magic buffer-picking mode
    map("n", "<C-p>", "<Cmd>BufferPick<CR>")
    -- close buffer
    map("n", "<Leader>w", ":BufferClose<CR>")
  end, -- barbar

  gitsigns = function()
    local gs = package.loaded.gitsigns

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map('n', '<Leader>gb', function() gs.blame_line{full=true} end)

    map('n', '<Leader>gtb', gs.toggle_current_line_blame)
    map('n', '<Leader>gtd', gs.toggle_deleted)
  end, -- gitsigns

  lsp_config = function(bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    map("n", "<Leader>ld", "<Cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
    map("n", "<Leader>lgd", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- go to declaration
    map("n", "<Leader>lf", "<Cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
    map("n", "<Leader>lca", "<Cmd>Lspsaga code_action<CR>", opts) -- see available code actions
    map("n", "<Leader>lrn", "<Cmd>Lspsaga rename<CR>", opts) -- smart rename
    map("n", "<Leader>ldia", "<Cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
    map("n", "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
    map("n", "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
    map("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
  end, -- lsp_config

  luasnip = function()
    local luasnip = package.loaded.luasnip

    -- expand the current item or jump to the next item within the snippet.
    map({ "i", "s" }, "<A-j>", function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { noremap = true, silent = false })

    -- move to the previous item within the snippet
    map({ "i", "s" }, "<A-k>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end)
  end, -- luasnip

  nvim_tree = function(bufnr)
    local status, api = pcall(require, "nvim-tree.api")
    local function opts(desc)
      return {
        desc = "nvim-tree: " .. desc,
        buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true,
      }
    end
    if status then
      map('n', '?', api.tree.toggle_help, opts('Help'))
    end
  end, -- nvim_tree

  telescope = function()
    local status, ts_builtin = pcall(require, "telescope.builtin")
    if status then
      map('n', '<Leader>fb', ts_builtin.buffers)
      map('n', '<Leader>ff', ts_builtin.find_files)
      map('n', '<Leader>fr', ts_builtin.lsp_references)
      map('n', '<Leader>ft', ts_builtin.treesitter)
    end
  end, -- telescope
}

return M
