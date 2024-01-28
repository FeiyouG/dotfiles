return {
	{
		"nvimtools/none-ls.nvim",
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
}
