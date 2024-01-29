return {
	{
		"nvimtools/none-ls.nvim",
		opts = function(_, opts)
			return vim.list_extend(opts, {
				require("null-ls").builtins.diagnostics.hadolint,
			})
		end
	},
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts.docker_compose_language_service = {}
			opts.dockerls = {}
			return opts
		end,
	},
}
