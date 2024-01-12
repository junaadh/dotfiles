-- init module
local M = {}

-- abbrv
local fn = vim.fn
local api = vim.api

------------------------------------------------
-- multi lines comments not working as of now --
------------------------------------------------

-- map with language and comment token
-- maps extension to the comment token
local comment_map = {
  sh = "//",
  c = "//",
  h = "//",
  cpp = "//",
  java = "//",
  tex = "%",
  lua = "--",
  rust = "//"
}

-- get type of file
local function get_type()
  return fn.expand('%:e')
end

local function _is_comment()
  local type = get_type()

  local comment_token = comment_map[type]
  if comment_token then
    local line_no = fn.getline('.')
    return fn.match(line_no, '^' .. comment_token) > -1
  end

  return false
end

-- commenting function
local function commenting(prefix)
  local mode = fn.mode()
  local vmode = fn.visualmode()
  if mode == 'n' or vmode == 'V' then
    local floc, lloc
    if mode == 'n' then
      floc = fn.line('.')
      lloc = floc
    elseif vmode == 'V' or vmode == 'B' or vmode == 'v' or vmode == 'B' or vmode == 'v' then
      floc = fn.line("'<")
      lloc = fn.line(">'")
    end

    for line = floc, lloc do
      local cur_content = api.nvim_buf_get_lines(0, line - 1, line, false)[1]
      local mod_content = prefix .. cur_content
      api.nvim_buf_set_lines(0, line - 1, line, false, {mod_content})
    end
  end
end

-- uncommenting function
local function uncommenting(prefix)
  local mode = fn.mode()
  local vmode = fn.visualmode()
  if mode == 'n' or vmode == 'V' or vmode == 'B' or vmode == 'v' then
    local floc, lloc
    if mode == 'n' then
      floc = fn.line('.')
      lloc = floc
    elseif vmode == 'V' or vmode == 'B' or vmode == 'v' then
      floc = fn.line("'<")
      lloc = fn.line(">'")
    end

    for line = floc, lloc do
      local cur_content = api.nvim_buf_get_lines(0, line - 1, line, false)[1]
      local mod_content = fn.substitute(cur_content, '^' .. prefix, '', '')
      api.nvim_buf_set_lines(0, line - 1, line, false, {mod_content})
    end
  end
end

-- comment function
function M.comment()
  local type = get_type()
  local prefix = comment_map[type]

  if prefix then
    if _is_comment() then
      uncommenting(prefix)
    else
      commenting(prefix)
    end
  end
end

return M
