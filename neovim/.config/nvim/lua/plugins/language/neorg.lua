return {
	"nvim-neorg/neorg",
	dependencies = { { "nvim-lua/plenary.nvim" } },
	run = ":Neorg sync-parsers", -- This is the important bit!
	config = function()
		require("neorg").setup({
			-- load = {
			-- 	["core.clipboard.code-blocks"] = {},
			-- 	["core.itero"] = {},
			-- 	["core.keybinds"] = {
			-- 		config = {
			-- 			-- hook = function(keybinds)
			-- 			--         keybinds.remap("norg", "i", "<C-y>", "core.itero")
			-- 			--       end,
			-- 		},
			-- 	},
			-- 	["core.looking-glass"] = {},
			-- 	["core.norg.esupports.hop"] = {},
			-- 	["core.norg.esupports.indent"] = {},
			-- 	["core.norg.esupports.metagen"] = {},
			-- 	["core.norg.journal"] = {},
			-- 	["core.norg.news"] = {},
			-- 	["core.norg.qol.toc"] = {},
			-- 	["core.norg.qol.todo_items"] = {},
			-- 	["core.promo"] = {},
			-- 	["core.tangle"] = {},
			-- 	["core.upgrade"] = {},
			-- 	["core.integrations.treesitter"] = {},
			-- },
			load = {
				["core.defaults"] = {},
        ["core.norg.concealer"] = {}
			},
		})
	end,
}
