local M = {}

local utils = require("heirline.utils")
local devicons = require("nvim-web-devicons")

local conditions = require("heirline.conditions")

local icons = require("settings.style").icons
local colors = require("settings.style").colors

local divider_secondary_left = {
	provider = "",
	hl = { fg = colors.statusline.snd_bg, bg = colors.statusline.trd_bg, bold = false },
}

local divider_secondary_right = {
	provider = "",
	hl = { fg = colors.statusline.snd_bg, bg = colors.statusline.trd_bg, bold = false },
}

local divider_trd_left = {
	provider = "",
	hl = { fg = colors.none, bg = colors.statusline.trd_bg, bold = false },
}

local divider_trd_right = {
	provider = "",
	hl = { fg = colors.none, bg = colors.statusline.trd_bg, bold = false },
}

local align = { provider = "%=" }

local mode = {
	init = function(self)
		self.mode = vim.fn.mode(1) -- :h mode()
	end,
	{
		provider = function(self)
			return " %2(" .. self.mode_names[self.mode] .. "%) "
		end,
		hl = function(self)
			local mode = self.mode:sub(1, 1) -- get only the first mode character
			return { fg = colors.statusline.trd_bg, bg = self.mode_colors[mode], bold = true }
		end,
	},
	{
		provider = "",
		hl = function(self)
			local mode = self.mode:sub(1, 1) -- get only the first mode character
			return { fg = self.mode_colors[mode], bg = colors.statusline.snd_bg }
		end,
	},
	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	},
	static = {
		mode_names = {
			n = "NORMAL",
			no = "NORMAL",
			nov = "NORMAL",
			noV = "NORMAL",
			["no\22"] = "NORMAL",
			niI = "NORMAL",
			niR = "NORMAL",
			niV = "NORMAL",
			nt = "NORMAL",
			v = "VISUAL",
			vs = "VISUAL",
			V = "VISUAL",
			Vs = "VISUAL",
			["\22"] = "VISUAL",
			["\22s"] = "VISUAL",
			s = "SELECT",
			S = "SELECT",
			["\19"] = "SELECT",
			i = "INSERT",
			ic = "INSERT",
			ix = "INSERT",
			R = "REPLACE",
			Rc = "REPLACE",
			Rx = "REPLACE",
			Rv = "REPLACE",
			Rvc = "REPLACE",
			Rvx = "REPLACE",
			c = "COMMAND",
			cv = "Ex",
			r = "...",
			rm = "M",
			["r?"] = "?",
			["!"] = "!",
			t = "TERM",
		},
	},
}

local filetype = {
	hl = { bg = colors.statusline.snd_bg },
	{
		provider = function(self)
			local ft = vim.bo.filetype
			local icon, color = devicons.get_icon_color("", ft, { default = true })

			self.color = color
			return " " .. icon .. " "
		end,
		hl = function(self)
			return { fg = self.color }
		end,
	},
	{
		provider = vim.bo.filetype .. " ",
		hl = { fg = colors.none },
	},
	divider_secondary_left,
}

local language_servers = {
	condition = conditions.lsp_attached,
	update = { "LspAttach", "LspDetach" },
	{
		provider = function(self)
			local names = {}
			for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
				table.insert(names, server.name)
			end
			return " " .. table.concat(names, ",") .. " "
		end,
		hl = { fg = colors.none, bg = colors.statusline.trd_bg },
	},
}

local diagnostics = {
	init = function(self)
		local diagnostics = vim.diagnostic.get(0)
		local count = { 0, 0, 0, 0 }
		for _, diagnostic in ipairs(diagnostics) do
			if vim.startswith(vim.diagnostic.get_namespace(diagnostic.namespace).name, "vim.lsp") then
				count[diagnostic.severity] = count[diagnostic.severity] + 1
			end
		end

		self.error_cnt = count[vim.diagnostic.severity.ERROR]
		self.warn_cnt = count[vim.diagnostic.severity.WARN]
		self.info_cnt = count[vim.diagnostic.severity.INFO]
		self.hint_cnt = count[vim.diagnostic.severity.HINT]
		self.has_diagnostics = self.error_cnt + self.warn_cnt + self.info_cnt + self.hint_cnt > 0
	end,
	hl = { bg = colors.statusline.trd_bg },
	{
		condition = function(self)
			return self.has_diagnostics
		end,
		divider_trd_left,
	},
	{
		condition = function(self)
			return self.error_cnt > 0
		end,
		provider = function(self)
			return " " .. icons.diagnostic.error .. self.error_cnt
		end,
		hl = { fg = colors.error },
	},
	{
		condition = function(self)
			return self.warn_cnt > 0
		end,
		provider = function(self)
			return " " .. icons.diagnostic.warning .. self.warn_cnt
		end,
		hl = { fg = colors.warn },
	},
	{
		condition = function(self)
			return self.info_cnt > 0
		end,
		provider = function(self)
			return " " .. icons.diagnostic.info .. self.info_cnt
		end,
		hl = { fg = colors.info },
	},
	{
		condition = function(self)
			return self.hint_cnt > 0
		end,
		provider = function(self)
			return " " .. icons.diagnostic.hint .. self.hint_cnt
		end,
		hl = { fg = colors.hint },
	},
}

local cursor_position = {
	init = function(self)
		self.mode = vim.fn.mode(1):sub(1, 1)
	end,
	{
		provider = "",
		hl = function(self)
			return { fg = self.mode_colors[self.mode], bg = colors.statusline.snd_bg }
		end,
	},
	{
		provider = " %l:%c ",
		hl = function(self)
			return { bg = self.mode_colors[self.mode], fg = colors.statusline.snd_bg }
		end,
	},
	update = { "ModeChanged" },
}

local progress = {
	init = function(self)
		self.mode = vim.fn.mode(1):sub(1, 1)
	end,
	divider_secondary_right,
	{
		provider = function(self)
			local curr_line = vim.api.nvim_win_get_cursor(0)[1]
			local lines = vim.api.nvim_buf_line_count(0)
			local progress = math.floor(curr_line / lines * 100)
			return " " .. progress .. "%% "
		end,
		hl = function(self)
			return { fg = self.mode_colors[self.mode], bg = colors.statusline.snd_bg }
		end,
	},
}

local git_status = {
	condition = conditions.is_git_repo,
	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
	end,
	hl = { bg = colors.statusline.trd_bg },
	{
		provider = function(self)
			local count = self.status_dict.added or 0
			return count > 0 and ("+" .. count .. " ")
		end,
		hl = { fg = colors.diff_add },
	},
	{
		provider = function(self)
			local count = self.status_dict.changed or 0
			return count > 0 and ("~" .. count .. " ")
		end,
		hl = { fg = colors.diff_change },
	},
	{
		provider = function(self)
			local count = self.status_dict.removed or 0
			return count > 0 and ("-" .. count .. " ")
		end,
		hl = { fg = colors.diff_remove },
	},
	{
		condition = function(self)
			return self.has_changes
		end,
		divider_trd_right,
	},
}

local git_branch = {
	condition = conditions.is_git_repo,
	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
	end,
	{
		provider = function(self)
			return " " .. icons.git.branch .. self.status_dict.head .. " "
		end,
		hl = { fg = colors.none, bg = colors.statusline.trd_bg },
	},
}

return {
	mode,
	filetype,
	language_servers,
	diagnostics,
	align,
	git_status,
	git_branch,
	progress,
	cursor_position,
	static = {
		mode_colors = {
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
		},
	},
}
