local has_notify, notify = pcall(require, "notify")

local M = {}


M.path = require("utils.path")
-- M.telescope = require("utils.telescope")
-- M.command_center = require("utils.command_center")

M._warned = {}
M._notified = {}

-- Send a warning only if hasn't sent before
M.warn_once = function(message)
  if (M._warned[message]) then return end
  M.warn(message)
  M._warned[message] = true
end

-- Send a warning
M.warn = function(message)
  vim.schedule(function()
    if has_notify then
      notify(message, vim.log.levels.WARN, {
        title = "nvim/init.lua"
      })
    else
      vim.notify("[nvim/init.lua] " .. message, vim.log.levels.WARN)
    end
  end)
end

M.notify = function(module_name, message, level, once)
  level = level or vim.log.levels.WARN
  once = once or false

  local hash = module_name .. message .. level

  if (M._notified[hash]) then return end

  vim.schedule(function()
    if has_notify then
      notify(message, level, { title = module_name })
    else
      vim.notify("[" .. module_name .. "]: " .. message, vim.log.levels.WARN)
    end
  end)

  if (M._notified[hash]) then M._notified[hash] = true end

end


return M
