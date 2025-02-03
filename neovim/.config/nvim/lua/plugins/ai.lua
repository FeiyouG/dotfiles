return {
	{
		"yetone/avante.nvim",
		-- event = "VeryLazy",
		lazy = false,
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"nvim-tree/nvim-web-devicons",
			-- "OXY2DEV/markview.nvim",

			{
				"OXY2DEV/markview.nvim",
				opts = {
					preview = {
						filetypes = { "md", "markdown", "norg", "rmd", "org", "vimwiki", "Avante" },
						max_length = 99999,
					},
				},
			},
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
		},
		opts = {
			file_selector = {
				provider = "telescope",
			},
			-- add any opts here
		},
	},
}
