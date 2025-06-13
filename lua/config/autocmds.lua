-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    -- -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<F5>",
      ":w!<cr>:sp<cr>:te gcc '%' -o '%:t:r' && './%:t:r'<CR>i",
      -- ":w!<cr>:sp<cr>:te gcc '%' -o '%:t:r' && './%:t:r'<CR>i",
      -- ":w!<cr>:sp<cr>:te gcc % -o %:t:r && %:t:r<CR>i",
      -- ":w!<cr>:sp<cr>:te gcc % -o %:t:r && %:t:r.exe<CR>i",
      { silent = true, noremap = true }
    )
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<F8>",
      "<ESC>:w<CR>:split<CR>:te clang -std=c11 -Wshadow -Wall -o %:t:r% -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG && time ./%:t:r<CR>i",
      -- "<ESC>:w<CR>:split<CR>:te clang -std=c11 -Wshadow -Wall -o %:t:r.exe % -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG && time ./%:t:r.exe<CR>i",
      { silent = true, noremap = true }
    )
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    -- -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<F5>",
      -- ":w!<cr>:sp<cr>:te g++ % -o %:t:r && %:t:r<CR>i",
      ":w!<cr>:sp<cr>:te g++ '%' -o '%:t:r' && './%:t:r'<CR>i",
      -- ":w!<cr>:sp<cr>:te g++ % -o %:t:r && %:t:r.exe<CR>i",
      { silent = true, noremap = true }
    )
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    -- -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
    vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":w!<cr>:sp<cr>:te python %<CR>i", { silent = true, noremap = true })
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "matlab",
  callback = function()
    -- -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<leader>mc",
      ":w!<cr>:sp<cr>:te ~/.config/nvim/lua/script/comsol_startup.sh '%:t:r'<CR>i",
      { silent = true, noremap = true }
    )
    -- vim.api.nvim_buf_set_keymap(
    --   0,
    --   "n",
    --   "<F5>",
    --   -- ":w!<cr>:sp<cr>:te ~/.config/nvim/lua/script/matlab_startup.sh '%:t:r'<CR>i",
    --   ":w!<cr>:sp<cr>:te matlab -nodesktop -nosplash -r 'run('%')'<CR>i",
    --   --   ":w!<cr>:sp<cr>:te matlab -nodesktop -nosplash -r '%:t:r'<CR>i", --or use this
    --   { silent = true, noremap = true }
    -- )
  end,
})
