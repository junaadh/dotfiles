local set = vim.opt

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Appearance
set.number = true
set.relativenumber = true
set.scrolloff = 3

-- Tab
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true
set.smartindent = true
set.wrap = true

-- Search
set.incsearch = true
set.ignorecase = true
set.smartcase = true
set.hlsearch = true

-- Behavior
set.hidden = true
set.errorbells = true
set.swapfile = false
set.backup = false
set.undodir = vim.fn.expand("~/.vim/undodir")
set.undofile = true
set.backspace = "indent,eol,start"
