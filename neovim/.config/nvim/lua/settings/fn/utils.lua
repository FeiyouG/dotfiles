local M = {}

local os_name = nil

---Get current OS name
---
---@return string os_name one of "mac", "win", "linux", and "unkown"
function M.os_name()
	if os_name ~= nil then
		return os_name
	end

	for os, name in pairs({
		mac = "mac",
		win32 = "win",
		linux = "linux",
	}) do
		if vim.fn.has(os) == 1 then
			os_name = name
			return name
		end
	end

	os_name = "unkown"
	return os_name
end

---Check if an object is callable
---
---@param obj any the object to be checked
---@return boolean is_callable true if obj is callable
function M.is_callable(obj)
	if type(obj) == "function" then
		return true
	elseif type(obj) == "table" then
		local mt = getmetatable(obj)
		if mt then
			return type(mt.__call) == "function"
		end
	end
	return false
end

---Return the name of the root directory of the current project
---based on file patterns
--
---@param patterns {[integer]: string} | nil files/dirs that the root dir would contain; look for ,git folder by default
---@return string path the path of the root directory
function M.project_root(patterns)
	patterns = patterns or { ".git" }
	return vim.fs.dirname(vim.fs.find(patterns, { upward = true })[1])
end

---Get the range and content of current visual selection
---
---@return table selected range, contains {start} and {end} tables with {line} (0-indexed, end inclusive) and {character} (0-indexed, end exclusive) values
---@return string[]|nil lines The selected text as an array of lines.
M.get_visual_selection_range = function()
	local _, srow, scol = unpack(vim.fn.getcharpos("v"))
	local _, erow, ecol = unpack(vim.fn.getcharpos("."))

	local r1, c1, r2, c2
	local lines

	-- visual line mode
	if vim.fn.mode() == "V" then
		if srow > erow then
			r1, c1, r2 = erow - 1, 0, srow
			c2 = string.len(vim.api.nvim_buf_get_lines(0, srow - 1, erow, true)[1])
			lines = vim.api.nvim_buf_get_lines(0, erow - 1, srow, true)
		else
			r1, c1, r2 = srow - 1, 0, erow
			c2 = string.len(vim.api.nvim_buf_get_lines(0, erow - 1, erow, true)[1])
			lines = vim.api.nvim_buf_get_lines(0, srow - 1, erow, true)
		end
	-- regular visual mode
	elseif vim.fn.mode() == "v" then
		if srow < erow or (srow == erow and scol <= ecol) then
			r1, c1, r2, c2 = srow - 1, scol - 1, erow - 1, ecol
			lines = vim.api.nvim_buf_get_text(0, srow - 1, scol - 1, erow - 1, ecol, {})
		else
			r1, c1, r2, c2 = erow - 1, ecol - 1, srow - 1, scol
			lines = vim.api.nvim_buf_get_text(0, erow - 1, ecol - 1, srow - 1, scol, {})
		end
	elseif vim.fn.mode() == "\22" then
		lines = {}
		if srow > erow then
			srow, erow = erow, srow
		end
		if scol > ecol then
			scol, ecol = ecol, scol
		end
		r1, c1, r2, c2 = srow, scol, erow, ecol
		for i = srow, erow do
			table.insert(
				lines,
				vim.api.nvim_buf_get_text(0, i - 1, math.min(scol - 1, ecol), i - 1, math.max(scol - 1, ecol), {})[1]
			)
		end
	end

	return {
		start = { line = r1, character = c1 },
		["end"] = { line = r2, character = c2 },
	}, lines
end

return M
