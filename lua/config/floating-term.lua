local state = { floating = { buf = -1, win = -1 } }
local function create_floating_window(opts)
  opts = opts or {}
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)

  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local config = {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  }
  vim.api.nvim_set_hl(0, "MyFloatingWindow", { bg = "#1e1e1e", fg = "#ffffff", blend = 10 })
  local win = vim.api.nvim_open_win(buf, true, config)
  return { buf = buf, win = win }
end

local toggle_term = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    -- create new floating terminal
    state.floating = create_floating_window({ buf = state.floating.buf })
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    -- close win + buffer
    if vim.api.nvim_buf_is_valid(state.floating.buf) then
      vim.api.nvim_buf_delete(state.floating.buf, { force = true })
    end
    state.floating = { buf = -1, win = -1 }
  end
end

vim.api.nvim_create_user_command("FTerm", toggle_term, {})
vim.keymap.set({ "n", "t" }, "<leader>T", toggle_term)

local toggle_lazygit = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window({ buf = state.floating.buf })
    -- chạy lazygit với callback
    vim.fn.termopen("lazygit", {
      on_exit = function(_, _, _)
        if vim.api.nvim_buf_is_valid(state.floating.buf) then
          vim.api.nvim_buf_delete(state.floating.buf, { force = true })
        end
        state.floating = { buf = -1, win = -1 }
      end,
    })
    vim.cmd.startinsert()
  else
    if vim.api.nvim_buf_is_valid(state.floating.buf) then
      vim.api.nvim_buf_delete(state.floating.buf, { force = true })
    end
    state.floating = { buf = -1, win = -1 }
  end
end

vim.api.nvim_create_user_command("LazyGit", toggle_lazygit, {})
vim.keymap.set({ "n", "t" }, "<leader>gg", toggle_lazygit)
