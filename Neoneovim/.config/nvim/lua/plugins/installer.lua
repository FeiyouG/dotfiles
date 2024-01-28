return {
	{
		"williamboman/mason.nvim",
		-- event = { "VeryLazy" },
		opts = {
			ui = {
				border = settings.icons.editor.border.rounded_with_hl,
			},
			install_root_dir = settings.path.installer.home,
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		-- event = { "VeryLazy" },
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			automatic_installation = true,
		},
	},
	{
		"jayp0521/mason-null-ls.nvim",
		-- event = { "VeryLazy" },
		dependencies = {
			"williamboman/mason.nvim",
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
			"williamboman/mason.nvim",
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
			"williamboman/mason.nvim",
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
