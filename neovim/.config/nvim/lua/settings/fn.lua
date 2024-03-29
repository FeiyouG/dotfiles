local M = {}

---Safely require a package; if failed, return nil and notify the error
---@param name string the name of the package to be requried
---@param ... any additional detail to be included in the notification in case of failure
---@return nil|table
function M.require(name, ...)
	local ok, res = pcall(require, name)
	if not ok then
		if select("#", ...) > 0 then
			vim.notify_once(...)
		end
		return nil
	end
	return res
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

---Return the root dir of project based on patterns
---@param patterns {[integer]: string} | nil files/dirs that the root dir would contain; look for ,git folder by default
---@return string path the path of the root directory
function M.find_root(patterns)
	patterns = patterns or { ".git" }
	return vim.fs.dirname(vim.fs.find(patterns, { upward = true })[1])
end

---Check whether the given path is a file
function M.is_file(path)
	return vim.fn.filereadable(vim.fn.glob(path)) == 1
end

---Check whether the given path is a directory
function M.is_dir(path)
	return vim.fn.isdirectory(vim.fn.glob(path)) == 1
end

---Clone repo to path if path doesn't exists
---@param install_path string
---@param repo string the link to the remote git repo
function M.bootstrap(install_path, repo, branch)
	if vim.loop.fs_stat(install_path) then
		return
	end

	local plugin_name = vim.fn.fnamemodify(install_path, ":p:h:y")
	vim.notify("Boostrap " .. plugin_name .. "...")
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		repo,
		branch and "--branch=" .. branch or "",
		-- "--depth",
		-- "1",
		-- repo,
		install_path,
	})
end

---Set environment variables
---@param envs {[string] : string} a table of enviroment variables and their default values
---@param override boolean | nil if set to true, then then envs will be override if they are already defined
function M.set_envs(envs, override)
	override = override or false

	for env, default in pairs(envs) do
		if override or not vim.env[env] then
			vim.env[env] = default
		end
	end
end

local os_name = nil

---Get current OS name
---@return string os_name one of "mac", "win", "linux", and "unkown"
function M.os_name()
	if os_name ~= nil then
		return os_name
	end

	local os_list = {
		mac = "mac",
		win32 = "win",
		linux = "linux",
	}

	for os, name in pairs(os_list) do
		if vim.fn.has(os) == 1 then
			os_name = name
			return name
		end
	end

	return "unkown"
end

-- TODO: TEMPORARY
M.keymap = {
	set = function(keymaps)
		local commander = M.require("commander")
		if commander then
			commander.add(keymaps)
		end
	end,
}

-- SECION: LSP
local capabilities = nil
M.lsp = {
	---Get the lsp client capabilities
	---@return table capabilities
	get_capabilities = function()
		if capabilities then
			return capabilities
		end

		capabilities = vim.lsp.protocol.make_client_capabilities()

		local cmp_nvim_lsp = M.require("cmp_nvim_lsp")
		if cmp_nvim_lsp then
			capabilities = cmp_nvim_lsp.default_capabilities()
		end

		if M.require("ufo") then
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
		end

		return capabilities
	end,
	---on_attach method shared by all language servers
	on_attach = function(client, bufnr)
		-- -- Setup navic
		-- local navic = M.require("nvim-navic")
		-- if navic and client.server_capabilities.documentSymbolProvider then
		-- 	navic.attach(client, bufnr)
		-- end
		--
		--   -- Setup navBuddy
		--   local navbuddy = M.require("nvim-navbuddy")
		--   if navbuddy then
		--     navbuddy.attach(client, bufnr)
		--   end
     
		-- if client.server_capabilities.documentFormattingProvider then
			M.keymap.set({
				{
					description = "Format code (lint)",
					cmd = function()
						-- Trim trailing white space first
						if not vim.o.binary and vim.o.filetype ~= "diff" and vim.bo.modifiable then
							vim.cmd([[%s/\s\+$//e]])
							vim.cmd("noh")
						end

						vim.lsp.buf.format({ async = true })
					end,
					keybindings = { "n", "<leader>sf" },
				},
			})
		-- end

		M.keymap.set({
			{
				description = "Show documentations (hover)",
				cmd = vim.lsp.buf.hover,
				keybindings = { "n", "K" },
			},
			{
				description = "Show errors of the current line (floating window)",
				cmd = vim.diagnostic.open_float,
				keybindings = { "n", "E" },
			},
			{
				description = "Go to the next diagnostic item",
				cmd = vim.diagnostic.goto_next,
				keybindings = {
					{ "n", "<leader>sen" },
					{ "n", "]d" },
				},
			},
			{
				description = "Go to the previous diagnostic item",
				cmd = vim.diagnostic.goto_prev,
				keybindings = {
					{ "n", "<leader>sep" },
					{ "n", "[d" },
				},
			},
			{
				description = "Show function signature",
				cmd = vim.lsp.buf.signature_help,
				keybindings = { "n", "<leader>sk" },
			},
			{
				description = "Go to declarations",
				cmd = vim.lsp.buf.declaration,
				keybindings = { "n", "<leader>sD" },
			},
			{
				description = "Rename symbol",
				cmd = vim.lsp.buf.rename,
				keybindings = { "n", "<leader>sn" },
			},
			-- Commands that take advantages of Telescope
			{
				description = "Show code actions",
				cmd = vim.lsp.buf.code_action,
				keybindings = {
					{ "n", "<leader>sa" },
					{ "v", "<leader>sa" },
				},
			},
			{
				description = "Go to definitions",
				cmd = "<CMD>Telescope lsp_definitions<CR>",
				keybindings = { "n", "<leader>sd" },
			},
			{
				description = "Go to type definitions",
				cmd = "<CMD>Telescope lsp_type_definitions<CR>",
				keybindings = { "n", "<leader>st" },
			},
			{
				description = "Show all references",
				cmd = "<CMD>Telescope lsp_references<CR>",
				keybindings = { "n", "<leader>sr" },
			},
			{
				description = "Show workspace errors (diagnostic)",
				cmd = "<CMD>Telescope diagnostics<CR>",
				keybindings = {
					{ "n", "<leader>se" },
					{ "n", "<leader>sef" },
				},
			},
			{
				description = "Go to implementations",
				cmd = "<CMD>Telescope lsp_implementations<CR>",
				keybindings = { "n", "<leader>si" },
				category = "lsp",
			},
			{
				description = "Show document symbols",
				cmd = "<CMD>Telescope lsp_document_symbols<CR>",
				keybindings = {
					{ "n", "<leader>ss" },
					{ "n", "<leader>ssd" },
				},
			},
			{
				description = "show workspace symbols",
				cmd = "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>",
				keybindings = { "n", "<leader>ssw" },
			},
		})
	end,
}

return setmetatable(M, { __index = vim.fn })
