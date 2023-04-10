return {
	"rmehri01/onenord.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local colors = require("onenord.colors").load()
		require("settings.style").colors = colors

		require("onenord").setup({
			theme = "dark",
			fade_nc = false,
			styles = {
				comments = "italic",
				diagnostics = "undercurl",
			},
			inverse = {
				match_paren = false,
			},
			custom_colors = {
				orange_bg = "#735538",
				light_purple_bg = "#693e54",
				cyan_bg = "#46626e",
			},
			custom_highlights = {
				-- Editor
				WinSeparator = { fg = colors.blue, bg = colors.active },
				NormalFloat = { fg = colors.fg, bg = colors.bg },
				FloatBorder = { fg = colors.blue, bg = colors.bg },
				WinBar = { fg = colors.fg, bg = colors.active },

				-- Override for nvim-cmp
				CmpItemAbbrMatch = { fg = colors.yellow, style = "bold" },
				CmpItemAbbrMatchFuzzy = { fg = colors.yellow, underline = true },

				-- Override for git sign
				GitSignsAddLn = { bg = colors.diff_add_bg },
				GitSignsChangeLn = { bg = colors.diff_change_bg },
				GitSignsDeleteLn = { bg = colors.diff_remove_bg },

				-- For nvim-dap
				DapBreakpoint = { fg = colors.red },
				DapBreakpointLine = { bg = colors.diff_remove_bg },
				DapBreakpointCondition = { fg = colors.orange },
				DapBreakpointConditionLine = { bg = colors.orange_bg },
				DapBreakpointRejected = { fg = colors.gray },
				DapBreakpointRejectedLine = {},
				DapLogPoint = { fg = colors.light_purple },
				DapLogPointLine = { bg = colors.light_purple_bg },
				DapStopped = { fg = colors.cyan },
				DapStoppedLine = { bg = colors.cyan_bg },

				-- nvim-ufo
				UfoFoldedBg = { fg = colors.gray, bg = colors.none, style = "underline" },
				UfoFoldedEllipsis = { fg = colors.light_gray, style = "italic" },
			},
		})

		colors.statusline = {
			snd_bg = colors.highlight_dark,
			trd_bg = colors.active,
		}

		colors.mode = {
			n = colors.blue,
			i = colors.green,
			v = colors.cyan,
			V = colors.cyan,
			["\22"] = colors.cyan,
			c = colors.orangne,
			s = colors.pink,
			S = colors.pink,
			["\19"] = colors.pink,
			R = colors.yellow,
			r = colors.yellow,
			["!"] = colors.red,
			t = colors.purple,
		}
	end,
}
