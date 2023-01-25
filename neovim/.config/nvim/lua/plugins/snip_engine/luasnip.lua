return {
	"L3MON4D3/LuaSnip",

	event = { "InsertEnter", "CmdLineEnter" },

	config = function()
		local luasnip = require("luasnip")
		local types = require("luasnip.util.types")

		luasnip.config.set_config({
			history = true,
			update_events = "TextChanged,TextChangedI",

			-- Autosnippets:
			enable_autosnippets = true,

			-- Crazy highlights!!
			-- #vid3
			-- ext_opts = nil,
			ext_opts = {
				[types.choiceNode] = {
					active = {
						virt_text = { { "祈choice node", "CmpItemKindText" } },
					},
				},
			},
		})

		-- Load snippets from plugins
		require("luasnip.loaders.from_vscode").lazy_load() -- friendly snippets

		-- Load custome snippets
		local snippet_dir = require("settings.snippets").path
		require("luasnip.loaders.from_lua").lazy_load({ paths = { snippet_dir .. "/luasnippets" } })
		require("luasnip.loaders.from_vscode").lazy_load({ paths = { snippet_dir .. "/vscode" } })

		-- Insert custom helper functions into luasnip
		function luasnip.set_text(node, replacement)
			local from_pos, to_pos = node.mark:pos_begin_end_raw()
			if type(replacement) ~= "table" then
				replacement = { replacement }
			end
			vim.api.nvim_buf_set_text(0, from_pos[1], from_pos[2], to_pos[1], to_pos[2], replacement)
		end

		function luasnip.rm_if_no_change(node, default_text)
			if node:get_text()[1] == default_text then
				luasnip.set_text(node, {})
			end
		end
	end,
}
