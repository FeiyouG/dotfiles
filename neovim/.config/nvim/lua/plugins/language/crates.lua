return {
	"saecki/crates.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"jose-elias-alvarez/null-ls.nvim",
	},
	config = function()
		local crates = require("crates")
		crates.setup({
			null_ls = {
				enabled = true,
				name = "crates.nvim",
			},
		})

		-- Add cmp source
		local cmp = require("cmp")
		if cmp ~= nil then
			vim.api.nvim_create_autocmd("BufRead", {
				group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
				pattern = "Cargo.toml",
				callback = function()
					cmp.setup.buffer({ sources = { { name = "crates" } } })
				end,
			})
		end

		-- Add popup to hover
		local hover = require("hover")

		local function execute(done, popup_callback)
      popup_callback()
      done(nil)

			-- -- Show and focus
			-- popup_callback()
      -- popup_callback()
			-- local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
			-- vim.api.nvim_win_close(0, false)
			-- done({ lines = lines, filetype = "markdown" })
		end

		if hover ~= nil then
			hover.register({
				name = "Crate",
				enabled = function()
					return crates.popup_available()
				end,
				execute = function(done)
					execute(done, crates.show_crate_popup)
				end,
				priority = 210,
			})

			hover.register({
				name = "Version",
				enabled = function()
					return crates.popup_available()
				end,
				execute = function(done)
					execute(done, crates.show_versions_popup)
				end,
				priority = 200,
			})

			hover.register({
				name = "Feature",
				enabled = function()
					return crates.popup_available()
				end,
				execute = function(done)
					execute(done, crates.show_features_popup)
				end,
				priority = 200,
			})

			hover.register({
				name = "Dependency",
				enabled = function()
					return crates.popup_available()
				end,
				execute = function(done)
					execute(done, crates.show_dependencies_popup)
				end,
				priority = 200,
			})
		end
	end,
}
