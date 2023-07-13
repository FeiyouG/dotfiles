return {
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts.lemminx = {
				settings = {
					xml = {
						server = {
							workDir = settings.path.xml.lemminx_cache,
						},
					},
				},
			}
      return opts
    end
	},
}
