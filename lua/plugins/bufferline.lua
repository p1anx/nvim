local bufferline = require("bufferline")
return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      mode = "buffers", -- set to "tabs" to only show tabpages instead
      style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
      show_tab_indicators = true, -- true | false,
      indicator = {
        -- icon = '▎', -- this should be omitted if indicator style is not 'icon'
        -- icon = "_", -- this should be omitted if indicator style is not 'icon'
        style = "none", --'icon' | 'underline' | 'none',
      },
      separator_style = "slant", --"slant"| "slope" | "thick" | "thin" | { 'any', 'any' },
      -- close_command = function(n) Snacks.bufdelete(n) end,
      -- -- stylua: ignore
      -- right_mouse_command = function(n) Snacks.bufdelete(n) end,
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      diagnostics_indicator = function(_, _, diag)
        local icons = LazyVim.config.icons.diagnostics
        local ret = (diag.error and icons.Error .. diag.error .. " " or "")
          .. (diag.warning and icons.Warn .. diag.warning or "")
        return vim.trim(ret)
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
      ---@param opts bufferline.IconFetcherOpts
      get_element_icon = function(opts)
        return LazyVim.config.icons.ft[opts.filetype]
      end,
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}
