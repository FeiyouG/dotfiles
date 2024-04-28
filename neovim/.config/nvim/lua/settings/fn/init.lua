local M = require("settings.fn.utils")
_G.settings.fn = M

M.plugins = require("settings.fn.plugin")
M.lsp = require("settings.fn.lsp")

return M

