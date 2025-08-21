return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Hàm tự chọn linter cho PHP dựa trên project
    local function php_linter()
      local cwd = vim.fn.getcwd()
      local composer_file = cwd .. "/composer.json"
      if vim.fn.filereadable(composer_file) == 1 then
        local content = vim.fn.readfile(composer_file)
        local text = table.concat(content, "\n")
        if text:find('"laravel/framework"') then
          return "pint" -- Laravel project
        end
      end
      return "phpcs" -- Các PHP project khác
    end

    -- Khai báo linter cho từng filetype
    lint.linters_by_ft = {
      python = { "ruff" },
      javascript = { "biome" },
      typescript = { "biome" },
      javascriptreact = { "biome" },
      typescriptreact = { "biome" },
      php = php_linter, -- tự động chọn Pint hoặc phpcs
      lua = { "luacheck" },
    }

    -- Tự động lint khi lưu file
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
      callback = function()
        lint.try_lint()
      end,
    })

    -- Keymap để lint thủ công
    vim.keymap.set("n", "<leader>ll", function()
      lint.try_lint()
    end, { desc = "Run linter" })
  end,
}
