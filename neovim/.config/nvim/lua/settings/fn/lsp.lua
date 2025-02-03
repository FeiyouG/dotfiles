local M = {}
local utils = require("settings.fn.utils")
local plugin = require("settings.fn.plugin")

---@type {string: any}
local capabilities = nil

---Get the lsp client capabilities
---@return {string: any} capabilities
M.get_capabilities = function()
	if capabilities then
		return capabilities
	end

	capabilities = vim.lsp.protocol.make_client_capabilities()

	if plugin.is_installed("cmp_nvim_lsp") then
		capabilities.textDocument.completion =
			plugin.load("cmp_nvim_lsp").default_capabilities().textDocument.completion
	end

	if plugin.is_installed("luasnip") then
		capabilities.textDocument.completion.completionItem.snippetSupport = true
	end

	if plugin.is_installed("ufo") then
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}
	end

	return capabilities
end

local server_with_format = {}

---Common logic in on_attach method shared by all language servers
M.on_attach = function(client, bufnr)
	if client.server_capabilities.documentFormattingProvider then
		if not vim.tbl_contains(server_with_format, client.name) then
			vim.list_extend(server_with_format, { client.name })
		end
	end

	vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentations (hover)" })
	vim.keymap.set("n", "E", vim.diagnostic.open_float, { desc = "Show errors of the current line (floating window)" })
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to the next diagnostic item" })
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to the previous diagnostic item" })
	vim.keymap.set("n", "<leader>sk", vim.lsp.buf.signature_help, { desc = "Show function signature" })
	vim.keymap.set("n", "<leader>sD", vim.lsp.buf.declaration, { desc = "Go to declarations" })
	vim.keymap.set("n", "<leader>sn", vim.lsp.buf.rename, { desc = "Rename symbol" })
	vim.keymap.set("n", "<leader>sen", vim.diagnostic.goto_next, { desc = "Go to the next diagnostic item" })
	vim.keymap.set("n", "<leader>sep", vim.diagnostic.goto_prev, { desc = "Go to the previous diagnostic item" })
	vim.keymap.set({ "n", "v" }, "<leader>sa", vim.lsp.buf.code_action, { desc = "Show code actions" })
	vim.keymap.set("n", "<leader>sf", function()
		-- Trim trailing white space first
		if not vim.o.binary and vim.o.filetype ~= "diff" and vim.bo.modifiable then
			vim.cmd([[%s/\s\+$//e]])
			vim.cmd("noh")
		end

		-- If no server or 1 server, format with default
		if #server_with_format <= 1 then
			vim.lsp.buf.format({ async = true })
			return
		end

		-- If more than on server can format, let me choose!
		vim.ui.select(server_with_format, {
			prompt = "Select a server to format with",
		}, function(choice)
			print(choice)
			vim.lsp.buf.format({
				async = true,
				name = choice,
			})
		end)

		-- if client.server_capabilities.documentFormattingProvider then
		-- 	vim.lsp.buf.format({ async = true })
		-- end
	end, { desc = "lps format" })

	if plugin.is_installed("telescope") then
		plugin.load("telescope")

		vim.keymap.set("n", "<leader>sd", "<CMD>Telescope lsp_definitions<CR>", { desc = "Go to definitions" })
		vim.keymap.set(
			"n",
			"<leader>st",
			"<CMD>Telescope lsp_type_definitions<CR>",
			{ desc = "Go to type definitions" }
		)
		vim.keymap.set("n", "<leader>sr", "<CMD>Telescope lsp_references<CR>", { desc = "Show all references" })
		vim.keymap.set(
			"n",
			"<leader>ssw",
			"<CMD>Telescope lsp_dynamic_workspace_symbols<CR>",
			{ desc = "show workspace symbols" }
		)
		vim.keymap.set("n", "<leader>si", "<CMD>Telescope lsp_implementations<CR>", { desc = "Go to implementations" })
		vim.keymap.set(
			"n",
			"<leader>se",
			"<CMD>Telescope diagnostics<CR>",
			{ desc = "Show workspace errors (diagnostic)" }
		)
		vim.keymap.set(
			"n",
			"<leader>sef",
			"<CMD>Telescope diagnostics<CR>",
			{ desc = "Show workspace errors (diagnostic)" }
		)
		vim.keymap.set(
			"n",
			"<leader>ssd",
			"<CMD>Telescope lsp_document_symbols<CR>",
			{ desc = "Show document symbols" }
		)
		vim.keymap.set("n", "<leader>ss", "<CMD>Telescope lsp_document_symbols<CR>", { desc = "Show document symbols" })
	end
end

---Makes an LSP location object from the last selection in the current buffer.
--
---@param range table selected range; can be obtained from get_visual_selection_range().
---@return table LSP location object
---@see https://microsoft.github.io/language-server-protocol/specifications/specification-current/#location
M.get_location_from_selection = function(range)
	local params = vim.lsp.util.make_given_range_params()

	if not range then
		range, _ = utils.get_visual_selection_range()
	end

	return {
		uri = params.textDocument.uri,
		range = range,
	}
end

return M
