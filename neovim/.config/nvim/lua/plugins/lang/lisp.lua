return {
	{ "gpanders/nvim-parinfer" },
	{
		"Olical/conjure",
		ft = {
			"clojure",
			"fennel",
			"jenet",
			"racket",
			"hy",
			"scheme",
			"cuile",
			"julia",
			"lisp",
			"rust",
			"lua",
			"python",
		},
		config = function()
			-- Disable some of the default mappings.
			vim.g["conjure#mapping#doc_word"] = "v:false"
			vim.g["conjure#mapping#eval_buf"] = "p"
			vim.g["conjure#filetypes"] = "['clojure', 'fennel', 'janet', 'hy', 'julia', 'racket', 'scheme', 'lisp']"

			-- Disable diagnostics in conjure log
			vim.api.nvim_create_autocmd("BufNewFile", {
				pattern = { "conjure-log-*" },
				callback = function()
					vim.diagnostic.disable(0)
				end,
				group = vim.api.nvim_create_augroup("DisableLspInConjureLog", { clear = true }),
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		depedencies = {
			"PaterJason/cmp-conjure",
		},
		opts = function(_, opts)
      -- settings.fn.safe_access(opts, "setup", "filetype")
			opts.setup = opts.setup or {}
      opts.setup.filetype = opts.setup.filetype or {}
			for _, ft in ipairs({ "racket", "scheme", "fennel" }) do
				opts.setup[ft] = opts.setup[ft] or {}
				opts.setup[ft][1] = vim.list_extend(opts.setup[ft][1] or {}, {
					"conjure",
				})
			end
			return opts

			-- local cmp = require("cmp")
			-- cmp.setup.filetype({ "racket", "scheme", "fennel" }, {
			-- 	sources = cmp.config.sources({
			-- 		{ name = "nvim_lsp" },
			-- 		{ name = "conjure" },
			-- 		{ name = "luasnip" },
			-- 		{ name = "path" },
			-- 		{ name = "calc" },
			-- 		{ name = "nerdfont" },
			-- 		{ name = "dictionary", max_item_count = 3 },
			-- 	}, {
			-- 		{ name = "buffer" },
			-- 		{ name = "tmux" },
			-- 		{ name = "nvim_lsp_signature_help" },
			-- 	}),
			-- })
		end,
	},
}
