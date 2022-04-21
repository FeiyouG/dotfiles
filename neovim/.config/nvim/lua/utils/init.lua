local has_notify, notify = pcall(require, "notify")

local M = {}


M.path = require("utils.path")

M._warned = {}

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
      notify(message, vim.log.levels.WARN, { title = "nvim/init.lua" })
    else
      vim.notify("[nvim/init.lua] " .. message, vim.log.levels.WARN)
    end
  end)
end
return M
