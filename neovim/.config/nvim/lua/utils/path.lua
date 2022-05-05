-- Path related utils
local M = {}

-- Concatenate paths with '/'
M.concat = function(...)
  return table.concat({ ... }, '/')
end

-- Create directory recursice if path doesn't exist
M.safe_path = function(path)
  vim.api.nvim_exec("!safe_path " .. path, false)
end

-- M.filepath = function()
--   return debug.getinfo(1).short_src
-- end
--
-- M.dirname = function()
--   return M.filepath():match("(.*/)")
-- end
--
-- M.filename = function()
--   return M.filepath():match("[^/]*.lua$")
-- end
--
-- M.files_in = function(dirname)
--   local res = {}
--   local f = io.popen('ls ' .. dirname)
--   for name in f:lines() do
--     print(name)
--     table.insert(res, name)
--   end
-- end

-- Plugin related path
M.plugin = {
  installed_path = M.concat(vim.fn.stdpath('data'), 'site/pack/packer/start/packer.nvim'),
  compiled_path = M.concat(vim.fn.stdpath('data'), 'site/pack/packer/start/packer.nvim/lua/packer_compiled.lua')
}

return M
