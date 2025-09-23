return {
  require("lspconfig").clangd.setup({
    cmd = {
      "clangd",
      "--header-insertion=never", -- 禁用头文件自动插入
      "--suggest-missing-includes=false", -- 禁用缺失包含建议
    },
  }),
}
