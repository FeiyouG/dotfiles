return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = {
			require("null-ls").builtins.diagnostics.hadolint,
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts.docker_compose_language_service = {}
      opts.dockerls = {}
			return opts
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
				"go",
				"gomod",
			})
			return opts
		end,
	},
}
