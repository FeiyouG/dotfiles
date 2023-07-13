return {
	name = "draw",
	icon = " ",
	key = "a",
	color = "pink",
	mode = { "n", "x" },
	on_enter = function()
		vim.opt.virtualedit = "all"
	end,
	commands = function()
		return {
			{
				cmd = "<C-v>j:VBox<CR>",
				keys = { "n", "J" },
			},
			{
				cmd = "<C-v>k:VBox<CR>",
				keys = { "n", "K" },
			},
			{
				cmd = "<C-v>l:VBox<CR>",
				keys = { "n", "L" },
			},
			{
				cmd = "<C-v>h:VBox<CR>",
				keys = { "n", "H" },
			},
			{
				cmd = "<CMD>VBox<CR>",
				keys = { "n", "B" },
			},
		}
	end,
}
