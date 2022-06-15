local has_notify, notify = pcall(require, "notify")

local M = {}

M._warned = {}
M._notified = {}

-- Send a warning only if hasn't sent before
M.warn_once = function(message)
  M.notify("[nvim/init.lua]", message, vim.log.levels.WARN, true)
end

-- Send a warning
M.warn = function(message)
  M.notify("[nvim/init.lua]", message, vim.log.levels.WARN, false)
end

M.notify = function(module_name, message, level, once)
  level = level or vim.log.levels.WARN
  once = once or false

  local hash = module_name .. message .. level

  if (once and M._notified[hash]) then return end

  vim.schedule(function()
    if has_notify then
      notify(message, level, { title = module_name })
    else
      vim.notify("[" .. module_name .. "]: " .. message, vim.log.levels.WARN)
    end
  end)

  if (once and M._notified[hash]) then M._notified[hash] = true end
end

M.get_os = function()
  local os_list = {
    mac = "mac",
    win32 = "win",
    linux = "linux"
  }

  for os, os_name in pairs(os_list) do
    if vim.fn.has(os) == 1 then
      return os_name
    end
  end

end


M.path = require("utils.path")
M.lsp = require("utils.lsp")
return M
