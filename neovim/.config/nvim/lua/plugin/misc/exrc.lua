return {

  'MunifTanjim/exrc.nvim',
	-- "MunifTanjim/nui.nvim",

	commands = function()
		-- disable built-in local config file support
		vim.o.exrc = false

		require("exrc").setup({
			files = {
				".nvimrc.lua",
				".nvimrc",
				".exrc.lua",
				".exrc",
			},
		})
	end,
}
