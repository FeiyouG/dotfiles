local M = {}

---Get current OS name
---@return string|nil: one of "mac", "win", and "linux"
local get_os_name = function()
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
  return nil
end

--- string|nil: one of "mac", "win", and "linux"
M.os_name = get_os_name()

return M
