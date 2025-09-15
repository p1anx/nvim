-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = true
vim.opt.splitbelow = true -- open new vertical split bottom
vim.opt.splitright = true -- open new horizontal splits right

vim.opt.autowrite = true
vim.opt.autochdir = true
-- vim.opt.textwidth = 10
vim.opt.wrap = true

vim.opt.tabstop = 4 -- 一个Tab显示为4个空格
vim.opt.shiftwidth = 4 -- 自动缩进时使用4个空格
vim.opt.softtabstop = 4 -- 编辑时插入4个空格
vim.opt.expandtab = true -- 将Tab转换为空格
