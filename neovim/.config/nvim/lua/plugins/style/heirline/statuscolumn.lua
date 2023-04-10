local conditions = require("heirline.conditions")
local gitsigns = require("gitsigns")

local colors = require("settings.style").colors

local align = { provider = "%=" }
local spacer = { provider = " " }

local signs = {
	-- condition = function() return conditions.has_diagnostics() end,
	init = function(self)
		local signs = vim.fn.sign_getplaced(vim.api.nvim_get_current_buf(), {
			group = "*",
			lnum = vim.v.lnum,
		})

		if #signs == 0 or signs[1].signs == nil then
			self.sign = nil
			self.has_sign = false
			return
		end

		-- Filter out git signs
		signs = vim.tbl_filter(function(sign)
			return not vim.startswith(sign.group, "gitsigns")
		end, signs[1].signs)

		if #signs == 0 then
			self.sign = nil
		else
			self.sign = signs[1]
		end

		self.has_sign = self.sign ~= nil
		self.bufnr = vim.api.nvim_get_current_buf()
	end,
	provider = function(self)
		if self.has_sign then
			return vim.fn.sign_getdefined(self.sign.name)[1].text
		end
		return " "
	end,
	hl = function(self)
		if self.has_sign then
			if self.sign.group == "neotest-status" then
				local kws = vim.fn.split(self.sign.name, "_")
				if #kws == 2 then
					return "Neotest" .. string.upper(kws[2]:sub(1, 1)) .. kws[2]:sub(2, -1)
				end
				return "NeotestSkipped"
			elseif self.sign.group == "todo-signs" then
				local kws = vim.fn.split(self.sign.name, "-")
				if #kws == 3 then
					return "TodoFg" .. string.upper(kws[3])
				end
			end
			-- Everything else
			local hl = self.sign.name
			return (vim.fn.hlexists(hl) ~= 0 and hl)
		end
	end,
	on_click = {
		name = "sign_click",
		callback = function(self, ...)
			local lnum = self.move_cursor_to_mouse_line()

			vim.schedule(function()
				vim.diagnostic.open_float({
					bufnr = self.bufnr,
					scope = "line",
          pos = lnum -1
				})
			end)
		end,
	},
}

local line_numbers = {
	provider = function()
		if vim.v.virtnum ~= 0 then
			return ""
		end

		if vim.v.relnum == 0 then
			return vim.v.lnum
		end

		return vim.v.relnum
	end,
	on_click = {
		name = "line_number_click",
		callback = function(self, ...)
			local dap_avail, dap = pcall(require, "dap")
			if dap_avail then
				self.move_cursor_to_mouse_line()
				vim.schedule(dap.toggle_breakpoint)
			end
		end,
	},
}

local git_signs = {
	{
		condition = function()
			return not conditions.is_git_repo() or vim.v.virtnum ~= 0
		end,
		provider = "  ",
		hl = { fg = colors.gray },
	},
	{
		condition = function()
			return conditions.is_git_repo() and vim.v.virtnum == 0
		end,
		init = function(self)
			local signs = vim.fn.sign_getplaced(vim.api.nvim_get_current_buf(), {
				group = "gitsigns_vimfn_signs_",
				id = vim.v.lnum,
				lnum = vim.v.lnum,
			})

			if #signs == 0 or signs[1].signs == nil or #signs[1].signs == 0 or signs[1].signs[1].name == nil then
				self.sign = nil
			else
				self.sign = signs[1].signs[1]
			end

			self.has_sign = self.sign ~= nil
		end,
		provider = " ▏",
		hl = function(self)
			if self.has_sign then
				return self.sign.name
			end
			return { fg = colors.bg }
		end,
		on_click = {
			name = "gitsigns_click",
			callback = function(self, ...)
				local gitsigns_avail, gitsigns = pcall(require, "gitsigns")
				if gitsigns_avail then
					vim.schedule(gitsigns.preview_hunk)
				end
			end,
		},
	},
}

return {
	signs,
	align,
	line_numbers,
	git_signs,
	static = {
		move_cursor_to_mouse_line = function()
			local mouse_pos = vim.fn.getmousepos()
			local lnum = mouse_pos.line
			local curosr_pos = { lnum, 0 }
			vim.api.nvim_win_set_cursor(mouse_pos.winid, curosr_pos)
      return lnum
		end,
	},
}
