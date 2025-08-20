return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- icons
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true, -- tự đóng nếu là cửa sổ cuối cùng
      filesystem = {
        follow_current_file = {
          enabled = true, -- bật tính năng
          leave_dirs_open = false, -- (tuỳ chọn) giữ thư mục đang mở
        },
        hijack_netrw_behavior = "open_default", -- thay thế netrw
      },
      window = {
        mappings = {
          ["h"] = "close_node",
          ["l"] = "open",
          ["<Left>"] = "close_node",
          ["<Right>"] = "open",
          -- ["j"] = "next_sibling",
          -- ["k"] = "prev_sibling",
          -- disable arrow keys để tránh lỗi khi dùng tiếng Việt
          ["<Up>"] = "none",
          ["<Down>"] = "none",
        },
      },
    })
  end,
}
