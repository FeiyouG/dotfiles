return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",

	event = { "VeryLazy" },

	dependencies = {
		"williamboman/mason.nvim",
	},

	config = function()
		require("mason-tool-installer").setup({

			-- a list of all tools you want to ensure are installed upon
			-- start; they should be the names Mason uses for each tool
			-- example :
			-- ensure_installed = {
			--   { "bash-language-server", auto_update = true },  -- you can turn off/on auto_update per tool
			--   "lua-language-server",
			-- }
			ensure_installed = {
				"java-test",
				"java-debug-adapter",
			},

			-- if set to true this will check each tool for updates. If updates
			-- are available the tool will be updated. This setting does not
			-- affect :MasonToolsUpdate or :MasonToolsInstall.
			-- Default: false
			auto_update = false,

			-- automatically install / update on startup. If set to false nothing
			-- will happen on startup. You can use :MasonToolsInstall or
			-- :MasonToolsUpdate to install tools and check for updates.
			-- Default: true
			run_on_start = true,

			-- set a delay (in ms) before the installation starts. This is only
			-- effective if run_on_start is set to true.
			-- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
			-- Default: 0
			start_delay = 1500, -- 1.5 second delay
		})
	end,
}
