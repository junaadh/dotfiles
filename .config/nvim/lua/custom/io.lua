-- initilaize module
local M = {}

-- define function to create new file
function M.createFile()
  local filename = vim.fn.input("Enter filename: ")
  local path = vim.fn.expand('%:h') .. '/' .. filename
  vim.cmd("!touch " .. path)
  vim.cmd("edit " .. path)
end

-- define function to create new dir
function M.createDir()
  local dirname = vim.fn.input("Enter directory name: ")
  vim.cmd("!mkdir -p " .. vim.fn.expand('%:h') .. '/' .. dirname)
end

-- define function to rename files and dir
function M.rename()
  local name = vim.fn.input("Rename to? ")
  local new_file = vim.fn.expand('%:h') .. '/' .. name
  local current_file = vim.fn.expand('%')
  local is_dir = vim.fn.isdirectory(current_file)

  if is_dir == 1 then
    vim.cmd("!mv -T " .. current_file .. " " .. new_file)
  else
    vim.cmd("!mv " .. current_file .. " " .. new_file)
  end

  vim.cmd("edit " .. new_file)
end

-- return module
return M
