local bufferline = require('bufferline')
return
{
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  -- keys = {
  --   { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
  --   { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
  --   { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
  --   { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
  --   { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
  --   { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
  --   { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
  --   { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
  --   { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
  --   { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
  -- },
  opts = {
    options = {
      mode = "buffers", -- set to "tabs" to only show tabpages instead
      style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
      show_tab_indicators =true, -- true | false,
      indicator = {
          -- icon = '▎', -- this should be omitted if indicator style is not 'icon'
          -- icon = '_', -- this should be omitted if indicator style is not 'icon'
          style = 'underline', --'icon' | 'underline' | 'none',
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
    highlights = {
        indicator_selected = {
          fg = #121111,
          sp = #111111,
          -- fg = vim.g.primary,
          -- sp = vim.g.primary,
          underline = true,
        },
        buffer_selected = {
          fg = vim.g.primary,
          bg = "NONE",
          bold = true,
          underline = true,
          sp = vim.g.primary,
        },
        close_button_selected = {
          fg = vim.g.primary,
          bg = "NONE",
          underline = true,
          sp = vim.g.primary,
        },
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
