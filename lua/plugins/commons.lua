return {
  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers", -- hiển thị buffer
          numbers = "none", -- hoặc "ordinal", "buffer_id", "both"
          diagnostics = "nvim_lsp", -- hiển thị error/warning từ LSP
          separator_style = "slant", -- "slant", "padded_slant", "thick", "thin"
          show_buffer_close_icons = true,
          show_close_icon = true,
          always_show_bufferline = true,
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              highlight = "Directory",
              separator = true,
            },
          },
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
        },
      })
    end,
  },
}
