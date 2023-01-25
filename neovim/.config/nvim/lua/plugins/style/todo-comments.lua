return {
	"folke/todo-comments.nvim",

	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local style = require("settings.style")

		local keywords = {
			FIX = {
				icon = style.icons.test.fix, -- icon used for the sign, and in search results
				color = "error", -- can be a hex color, or a named color (see below)
				alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
				-- signs = false, -- configure signs for some keywords individually
			},
			BUG = { icon = style.icons.debug.bug, color = "error", alt = { "ISSUE" } },
			TODO = { icon = style.icons.comment.todo, color = "info" },
			HACK = { icon = style.icons.comment.hack, color = "warning" },
			WARN = { icon = style.icons.diagnostic.warning, color = "warning", alt = { "WARNING", "XXX" } },
			PERF = { icon = style.icons.comment.optimized, alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			NOTE = { icon = style.icons.comment.note, color = "info", alt = { "NOTES", "INFO" } },
			TEST = { icon = style.icons.test.test, color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			SEC = { icon = style.icons.comment.bookmark, color = "default", alt = { "MARK", "SECTION" } },
		}
		require("todo-comments").setup({
			signs = true, -- show icons in the signs column
			sign_priority = 8, -- sign priority

			-- keywords recognized as todo comments
			keywords = keywords,

			gui_style = {
				fg = "NONE", -- The gui style to use for the fg highlight group.
				bg = "BOLD", -- The gui style to use for the bg highlight group.
			},

			merge_keywords = false, -- when true, custom keywords will be merged with the defaults
			-- highlighting of the line containing the todo comment
			-- * before: highlights before the keyword (typically comment characters)
			-- * keyword: highlights of the keyword
			-- * after: highlights after the keyword (todo text)
			highlight = {
				multiline = true, -- enable multine todo comments
				multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
				multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
				before = "", -- "fg" or "bg" or empty
				keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
				after = "fg", -- "fg" or "bg" or empty
				pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
				comments_only = true, -- uses treesitter to match keywords in comments only
				max_line_len = 400, -- ignore lines longer than this
				exclude = {}, -- list of file types to exclude highlighting
			},
			-- list of named colors where we try to extract the guifg from the
			-- list of highlight groups or use the hex color if hl not found as a fallback
			colors = {
				error = { "DiagnosticError", "#BF616A" },
				warning = { "DiagnosticlWarning", "#D08F70" },
				info = { "DiagnosticInfo", "#A3BE8C" },
				hint = { "DiagnosticHint", "#B988B0" },
				default = { "NormalMode", "#88C0D0" },
				test = { "CommandMode", "#EBCB8B" },
			},
			search = {
				command = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				-- regex that will be used to match keywords.
				-- don't replace the (KEYWORDS) placeholder
				pattern = [[\b(KEYWORDS):]], -- ripgrep regex
				-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
			},
		})

		require("settings.fn").keymap.set({
			{
				desc = "Show all TODO comments in telescope",
				cmd = "<CMD>TodoTelescope<CR>",
				keys = { "n", "<leader>ft" },
			},
			{
				desc = "Show all TODO comments in trouble",
				cmd = "<CMD>TodoTrouble<CR>",
				keys = { "n", "<leader>xt" },
			},
		})
	end,
}
