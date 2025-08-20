vim.opt.termguicolors = true -- Bật màu sắc đẹp hơn

vim.g.lazyvim_eslint_auto_format = true

vim.opt.clipboard = "unnamedplus"

-- In case you don't want to use `:LazyExtras`,
-- then you need to set the option below.
-- vim.g.lazyvim_picker = "telescope"
--
-- vim.g.lazyvim_php_lsp = "intelephense"

vim.g.blamer_enabled = true
vim.g.NERDTreeShowHidden = 1
vim.o.mouse = "a"

vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set cursorline")
