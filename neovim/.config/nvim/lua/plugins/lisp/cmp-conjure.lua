return {
	"PaterJason/cmp-conjure",
	-- TODO: Conditionally load this plugin
	-- enabled = function()
	-- 	return require("lazy.core.config").plugins["cmp"]._.installed
	-- --[[ end ]],

	depedencies = {
		"hrsh7th/nvim-cmp",
	},
	config = function()
		local cmp = require("cmp")
		cmp.setup.filetype({ "racket", "scheme", "fennel" }, {
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "conjure" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "calc" },
				{ name = "nerdfont" },
				{ name = "dictionary", max_item_count = 3 },
			}, {
				{ name = "buffer" },
				{ name = "tmux" },
				{ name = "nvim_lsp_signature_help" },
			}),
		})
	end,
}
