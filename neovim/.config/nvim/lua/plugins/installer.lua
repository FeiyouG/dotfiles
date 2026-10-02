return {
	{
		"mason-org/mason.nvim",
		-- event = { "VeryLazy" },
		opts = {
			ui = {
				border = settings.icons.editor.border.rounded_with_hl,
			},
			install_root_dir = settings.path.installer.home,
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = function(_, opts)
			-- Install every server configured via nvim-lspconfig opts in plugins/lang/*.lua
			local lspconfig = require("lazy.core.config").spec.plugins["nvim-lspconfig"]
			local servers = vim.tbl_keys(require("lazy.core.plugin").values(lspconfig, "opts", false))
			opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, servers)
			-- lsp.lua already calls vim.lsp.enable(); rust-analyzer is started by rustaceanvim
			opts.automatic_enable = false
			return opts
		end,
	},
	{
		"jayp0521/mason-null-ls.nvim",
		-- event = { "VeryLazy" },
		dependencies = {
			"mason-org/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		opts = {
			automatic_installation = true,
		},
	},
	{
		"jayp0521/mason-nvim-dap.nvim",
		-- event = { "VeryLazy" },
		dependencies = {
			"mason-org/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			automatic_installation = true,
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- event = { "VeryLazy" },
		dependencies = {
			"mason-org/mason.nvim",
		},
		opts = {
			ensure_installed = {
				"java-test",
				"java-debug-adapter",
			},
			run_on_start = true,
			start_delay = 1500, -- 1.5 second delay
		},
	},
}
