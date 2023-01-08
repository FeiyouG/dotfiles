---- MARK: Restore Last Cursor Position ----
local restoreCursorPosition = vim.api.nvim_create_augroup("RestoreCursorPosition", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = { "*" },
	callback = function()
		-- Marks are (1,0) indexed
		local cursor_pos = vim.api.nvim_buf_get_mark(0, '"')
		if cursor_pos[1] >= 0 and cursor_pos[1] <= 0 then
			vim.api.nvim_cmd("normal! g'\"")
		end
	end,
	group = restoreCursorPosition,
})

---- MARK: Trim Trailling Whitespaces ----
-- local trimWhiteSpace = vim.api.nvim_create_augroup("TrimWhiteSpace", { clear = true })
--
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = { "*" },
-- 	callback = function()
-- 		if not vim.o.binary and vim.o.filetype ~= "diff" and vim.bo.modifiable then
-- 			vim.cmd([[%s/\s\+$//e]])
-- 		end
-- 	end,
-- 	group = trimWhiteSpace,
-- })

---- MARK: Automatically Switch Between Relative and Asbolute Line Number ----
local toggleLineNumberOnInsert = vim.api.nvim_create_augroup("ToggleLineNumberOnInsert", { clear = true })

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	pattern = { "*" },
	callback = function()
		if vim.opt.number._value then
			vim.opt.relativenumber = false
		end
	end,
	group = toggleLineNumberOnInsert,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	pattern = { "*" },
	callback = function()
		if vim.opt.number._value then
			vim.opt.relativenumber = true
		end
	end,
	group = toggleLineNumberOnInsert,
})

local toggleLineNumberOnFocus = vim.api.nvim_create_augroup("ToggleLineNumberOnFocus", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "WinEnter" }, {
	pattern = { "*" },
	callback = function()
		if vim.opt.number._value then
			vim.opt.relativenumber = true
		end
	end,
	group = toggleLineNumberOnFocus,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "WinLeave" }, {
	pattern = { "*" },
	callback = function()
		if vim.opt.number._value then
			vim.opt.relativenumber = false
		end
	end,
	group = toggleLineNumberOnFocus,
})
