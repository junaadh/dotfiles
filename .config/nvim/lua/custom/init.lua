-- initilaize module
local M = {}

-- define function to create new file
function M.createFile()
  local filename = vim.fn.input("Enter filename: ")
  vim.cmd("!touch " .. vim.fn.expand('%:h') .. '/' .. filename)
end

-- define function to create new dir
function M.createDir()
  local dirname = vim.fn.input("Enter directory name: ")
  vim.cmd("!mkdir -p " .. vim.fn.expand('%:h') .. '/' .. dirname)
end

-- return module
return M
