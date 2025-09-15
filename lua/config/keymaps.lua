-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
if vim.fn.exists("g:os") == 0 then
  local is_windows = vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1
  if is_windows then
    vim.g.os = "Windows"
  else
    local uname_output = vim.fn.system("uname")
    vim.g.os = string.gsub(uname_output, "\n", "")
  end
end

if vim.g.os == "Windows" then
  vim.keymap.set("v", "<c-x>", '"+x')
  vim.keymap.set("v", "<c-c>", '"+y')
elseif vim.g.os == "Linux" then
  vim.keymap.set("v", "<c-x>", '"+x')
  vim.keymap.set("v", "<c-c>", '"+y')
end

-- vim.keymap.set({ "v", "n" }, "y", '"+y')

-- ========================================
--   flash
-- ========================================
vim.keymap.set({ "n", "x", "o" }, "f", function()
  require("flash").jump()
end)

-- set script for matlab start comsol
--   ":w!<cr>:sp<cr>:te matlab -nodesktop -nosplash -r 'run('%')'<CR>i",
vim.keymap.set("n", "<leader>mm", ":w!<cr>:sp<cr>:te matlab -nodesktop -nosplash -r '%:t:r;'<CR>i")
-- vim.keymap.set("n", "<leader>mm", ":te ~/hello.sh<cr>i")
-- vim.keymap.set("n", "<c-t>", "<cmd>ToggleTerm<cr>")
vim.keymap.set("n", "<leader>ms", ':lua require("luasnip.loaders").edit_snippet_files()')

-- ========================================
--   harpoon2
-- ========================================
