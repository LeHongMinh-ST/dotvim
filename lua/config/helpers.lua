-- go to errors in a file :/
vim.keymap.set("n", "<leader>ce", function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
  if #diagnostics > 0 then
    local message = diagnostics[1].message
    vim.fn.setreg("+", message)
    print("Copied diagnostic: " .. message)
  else
    print("No diagnostic at cursor")
  end
end, { noremap = true, silent = true })

-- go to errors in a file :/
vim.keymap.set("n", "<leader>ne", vim.diagnostic.goto_next) -- next err
vim.keymap.set("n", "<leader>pe", vim.diagnostic.goto_prev) -- previous err

-- set language based on vim mode
-- requires im-select https://github.com/daipeihust/im-select
-- recommend installing it by brew
local sysname = vim.loop.os_uname().sysname
local is_mac = sysname == "Darwin"
local is_linux = sysname == "Linux"

local get_current_layout
local set_layout
local english_layout
local last_insert_layout

if is_mac then
  -- macOS: dùng im-select
  get_current_layout = function()
    local f = io.popen("im-select")
    local layout = nil
    if f ~= nil then
      layout = f:read("*all"):gsub("\n", "")
      f:close()
    end
    return layout
  end
  set_layout = function(layout)
    os.execute("im-select " .. layout)
  end
  english_layout = "com.apple.keylayout.ABC"
elseif is_linux then
  -- Ubuntu: dùng ibus
  get_current_layout = function()
    local f = io.popen("ibus engine")
    local layout = nil
    if f ~= nil then
      layout = f:read("*all"):gsub("\n", "")
      f:close()
    end
    return layout
  end
  set_layout = function(layout)
    os.execute("ibus engine " .. layout)
  end
  -- ví dụ: "xkb:us::eng" (US English) hoặc "BambooUs" nếu dùng ibus-bamboo
  english_layout = "xkb:us::eng"
end

if get_current_layout and set_layout then
  last_insert_layout = get_current_layout()

  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      last_insert_layout = get_current_layout()
      set_layout(english_layout)
    end,
  })

  vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
    pattern = "*:*n",
    callback = function()
      set_layout(english_layout)
    end,
  })

  vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
      if last_insert_layout then
        set_layout(last_insert_layout)
      end
    end,
  })

  vim.api.nvim_create_autocmd("FocusGained", {
    callback = function()
      if last_insert_layout then
        set_layout(last_insert_layout)
      end
    end,
  })
end
-- end of language based on vim mode

-- floading term
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  callback = function()
    local crbuf = vim.api.nvim_get_current_buf()
    vim.cmd("wincmd c")
    -- vim.cmd("wincmd L")
    vim.api.nvim_open_win(crbuf, true, {
      relative = "editor",
      width = math.floor(vim.o.columns * 0.8),
      height = math.floor(vim.o.lines * 0.8),
      col = math.floor(vim.o.columns * 0.1),
      row = math.floor(vim.o.lines * 0.1),
      border = "rounded",
    })
  end,
})
