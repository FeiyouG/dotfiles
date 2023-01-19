local M = {}

-- Whether tabpages are shown
M.show_tabs = false

-- Quit on q
local quit_on_q_ft = { "nofile", "quickfix", "prompt" }

M.quit_on_q = {
	add_ft = function(filetypes)
		if type(filetypes) ~= "table" then
			filetypes = { filetypes }
		end

		vim.list_extend(quit_on_q_ft, filetypes)
	end,

	contains_ft = function(ft)
		return vim.tbl_contains(quit_on_q_ft, ft)
	end,
}


return M
