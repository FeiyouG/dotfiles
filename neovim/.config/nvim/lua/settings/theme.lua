local M = {}
_G.settings.theme = M

M.name = "nord" -- Default theme
if vim.env["THEME"] then
	M.name = vim.env["THEME"]
end
