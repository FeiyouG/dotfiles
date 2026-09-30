return {
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvimtools/none-ls-extras.nvim",
		},
		config = function(_, sources)
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = sources,
				on_attach = settings.fn.lsp.on_attach,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function(_, opts)
			vim.lsp.set_log_level("debug")
			-- Config `lspInfo` floating window
			local windows = require("lspconfig.ui.windows")
			windows.default_options.border = settings.icons.editor.border.rounded_with_hl

			-- Setup Servers
			-- local lspconfig = require("lspconfig")

			-- initialize servers
			for server, server_config in pairs(opts) do
				server_config.capabilities =
					vim.tbl_extend("force", settings.fn.lsp.get_capabilities(), server_config.capabilities or {})

				-- add common logics to on_attach functions
				local server_on_attach = server_config.on_attach

				server_config.on_attach = function(client, bufnr)
					settings.fn.lsp.on_attach(client, bufnr)

					-- execute server-specific on_attach if there is one
					if settings.fn.is_callable(server_on_attach) then
						server_on_attach(client, bufnr)
					end
				end

				-- setup
				vim.lsp.config(server, server_config)
				vim.lsp.enable(server)
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					local buf = args.buf
					if client then
						settings.fn.lsp.on_attach(client, buf)
					end
				end,
			})
		end,
	},
}
