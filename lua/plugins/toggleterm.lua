return {
  -- amongst your other plugins
  -- {'akinsho/toggleterm.nvim', version = "*", config = true}
  -- or
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {--[[ things you want to change go here]]
    -- size = 20 | function(term)
    --   if term.direction == "horizontal" then
    --     return 15
    --   elseif term.direction == "vertical" then
    --     return vim.o.columns * 0.4
    --   end
    -- end,
    open_mapping = [[<c-/]],
    direction = "float",
    shade_terminals = true, -- NO
  },
  keys = {
    { "<leader>tt", "<Cmd>ToggleTerm<CR>", desc = "open terminal" },
  },
}
