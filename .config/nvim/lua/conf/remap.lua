vim.g.mapleader = " "
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local nmap = vim.api.nvim_set_keymap
local vm = vim.g

-- Finder
map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
map("n", "<leader>fm", ":Telescope man_pages<CR>", opts)

-- Short Hand shell commands
nmap("n", "<leader>%", ":lua require(\"custom\").createFile()<CR>", opts)
nmap("n", "<leader>d", ":lua require(\"custom\").createDir()<CR>", opts)
nmap("n", "<leader>$", ":lua require(\"custom\").rename()<CR>", opts)

-- helix style remap
nmap("n", "gh", "0", opts)
nmap("n", "gl", "g$", opts)
nmap("n", "ge", "G", opts)
nmap("v", "gh", "0", opts)
nmap("v", "gl", "g$", opts)
nmap("v", "ge", "G", opts)
nmap("x", "gh", "0", opts)
nmap("x", "gl", "g$", opts)
nmap("x", "ge", "G", opts)

nmap("x", "y", "y']", opts)
nmap("n", "p", "p']", opts)
nmap("n", "P", "'[P", opts)

nmap("n", "x", "V", opts)
nmap("n", "d", "x", opts)

nmap("x", "<leader>Y", "\"*y", opts)
nmap("v", "<leader>Y", "\"*y", opts)

nmap("n", "U", "<C-r>", opts)

nmap('n', '<C-S-Up>', ":m-2<CR>:normal! kj<CR>", opts)
nmap('n', '<C-S-Down>', ":m+<CR>:normal! jk<CR>", opts)

-- Visual multi
vm.VM_leader = {
  default = '<S>',
  visual = '<S>',
  buffer = 'b',
}
vm.VM_maps = {}
vm.VM_maps["Get Operator"] = '<S>a'
vm.VM_maps["Add Cursor At Pos"] = '<Leader><Space>'
vm.VM_maps["Reselect Last"] = '<S>z'
vm.VM_maps["Visual Cursors"] = '<S><Space>'
vm.VM_maps["Undo"] = 'u'
vm.VM_maps["Redo"] = 'U'
vm.VM_maps["Visual Subtract"] = 'bs'
vm.VM_maps["Visual Reduce"] = 'br'
