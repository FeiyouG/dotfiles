return {
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts.yamlls = {}
			return opts
		end,
	},
}
