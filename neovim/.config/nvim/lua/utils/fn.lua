local M = {}

-- @param obj any: the object to be checked
-- @return true iff obj is callable; false otherwise
M.is_callable = function(obj)
  if type(obj) == "function" then
    return true
  elseif type(obj) == "table" then
    local mt = getmetatable(obj)
    if mt then
      return type(mt.__call) == "function"
    end
  end
  return false
end

-- Safely require a package; if failed, return nil and send a one-time notification
-- @param name string: the name of the package to be requried
-- @param ... list: additional detail to be included in the notification in case of failure
-- @return the required package if successfully; nil otherwise
M.require = function(name, ...)
  local ok, res = pcall(require, name)
  if not ok then
    require("utils.notify").failed_to_load(name, ..., res)
    return nil
  end
  return res
end

return M
