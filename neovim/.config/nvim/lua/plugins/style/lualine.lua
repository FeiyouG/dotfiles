local fn = require("settings.fn")
local style = require("settings.style")
local state = require("settings.state")

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	priority = 500,
	dependencies = {
		"kyazdani42/nvim-web-devicons",
		"lewis6991/gitsigns.nvim",
		"SmiteshP/nvim-navic",
	},
	config = function()
		local lualine = require("lualine")

		local diff_source = function()
			local gitsigns = vim.b.gitsigns_status_dict
			if gitsigns then
				return {
					added = gitsigns.added,
					modified = gitsigns.changed,
					removed = gitsigns.removed,
				}
			end
			return nil
		end

		local function submode_comp()
			local hydra = fn.require("hydra.statusline")
			if not hydra then
				return nil
			end

			return {
				hydra.get_name,
				cond = hydra.is_active,
			}
		end

		-- Get diff source from gitsigns
		local function filename_comp()
			return {
				"filename",
				file_status = false,
				newfile_status = true,
				path = 0,
				symbols = {
					modified = "[" .. style.icons.file.modified .. "]",
					readonly = "[" .. style.icons.file.readonly .. "]",
					unnamed = "[No Name]",
					newfile = "[New]",
				},
			}
		end

		local function diagnostic_comp()
			return {
				"diagnostics",
				sources = { "nvim_lsp" },
				symbols = {
					error = style.icons.diagnostic.error,
					warn = style.icons.diagnostic.warning,
					info = style.icons.diagnostic.info,
					hint = style.icons.diagnostic.hint,
				},
			}
		end

		local function diff_comp()
			return {
				"diff",
				source = diff_source,
				symbols = {
					added = style.icons.git.added_line,
					modified = style.icons.git.modified_line,
					removed = style.icons.git.deleted_line,
				},
				-- TODO: Update diff color
				-- diff_color = style.colors and style.colors.lualine.diff
			}
		end

		local function filetype_comp()
			return {
				"filetype",
				colored = true,
				icon_only = false,
				icon = { align = "left" },
			}
		end

		local function tabs_comp()
			return {
				"tabs",
				mode = 0,
				cond = function()
					return #vim.api.nvim_list_tabpages() > 1
				end,
			}
		end

		local function buffers_comp()
			return {
				"buffers",
				separator = "",
				symbols = {
					modified = "[" .. style.icons.file.modified .. "]", -- Text to show when the buffer is modified
					alternate_file = "", -- Text to show to identify the alternate file
					directory = style.icons.folder.open, -- Text to show when the buffer is a directory
				},
				cond = function()
					return state.show_tabs
				end,
			}
		end

		local function navic_comp()
			local navic = fn.require("nvim-navic")
			if not navic then
				return {}
			end

			return {
				navic.get_location,
				cond = navic.is_available,
			}
		end

		-- local function line_blame_comp()
		-- 	local gs = require("gitsigns")
		-- 	return {
		-- 		gs.blame_line({ full = true }),
		-- 	}
		-- end

		local function visual_selection_line_cnt_comp()
			return {
				function()
					local starts = vim.fn.line("v")
					local ends = vim.fn.line(".")
					local count = starts <= ends and ends - starts + 1 or starts - ends + 1
					return count .. "V"
				end,
				cond = function()
					return vim.fn.mode():find("[Vv]") ~= nil
				end,
			}
		end

		local function attached_lsp_comp()
			return {
				function()
					local lsp_names = ""
					local cnt = 1
					for _, client in pairs(vim.lsp.buf_get_clients()) do
						if client.name then
							if cnt > 1 then
								lsp_names = lsp_names .. "|"
							end
							lsp_names = lsp_names .. client.name
						end
						cnt = cnt + 1
					end
					return lsp_names
				end,
				cond = function()
					return vim.lsp.buf_get_clients() ~= nil
				end,
			}
		end

		lualine.setup({
			options = {
				theme = "onenord",
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				disabled_filetypes = {
					winbar = {
						"NvimTree",
						"DiffviewFiles",
						"dapui_watches",
						"dapui_scopes",
						"dapui_breakpoints",
						"dapui_stacks",
						"dapui_console",
						"dap-repl",
					},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { tabs_comp() },
				lualine_c = { "filetype", attached_lsp_comp(), diagnostic_comp() },
				lualine_x = { diff_comp(), "branch" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			winbar = {
				lualine_b = { filename_comp() },
				lualine_c = { navic_comp() },
				lualine_x = { "encoding" },
				lualine_y = { filetype_comp() },
			},
			inactive_winbar = {
				lualine_c = { filename_comp() },
			},
			tabline = {},
			-- extensions = { 'nvim-tree' }
		})
	end,
}
