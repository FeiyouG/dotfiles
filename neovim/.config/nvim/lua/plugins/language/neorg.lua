return {
	"nvim-neorg/neorg",
	dependencies = { { "nvim-lua/plenary.nvim" } },
	run = ":Neorg sync-parsers", -- This is the important bit!
	config = function()
		require("neorg").setup({
			load = {
				-- Core modules
				["core.clipboard.code-blocks"] = {},
				["core.itero"] = {},
				["core.keybinds"] = {},
				["core.looking-glass"] = {},
				["core.norg.esupports.hop"] = {},
				["core.norg.esupports.indent"] = {},
				["core.norg.esupports.metagen"] = {},
				["core.norg.journal"] = {},
				["core.norg.news"] = {},
				["core.norg.qol.toc"] = {},
				["core.norg.qol.todo_items"] = {},
				["core.promo"] = {},
				["core.tangle"] = {},
				["core.upgrade"] = {},

				-- Other modules
				["core.norg.concealer"] = {
					config = {
						dim_code_blocks = {
							adaptive = true,
							conceal = false,
							content_only = false,
							enabled = true,
							width = "content",
						},
						icon_preset = "diamond",
						icons = {
							definition = { enabled = false },
							footnote = { enabled = false },
							heading = { enabled = true },
							list = { enabled = true },
							markup = {
								enabled = true,
								-- spoiler = {
								-- 	enabled = true,
								-- 	icon = "*",
								-- },
							},
							ordered = { enabled = true },
							quote = { enabled = true },
						},
					},
				},

				-- integrations
				["core.integrations.treesitter"] = {},
			},
		})
	end,
}
