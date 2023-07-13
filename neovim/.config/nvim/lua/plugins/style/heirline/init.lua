return {
	"rebelot/heirline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"rmehri01/onenord.nvim",
		"SmiteshP/nvim-navic",
		"lewis6991/gitsigns.nvim",
	},
	config = function()
		local heirline = require("heirline")

		local statusline = require("plugins.style.heirline.statusline")
		local statuscolumn = require("plugins.style.heirline.statuscolumn")
		local winbar = require("plugins.style.heirline.winbar")

		heirline.setup({
			statusline = statusline,
			statuscolumn = statuscolumn,
		})

		-- Temporary fix for winbar in nvim 0.9
		require("heirline").winbar = require("heirline.statusline"):new(winbar)
		vim.opt.winbar = "%{%v:lua.require'heirline'.eval_winbar()%}"
	end,
}
