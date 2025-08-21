return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" }, -- format trước khi save
  cmd = { "ConformInfo" },
  config = function()
    local function php_formatter()
      local cwd = vim.fn.getcwd()
      local composer_file = cwd .. "/composer.json"
      if vim.fn.filereadable(composer_file) == 1 then
        local content = vim.fn.readfile(composer_file)
        local text = table.concat(content, "\n")
        if text:find('"laravel/framework"') then
          return "pint" -- Laravel project
        end
      end
      return "php_cs_fixer" -- Các PHP project khác
    end

    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        php = php_formatter, -- tự động chọn Pint hoặc php-cs-fixer
        javascript = { "biome" },
        typescript = { "biome" },
        javascriptreact = { "biome" },
        typescriptreact = { "biome" },
        json = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        python = { "ruff_format" },
      },
      -- format on save
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      },
      formatters = {
        php_cs_fixer = {
          command = "php-cs-fixer",
          args = { "fix", "--using-cache=no", "$FILENAME" },
          stdin = false,
        },
        pint = { -- thêm Pint
          command = "pint",
          args = { "$FILENAME" },
          stdin = false,
        },
        prettier = {
          command = "prettier",
          args = { "--stdin-filepath", "$FILENAME" },
          stdin = true,
        },
        biome = {
          command = "biome",
          stdin = true,
          args = { "format", "--stdin-file-path", "$FILENAME" },
        },
        ruff_format = {
          command = "ruff",
          args = { "format", "-" },
          stdin = true,
        },
        black = {
          command = "black",
          args = { "--quiet", "-" },
          stdin = true,
        },
        isort = {
          command = "isort",
          args = { "--quiet", "-" },
          stdin = true,
        },
      },
    })
  end,
}
