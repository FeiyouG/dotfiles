return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"folke/trouble.nvim",
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-dap.nvim",
				config = function()
					require("telescope").load_extension("dap")
				end,
			},
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				config = function()
					require("telescope").load_extension("fzf")
				end,
			},
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local trouble = require("trouble.providers.telescope")

			telescope.setup({
				defaults = {
					layout_strategy = "flex",
					mappings = {
						n = {
							["q"] = actions.close,
							["<Esc>"] = actions.close,
							["<C-n>"] = actions.move_selection_next,
							["<C-p>"] = actions.move_selection_previous,
							["<C-t>"] = actions.select_tab,
							["<C-f>"] = actions.preview_scrolling_up,
							["<C-b>"] = actions.preview_scrolling_down,
							["<C-q>"] = trouble.open_with_trouble,
						},
						i = {
							["<Esc>"] = actions.close,
							["<C-u>"] = false, -- Clear the prompt
							["<C-s>"] = actions.select_horizontal,
							["<C-t>"] = actions.select_tab,
							["<C-f>"] = actions.preview_scrolling_up,
							["<C-b>"] = actions.preview_scrolling_down,
							["<C-q>"] = trouble.open_with_trouble,
						},
					},
					file_ignore_patterns = {
						"node_modules",
					},
				},
				pickers = {
					lsp_code_actions = {
						theme = "cursor",
					},
				},
			})

			vim.keymap.set("n", "<leader>ff", "<CMD>Telescope find_files<CR>", { desc = "Find files" })
			-- settings.fn.keymap.set({
			--   {
			--     desc = "Find hidden files",
			--     cmd = "<CMD>Telescope find_files hidden=true<CR>",
			--   },
			--   {
			--     desc = "Show recent files",
			--     cmd = "<CMD>Telescope oldfiles<CR>",
			--   },
			--   {
			--     desc = "Show all commands",
			--     cmd = "<CMD>Telescope commands<CR>",
			--   },
			--   {
			--     desc = "Show command history",
			--     cmd = "<CMD>Telescope command_history<CR>",
			--   },
			--   {
			--     desc = "Show search history (vimgrep)",
			--     cmd = "<CMD>Telescope search_history<CR>",
			--   },
			--   {
			--     desc = "Show marks",
			--     cmd = "<CMD>Telescope marks<CR>",
			--   },
			--   {
			--     desc = "Switch colorschemes",
			--     cmd = "<CMD>Telescope colorscheme<CR>",
			--   },
			--   {
			--     desc = "Show jumplist",
			--     cmd = "<CMD>Telescope jumplist<CR>",
			--   },
			--   {
			--     desc = "Edit vim options",
			--     cmd = "<CMD>Telescope vim_options<CR>",
			--   },
			--   {
			--     desc = "Show autocommands",
			--     cmd = "<CMD>Telescope autocommands<CR>",
			--   },
			--   {
			--     desc = "Show telescope builtin commands",
			--     cmd = "<CMD>Telescope builtin<CR>",
			--   },
			--
			--   -- Git Pickers
			--   {
			--     desc = "Show workspace git commits",
			--     cmd = "<CMD>Telescope git_commits<CR>",
			--   },
			--   {
			--     desc = "Show git branches",
			--     cmd = "<CMD>Telescope <CR>",
			--   },
			--   {
			--     desc = "Show git stash",
			--     cmd = "<CMD>Telescope git_stash<CR>",
			--   },
			-- })

			vim.list_extend(settings.ft.exclude_winbar.filetype, {
				"TelescopePrompt",
				"TelescopeResults",
			})
		end,
	},
	{
		"axieax/urlview.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("urlview").setup({
				default_picker = "telescope",
				default_prefix = "https://",
				default_action = "system",
				unique = true,
				sorted = true,
				jump = {
					["prev"] = "[u",
					["next"] = "]u",
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>fu", "<Cmd>UrlView<CR>", { desc = "Show all buffer links" })
			vim.keymap.set({ "n", "v" }, "<leader>fub", "<Cmd>UrlView<CR>", { desc = "Show all buffer links" })
			vim.keymap.set({ "n", "v" }, "<leader>fup", "<Cmd>UrlView lazy<CR>", { desc = "Show all plugin links" })
		end,
	},

	-- {
	--   "git@github.com:FeiyouG/command_center.nvim.git",
	--   dev = true,
	--   priority = settings.priority.HIGH,
	--   dependencies = {
	--     "nvim-telescope/telescope.nvim",
	--   },
	--   config = function()
	--     local commander = require("commander")
	--     commander.setup({
	--       components = {
	--         commander.component.DESC,
	--         commander.component.KEYS,
	--         commander.component.CAT,
	--       },
	--       sort_by = {
	--         commander.component.DESC,
	--         commander.component.CAT,
	--         commander.component.KEYS,
	--         commander.component.CMD,
	--       },
	--       auto_replace_desc_with_cmd = true,
	--       telescope = {
	--         integrate = true,
	--         theme = require("telescope.themes").commander,
	--       },
	--     })
	--
	--     settings.fn.keymap.set({
	--       {
	--         desc = "Open Commander",
	--         cmd = "<CMD>Telescope commander<CR>",
	--         keys = {
	--           -- If ever hesitate when using telescope start with <leader>f,
	--           -- also open command center
	--           { { "n", "x" }, "<Leader>f" },
	--           { { "n", "x" }, "<Leader>fc" },
	--         },
	--       },
	--     })
	--   end,
	-- },
}
