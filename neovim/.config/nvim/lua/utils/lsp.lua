local M = {}

-- MARK: setup LSP capabilities

-- @return the common capabilities shared by all lsp servers
local default_capabilities = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	-- update capability if nvim-cmp is present
	local nvim_cmp = require("utils.fn").require("cmp_nvim_lsp", "Can't update lsp capabilities for nvim-cmp")
	if nvim_cmp then
		capabilities = nvim_cmp.default_capabilities()
	end

	return capabilities
end

M.capabilities = default_capabilities()

-- MARK: Add common logic to on_attach function
function M.on_attach(client, bufnr)
	-- Setup navic
	local navic = Utils.require("nvim-navic")
	if navic and client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
end

return M
