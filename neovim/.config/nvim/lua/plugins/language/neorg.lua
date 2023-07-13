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
				["core.keybinds"] = {
					-- config = {
					--        hook = function(keybinds)
					--        end
					-- },
				},
				["core.looking-glass"] = {},
				["core.esupports.hop"] = {},
				["core.esupports.indent"] = {},
				["core.esupports.metagen"] = {},
				["core.journal"] = {},
				["core.qol.toc"] = {},
				["core.qol.todo_items"] = {},
				["core.promo"] = {},
				["core.tangle"] = {},
				["core.upgrade"] = {},
				-- Other modules
				["core.concealer"] = {
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
							-- definition = { enabled = false },
							-- footnote = { enabled = false },
							-- heading = { enabled = true },
							-- list = { enabled = true },
							-- markup = {
							-- 	enabled = true,
							-- 	-- spoiler = {
							-- 	-- 	enabled = true,
							-- 	-- 	icon = "*",
							-- 	-- },
							-- },
							-- ordered = {
							-- 	level_1 = {
							-- 		icon = function(count)
							-- 			return count .. ""
							-- 		end,
							-- 	},
							-- },
							-- quote = { enabled = true },
							todo = {
								uncertain = {
									enabled = false,
									icon = "?",
								},
							},
						},
					},
				},
				-- integrations
				["core.integrations.treesitter"] = {},
			},
		})

		require("settings.fn").keymap.set({
			{
				desc = "Format neorg file (if no lsp present)",
				keys = { "n", "<leader>sf" },
				cmd = function()
					-- Trim trailing white space first
					if not vim.o.binary and vim.o.filetype ~= "diff" and vim.bo.modifiable then
						vim.cmd([[%s/\s\+$//e]])
						vim.cmd("noh")
					end

					local cursor_pos = vim.api.nvim_win_get_cursor(0)
					vim.cmd.normal("gg=G")
					vim.api.nvim_win_set_cursor(0, cursor_pos)
				end,
			},
		})
	end,
}
