return {
	icons = require("settings.style.icons"),
	colors = require("settings.style.colors"),

	border = {
		rounded = {
			{ "╭", "FloatBorder" },
			{ "─", "FloatBorder" },
			{ "╮", "FloatBorder" },
			{ "│", "FloatBorder" },
			{ "╯", "FloatBorder" },
			{ "─", "FloatBorder" },
			{ "╰", "FloatBorder" },
			{ "│", "FloatBorder" },
		},
		winblend = 0,
		-- winhighlight = "FloatBorder:TelescopePromptBorder,CursorLine:TelescopeSelection,Search:None",
		winhighlight = "FloatBorder:FloatBorder,CursorLine:TelescopeSelection,Search:None",
	},
}
