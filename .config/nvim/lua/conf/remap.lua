vim.g.mapleader = " "
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local nmap = vim.api.nvim_set_keymap

-- Finder
map("n", "<leader>f", ":Telescope find_files<CR>", opts)

-- Short Hand shell commands
nmap("n", "<leader>%", ":lua require(\"custom\").createFile()<CR>", opts)
nmap("n", "<leader>d", ":lua require(\"custom\").createDir()<CR>", opts)
