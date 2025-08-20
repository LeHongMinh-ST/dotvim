local keymaps = vim.keymap
local otps = { noremap = true, silent = true }
local builtin = require("telescope.builtin")

keymaps.set({ "n", "i", "x", "s" }, "<C-s>", "<cmd>w<cr><esc>", { silent = true, desc = "Save File" })

-- Delete a word
keymaps.set("n", "dw", "vb_d")

-- SelectAll
keymaps.set("n", "<C-a>", "gg<S-v>G")

-- Split window
keymaps.set("n", "ss", ":split<Return>", otps)
keymaps.set("n", "sv", ":vsplit<Return>", otps)

-- Move between windows (works with Neo-tree too)
keymaps.set("n", "<C-h>", "<C-w>h")
keymaps.set("n", "<C-k>", "<C-w>k")
keymaps.set("n", "<C-j>", "<C-w>j")
keymaps.set("n", "<C-l>", "<C-w>l")

-- Close current window or quit if last
keymaps.set("n", "<leader>wd", ":q<CR>", opts)
keymaps.set("n", "<leader>ws", ":only<CR>", opts)


-- Move between tabs
keymaps.set("n", "<S-h>", ":tabprevious<CR>", opts)
keymaps.set("n", "<S-l>", ":tabnext<CR>", opts)

-- Move lines up/down
keymaps.set("n", "<A-j>", ":m .+1<CR>==", opts)
keymaps.set("n", "<A-k>", ":m .-2<CR>==", opts)
keymaps.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymaps.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
keymaps.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymaps.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Resize windows
keymaps.set("n", "<C-Up>", ":resize -2<CR>", opts)
keymaps.set("n", "<C-Down>", ":resize +2<CR>", opts)
keymaps.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymaps.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Buffer navigation
keymaps.set("n", "<S-h>", ":bprevious<CR>", opts)
keymaps.set("n", "<S-l>", ":bnext<CR>", opts)
keymaps.set("n", "[b", ":bprevious<CR>", opts)
keymaps.set("n", "]b", ":bnext<CR>", opts)
-- Switch to other buffer

-- keymaps.set("n", "<leader>bb", "<cmd>BufferLineCyclePrev<CR>", opts)
-- keymaps.set("n", "<leader>`", "<cmd>BufferLineCyclePrev<CR>", opts)

-- Delete buffer (close current tab)
keymaps.set("n", "<leader>bd", "<cmd>b#|bd #<CR>", opts)

-- Delete other buffers
keymaps.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", opts)

-- Delete buffer and window
keymaps.set("n", "<leader>bD", "<cmd>BufferLinePickClose<CR>", opts)
-- Escape and clear search highlight
keymaps.set({ "i", "n", "s" }, "<Esc>", "<Esc>:noh<CR>", opts)

-- -- Diagnostics
-- keymaps.set("n", "<C-j>", function()
--     vim.diagnostic.goto_next()
-- end)

-- move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymaps.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
keymaps.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
keymaps.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
keymaps.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

-- Mở Neo-tree bên trái
keymaps.set("n", "<leader>e", ":Neotree toggle left<CR>")
