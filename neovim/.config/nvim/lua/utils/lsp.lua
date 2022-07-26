local M = {}

M.capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- update capability for nvim-cmp
  local has_nvim_cmp, nvim_cmp = pcall(require, 'cmp_nvim_lsp')
  if has_nvim_cmp then
    capabilities = nvim_cmp.update_capabilities(capabilities)
  end

  return capabilities
end

return M
