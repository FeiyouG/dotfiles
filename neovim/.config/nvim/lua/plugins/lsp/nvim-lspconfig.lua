return {
	"neovim/nvim-lspconfig",

	event = { "BufReadPre" },

	dependencies = {
		"williamboman/mason.nvim",
	},

	config = function()
		local fn = require("settings.fn")
		local style = require("settings.style")

		-- SECTION: Diagnostic Settings: diable virtual text
		vim.diagnostic.config({
			virtual_text = false,
      underline = true;
      sign = true,
			float = {
				scope = "line", -- "buffer", "line", or "cursor"
				source = true, -- true, "if_mnay", or false
			},
      update_in_insert = false,
      severity_sort = true,
		})

		-- SECTION: Config `lspInfo` floating window
		local windows = require("lspconfig.ui.windows")
		windows.default_options.border = style.border.rounded

		-- SECTION: Add boarder to hover --
		local lsp_util_open_floating_preview = vim.lsp.util.open_floating_preview

		---@diagnostic disable-next-line: duplicate-set-field
		vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = opts.border or style.border.rounded
			return lsp_util_open_floating_preview(contents, syntax, opts, ...)
		end

		-- SECTION: Change diagnostic symbol in signl column
		for type, icon in pairs({
			Error = style.icons.diagnostic.error,
			Warn = style.icons.diagnostic.warning,
			Hint = style.icons.diagnostic.hint,
			Info = style.icons.diagnostic.info,
		}) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		-- SECTION: Setup Servers
		local lspconfig = require("lspconfig")

		-- initialize servers
		local servers = require("plugins.lsp.servers").nvim_lspconfig
		for server, server_config in pairs(servers) do
			-- Setup common server configs
			server_config.capabilities =
				vim.tbl_extend("force", fn.lsp.get_capabilities(), server_config.capabilities or {})

			-- Add common logics to on_attach functions
			local server_on_attach = server_config.on_attach
			server_config.on_attach = function(client, bufnr)
				-- Inject common on_attach logic
				fn.lsp.on_attach(client, bufnr)

				-- Execute server-specific on_attach if there is one
				if fn.is_callable(server_on_attach) then
					server_on_attach(client, bufnr)
				end
			end

			-- Setup
			lspconfig[server].setup(server_config)
		end

	end,
}
