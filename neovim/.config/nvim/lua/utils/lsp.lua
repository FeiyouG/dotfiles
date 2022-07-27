local M = {}

-- @return the common capabilities shared by all lsp servers
M.capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- update capability for nvim-cmp
  local nvim_cmp = require("utils.fn").require("cmp_nvim_lsp", "Can't update lsp capabilities for nvim-cmp")
  if not nvim_cmp then return capabilities end

  return nvim_cmp.update_capabilities(capabilities)
end

return M
