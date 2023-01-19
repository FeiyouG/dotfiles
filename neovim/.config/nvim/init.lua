-- SECTION: Load core settings
require("core")

-- SECTION: Plugins
local style = require("settings.style")
local fn = require("settings.fn")

fn.bootstrap(vim.env.PLUGIN_MANAGER_PATH, "https://github.com/folke/lazy.nvim.git", "stable")
vim.opt.rtp:prepend(vim.env.PLUGIN_MANAGER_PATH)

-- Setup plugins through lazy.nvim
require("lazy").setup("plugins", {
	root = vim.env.PLUGIN_HOME,

	dev = {
		path = vim.env.DEV_HOME,
	},

	install = {
		missing = true,
		colorscheme = { "onenord" },
	},

	ui = {
		border = style.border.rounded,
	},
})
