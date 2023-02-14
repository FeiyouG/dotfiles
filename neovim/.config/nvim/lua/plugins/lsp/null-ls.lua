return {
	"jose-elias-alvarez/null-ls.nvim",

	event = { "BufReadPre" },

	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- SECTION: Golang
				-- null_ls.builtins.diagnostics.revive,
				null_ls.builtins.formatting.gofumpt,

				-- SECTION: Lua
				null_ls.builtins.formatting.stylua,

				-- SECTION: Python
				-- null_ls.builtins.diagnostics.flake8,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.black,

				-- SECTION: Javascript
				null_ls.builtins.formatting.prettier.with({
					filetype = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"css",
						"html",
						"json",
						"jsonc",
						"yaml",
					},
				}),

				-- SECTION: Ocaml
				null_ls.builtins.formatting.ocamlformat,

				-- SECTION: Racket
				null_ls.builtins.formatting.raco_fmt,

				-- SECTION: Latex
				-- null_ls.builtins.diagnostics.chktex,
				null_ls.builtins.formatting.latexindent,
			},
		})
	end,
}
