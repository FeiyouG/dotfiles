local M = {}
_G.settings.fn = M

-- SECTION: Utility

local os_name = nil

---Get current OS name
---@return string os_name one of "mac", "win", "linux", and "unkown"
function M.os_name()
	if os_name ~= nil then
		return os_name
	end

	for os, name in pairs({
		mac = "mac",
		win32 = "win",
		linux = "linux",
	}) do
		if vim.fn.has(os) == 1 then
			os_name = name
			return name
		end
	end

	os_name = "unkown"
	return os_name
end

---@param obj any the object to be checked
---@return boolean is_callable true if obj is callable
function M.is_callable(obj)
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

---Return the name of the root directory of the current project based on patterns
---@param patterns {[integer]: string} | nil files/dirs that the root dir would contain; look for ,git folder by default
---@return string path the path of the root directory
function M.project_root(patterns)
	patterns = patterns or { ".git" }
	return vim.fs.dirname(vim.fs.find(patterns, { upward = true })[1])
end

-- SECTION: Plugin
M.plugin = {}

---@type {string : LazyPlugin}
local plugins = nil

---Load plugin specs into memory
local function load_plugin_spec()
	if not plugins then
		plugins = {}
		for _, plugin_config in ipairs(require("lazy").plugins()) do
			local main = require("lazy.core.loader").get_main(plugin_config) or plugin_config.name
			plugins[main] = plugin_config
		end
	end
end

-- ---That is the text between the '<,'> marks.
-- ---Note that these marks are only updated *after* leaving the visual mode.
-- --
-- ---@return table selected range, contains {start} and {end} tables with {line} (0-indexed, end inclusive) and {character} (0-indexed, end exclusive) values
-- M.get_selected_range = function()
-- 	-- code adjusted from `vim.lsp.util.make_given_range_params`
-- 	-- we don't want to use character encoding offsets here
--
-- 	local A = vim.api.nvim_buf_get_mark(0, "<")
-- 	local B = vim.api.nvim_buf_get_mark(0, ">")
--
-- 	-- convert to 0-index
-- 	A[1] = A[1] - 1
-- 	B[1] = B[1] - 1
-- 	if vim.o.selection ~= "exclusive" then
-- 		B[2] = B[2] + 1
-- 	end
-- 	return {
-- 		start = { line = A[1], character = A[2] },
-- 		["end"] = { line = B[1], character = B[2] },
-- 	}
-- end

-- ---Gets the text in the given range of the current buffer.
-- ---Needed until https://github.com/neovim/neovim/pull/13896 is merged.
-- --
-- ---@param range table contains {start} and {end} tables with {line} (0-indexed, end inclusive) and {character} (0-indexed, end exclusive) values
-- ---@return string? text in range
-- M.get_text_in_range = function(range)
-- 	local A = range["start"]
-- 	local B = range["end"]
--
-- 	local lines = vim.api.nvim_buf_get_lines(0, A.line, B.line + 1, true)
-- 	if vim.tbl_isempty(lines) then
-- 		return nil
-- 	end
-- 	local MAX_STRING_SUB_INDEX = 2 ^ 31 - 1 -- LuaJIT only supports 32bit integers for `string.sub` (in block selection B.character is 2^31)
-- 	lines[#lines] = string.sub(lines[#lines], 1, math.min(B.character, MAX_STRING_SUB_INDEX))
-- 	lines[1] = string.sub(lines[1], math.min(A.character + 1, MAX_STRING_SUB_INDEX))
-- 	return table.concat(lines, "\n")
-- end

--- Return the visually selected range, as well as the text as an array with an entry for each line
---
---@return table selected range, contains {start} and {end} tables with {line} (0-indexed, end inclusive) and {character} (0-indexed, end exclusive) values
---@return string[]|nil lines The selected text as an array of lines.
M.get_visual_selection_range = function()
	local _, srow, scol = unpack(vim.fn.getcharpos("v"))
	local _, erow, ecol = unpack(vim.fn.getcharpos("."))

	local r1, c1, r2, c2
	local lines

	-- visual line mode
	if vim.fn.mode() == "V" then
		if srow > erow then
			r1, c1, r2 = erow - 1, 0, srow
			c2 = string.len(vim.api.nvim_buf_get_lines(0, srow - 1, erow, true)[1])
			lines = vim.api.nvim_buf_get_lines(0, erow - 1, srow, true)
		else
			r1, c1, r2 = srow - 1, 0, erow
			c2 = string.len(vim.api.nvim_buf_get_lines(0, erow - 1, erow, true)[1])
			lines = vim.api.nvim_buf_get_lines(0, srow - 1, erow, true)
		end
	-- regular visual mode
	elseif vim.fn.mode() == "v" then
		if srow < erow or (srow == erow and scol <= ecol) then
			r1, c1, r2, c2 = srow - 1, scol - 1, erow - 1, ecol
			lines = vim.api.nvim_buf_get_text(0, srow - 1, scol - 1, erow - 1, ecol, {})
		else
			r1, c1, r2, c2 = erow - 1, ecol - 1, srow - 1, scol
			lines = vim.api.nvim_buf_get_text(0, erow - 1, ecol - 1, srow - 1, scol, {})
		end
	elseif vim.fn.mode() == "\22" then
		lines = {}
		if srow > erow then
			srow, erow = erow, srow
		end
		if scol > ecol then
			scol, ecol = ecol, scol
		end
		r1, c1, r2, c2 = srow, scol, erow, ecol
		for i = srow, erow do
			table.insert(
				lines,
				vim.api.nvim_buf_get_text(0, i - 1, math.min(scol - 1, ecol), i - 1, math.max(scol - 1, ecol), {})[1]
			)
		end
	end

	return {
		start = { line = r1, character = c1 },
		["end"] = { line = r2, character = c2 },
	}, lines
end

-- --- Return the visually selected text as an array with an entry for each line
-- ---
-- --- @return string[]|nil lines The selected text as an array of lines.
-- M.get_visual_selection_text = function()
-- 	local _, srow, scol = unpack(vim.fn.getpos("v"))
-- 	local _, erow, ecol = unpack(vim.fn.getpos("."))
--
-- 	-- visual line mode
-- 	if vim.fn.mode() == "V" then
-- 		if srow > erow then
-- 			return vim.api.nvim_buf_get_lines(0, erow - 1, srow, true)
-- 		else
-- 			return vim.api.nvim_buf_get_lines(0, srow - 1, erow, true)
-- 		end
-- 	end
--
-- 	-- regular visual mode
-- 	if vim.fn.mode() == "v" then
-- 		if srow < erow or (srow == erow and scol <= ecol) then
-- 			return vim.api.nvim_buf_get_text(0, srow - 1, scol - 1, erow - 1, ecol, {})
-- 		else
-- 			return vim.api.nvim_buf_get_text(0, erow - 1, ecol - 1, srow - 1, scol, {})
-- 		end
-- 	end
--
-- 	-- visual block mode
-- 	if vim.fn.mode() == "\22" then
-- 		local lines = {}
-- 		if srow > erow then
-- 			srow, erow = erow, srow
-- 		end
-- 		if scol > ecol then
-- 			scol, ecol = ecol, scol
-- 		end
-- 		for i = srow, erow do
-- 			table.insert(
-- 				lines,
-- 				vim.api.nvim_buf_get_text(0, i - 1, math.min(scol - 1, ecol), i - 1, math.max(scol - 1, ecol), {})[1]
-- 			)
-- 		end
-- 		return lines
-- 	end
-- end

---Return true if plugin is installed (may not be loaded)
---@param plugin_name string the name of the plugin to be checked
function M.plugin.is_installed(plugin_name)
	load_plugin_spec()
	return plugins[plugin_name] ~= nil
end

---Return the spec of the given plugin, or nil if
---@param plugin_name string the name of a plugin
---@return LazyPlugin|nil
function M.plugin.get_spec(plugin_name)
	load_plugin_spec()
	return plugins[plugin_name]
end

---Immediately load the plugin if it is configured and installed and return it
---@param plugin_name string the name of the plugin
---@return any plugin
function M.plugin.load(plugin_name)
	if not M.plugin.is_installed(plugin_name) then
		return nil
	end
	require("lazy").load({
		plugins = { plugins[plugin_name].name },
		show = false,
		wait = false,
	})
	return require(plugin_name)
end

-- SECTION: Command
-- M.command = {
--   ---@param items Item
--   ---@param opts? Config
--   add = function(items, opts)
--     if not M.plugin.is_installed("commander") then return end
--     print("HERE!")
--     M.plugin.load("commander").add(items, opts)
--   end
-- }

-- SECTION: LSP
M.lsp = {}

---@type {string: any}
local capabilities = nil

---Get the lsp client capabilities
---@return {string: any} capabilities
M.lsp.get_capabilities = function()
	if capabilities then
		return capabilities
	end

	capabilities = vim.lsp.protocol.make_client_capabilities()

	if M.plugin.is_installed("cmp_nvim_lsp") then
		capabilities.textDocument.completion =
			M.plugin.load("cmp_nvim_lsp").default_capabilities().textDocument.completion
	end

	if M.plugin.is_installed("luasnip") then
		capabilities.textDocument.completion.completionItem.snippetSupport = true
	end

	if M.plugin.is_installed("ufo") then
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}
	end

	return capabilities
end

---Common logic in on_attach method shared by all language servers
M.lsp.on_attach = function(client, bufnr)
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

		if client.server_capabilities.documentFormattingProvider then
			vim.lsp.buf.format({ async = true })
		end
	end, { desc = "lps format" })

	if M.plugin.is_installed("telescope") then
		M.plugin.load("telescope")

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
M.lsp.get_location_from_selection = function(range)
	local params = vim.lsp.util.make_given_range_params()

	if not range then
		range, _ = M.get_visual_selection_range()
	end

	return {
		uri = params.textDocument.uri,
		range = range,
	}
end

return M
