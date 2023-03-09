local fn = require("settings.fn")
local state = require("settings.state")
return {
	"rcarriga/nvim-notify",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local notify = require("notify")
		notify.setup({
			level = vim.log.levels.INFO,
			background_colour = "#2E3440",
			stages = "fade_in_slide_out",
			minimum_width = 20,
			timeout = 5000,
		})
		vim.notify = notify

		local telescope = fn.require("telescope")
		if telescope then
			telescope.load_extension("notify")
		end

		state.quit_on_q.add_ft({ "notify" })

		fn.keymap.set({
			{
				desc = "Show notification history",
				cmd = "<CMD>Telescope notify<CR>",
				cat = "nvim-notify",
			},
			{
				desc = "Dismiss notifcations",
				cmd = require("notify").dismiss,
				cat = "nvim-notify",
			},
		})
	end,
}
