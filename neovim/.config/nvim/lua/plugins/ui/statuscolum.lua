local function get_signs_on_line(lnum)
	return vim.api.nvim_buf_get_extmarks(
		vim.api.nvim_get_current_buf(),
		-1,
		{ lnum - 1, 0 }, -- vim line number is 0 indexed
		{ lnum - 1, -1 },
		{
			details = true,
			hl_name = true,
			type = "sign",
			overlap = true,
		}
	)
end

local function get_sign_with_highest_priority(signs)
	local highest_sign = nil
	for _, sign in ipairs(signs) do
		if sign[4].priority >= (sign and sign[4].priority or 0) then
			highest_sign = sign
		end
	end
	return highest_sign
end

return {
	"rebelot/heirline.nvim",
	opts = function(_, opts)
		local conditions = require("heirline.conditions")
		local icons = settings.icons

		local align = { provider = "%=" }

		--- diagnostic signs
		local signs = {
			init = function(self)
				local signs = vim.tbl_filter(function(sign)
					return sign[4] ~= nil
						and sign[4].sign_hl_group ~= nil
						and sign[4].sign_text ~= nil
						and not string.find(sign[4].sign_hl_group, "GitSigns") -- filter out git signs
				end, get_signs_on_line(vim.v.lnum) or {})

				local sign = get_sign_with_highest_priority(signs)

				if sign ~= nil then
					self.sign = {
						hl_group = sign[4].sign_hl_group,
						icon = sign[4].sign_text,
					}
				else
					self.sign = nil
				end

				self.has_sign = self.sign ~= nil
				self.bufnr = vim.api.nvim_get_current_buf()
			end,

			provider = function(self)
				return self.sign and self.sign.icon or " "
			end,

			hl = function(self)
				return self.sign and self.sign.hl_group or nil -- TODO:
			end,
		}

		local folds = {
			condition = function()
				return vim.v.virtnum == 0
			end,
			init = function(self)
				self.lnum = vim.v.lnum
				self.folded = vim.fn.foldlevel(self.lnum) > vim.fn.foldlevel(self.lnum - 1)
			end,
			{
				condition = function(self)
					return self.folded
				end,
				provider = function(self)
					if vim.fn.foldclosed(self.lnum) == -1 then
						return settings.icons.editor.statuscolumn.folds_open
					else
						return settings.icons.editor.statuscolumn.folds_closed
					end
				end,
				hl = function(self)
					if vim.fn.foldclosed(self.lnum) == -1 then
						return "StatusColumnUnfoldedIcon"
					else
						return "StatusColumnFoldedIcon"
					end
				end,
			},
			{
				condition = function(self)
					return not self.folded
				end,
				provider = " ",
			},
			on_click = {
				name = "fold_click",
				callback = function(self, ...)
					local args = self.click_args(self, ...)
					local lnum = args.mousepos.line
					if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
						return
					end
					vim.cmd.execute(
						"'" .. lnum .. "fold" .. (vim.fn.foldclosed(lnum) == -1 and "close" or "open") .. "'"
					)
				end,
			},
		}

		local line_numbers = {
			init = function(self)
				self.mode = vim.fn.mode(1):sub(1, 1)
			end,
			provider = function()
				if vim.v.virtnum ~= 0 then
					return ""
				end

				if vim.v.relnum == 0 then
					return vim.v.lnum
				end

				return vim.v.relnum
			end,
		}

		local git = {
			{
				condition = function()
					return not conditions.is_git_repo() or vim.v.virtnum ~= 0
				end,
				provider = "  ",
				hl = "GitSignsNoChange",
			},
			{
				condition = function()
					return conditions.is_git_repo() and vim.v.virtnum == 0
				end,
				init = function(self)
					local sign = vim.tbl_filter(function(sign)
						return sign[4] ~= nil
							and sign[4].sign_hl_group ~= nil
							and sign[4].sign_text ~= nil
							and string.find(sign[4].sign_hl_group, "GitSigns") ~= nil -- filter git signs
					end, get_signs_on_line(vim.v.lnum) or {})[1]

					if sign ~= nil then
						self.sign = {
							hl_group = sign[4].sign_hl_group,
							icon = icons.editor.statuscolumn.gitsigns,
						}
					else
						self.sign = nil
					end
				end,
				provider = function(self)
					return self.sign and self.sign.icon or "  "
				end,

				hl = function(self)
					return self.sign and self.sign.hl_group or "GitSignsNoChange"
				end,

				on_click = {
					name = "gitsigns_click",
					callback = function(self, ...)
						local gitsigns = require("gitsigns")
						local _ = self.click_args(self, ...)
						vim.schedule(gitsigns.preview_hunk)
					end,
				},
			},
		}

		opts.statuscolumn = {
			signs,
			align,
			line_numbers,
			folds,
			git,
			static = {
				move_cursor_to_mouse_line = function()
					local mouse_pos = vim.fn.getmousepos()
					local lnum = mouse_pos.line
					local curosr_pos = { lnum, 0 }
					vim.api.nvim_win_set_cursor(mouse_pos.winid, curosr_pos)
					return lnum
				end,

				click_args = function(self, minwid, clicks, button, mods)
					local args = {
						minwid = minwid,
						clicks = clicks,
						button = button,
						mods = mods,
						mousepos = vim.fn.getmousepos(),
					}
					vim.api.nvim_set_current_win(args.mousepos.winid)
					vim.api.nvim_win_set_cursor(0, { args.mousepos.line, 0 })

					return args
				end,
			},
		}

		return opts
	end,
}
