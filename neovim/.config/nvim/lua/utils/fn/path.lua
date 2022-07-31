-- Path related utils
local M = {}

-- Concatenate paths with '/'
M.concat = function(...)
  return table.concat({ ... }, '/')
end

-- Check whether directory exist on path
M.dir_exists = function(path)
  return vim.fn.isdirectory(vim.fn.glob(path)) == 1
end

-- Check whether file exists on path
M.file_exists = function(path)
  return vim.fn.filereadable(vim.fn.glob(path)) == 1
end

-- Create directory recursice if path doesn't exist
M.safe_path = function(path)
  vim.api.nvim_exec("!safe_path " .. path, false)
end

return M
