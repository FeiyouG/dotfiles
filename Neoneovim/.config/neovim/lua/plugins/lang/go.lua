return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = {
			require("null-ls").builtins.formatting.gofumpt,
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts.gopls = {
				cmd = { "gopls", "serve" },
				filetypes = { "go", "gomod" },
				root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				},
			}
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
