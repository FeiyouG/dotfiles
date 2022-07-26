local M = {}

M.os_name = function()
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

return M
