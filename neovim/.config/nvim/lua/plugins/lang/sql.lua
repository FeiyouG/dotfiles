return {
	{
		"nvimtools/none-ls.nvim",
		opts = function(_, opts)
			return vim.list_extend(opts, {
				require("null-ls").builtins.diagnostics.sqlfluff.with({
					extra_args = { "--dialect", "postgres" },
				}),
				require("null-ls").builtins.formatting.sqlfluff.with({
					extra_args = { "--dialect", "postgres" },
				}),
			})
		end,
	},
}
