return {
	{
		"NickvanDyke/opencode.nvim",
		dependencies = {
			{
				-- `snacks.nvim` integration is recommended, but optional
				---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
				"folke/snacks.nvim",
				opts = {
					input = {}, -- Enhances `ask()`
					picker = { -- Enhances `select()`
						actions = {
							opencode_send = function(...)
								return require("opencode").snacks_picker_send(...)
							end,
						},
						win = {
							input = {
								keys = {
									["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
								},
							},
						},
					},
				},
			},
			{ "FeiyouG/commander.nvim", lazy = true },
		},
		commander = {
			{
				desc = "Ask opencode",
				cmd = function()
					require("opencode").ask("@this: ", { submit = true })
				end,
				keys = { { "n", "x" }, "<leader>la" },
			},
			{
				desc = "Execute opencode action",
				cmd = function()
					require("opencode").select()
				end,
				keys = { { "n", "x" }, "<leader>lx" },
			},
			{
				desc = "Add range to opencode",
				cmd = function()
					return require("opencode").operator("@this ")
				end,
				keys = { { "n", "x" }, "<leader>lr" },
			},
			{
				desc = "Add line to opencode",
				cmd = function()
					return require("opencode").operator("@this ") .. "_"
				end,
				keys = { { "n" }, "<leader>lr" },
			},
		},
		config = function()
			vim.o.autoread = true

			-- Handle `opencode` events
			vim.api.nvim_create_autocmd("User", {
				pattern = "OpencodeEvent:*", -- Optionally filter event types
				callback = function(args)
					---@type opencode.cli.client.Event
					local event = args.data.event
					---@type number
					local port = args.datport

					local notification_opts = {
						title = "Opencode",
						render = "compact",
					}

					-- See the available event types and their properties
					-- vim.notify(vim.inspect(event))
					-- Do something useful
					if event.type == "session.idle" then
						vim.notify("Finshed responding", "info", notification_opts)
					end

					if event.type == "server.connected" then
						vim.notify("Server connected", "info", notification_opts)
					end
				end,
			})
		end,
	},
	-- {
	-- 	"milanglacier/minuet-ai.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- 	config = function()
	-- 		require("minuet").setup({
	-- 			cmp = {
	-- 				enable_auto_complete = true,
	-- 			},
	-- 			n_completions = 1,
	-- 			request_timeout = 3,
	-- 			context_window = 512,
	-- 			-- provider = 'openai_compatible',
	-- 			provider = "openai_fim_compatible",
	-- 			throttle = 1500, -- Increase to reduce costs and avoid rate limits
	-- 			debounce = 600, -- Increase to reduce costs and avoid rate limits
	-- 			-- notify = "debug",
	-- 			provider_options = {
	-- 				-- openai_compatible = {
	-- 				--   api_key = "OPENROUTER_API_KEY",
	-- 				--   end_point = 'https://openrouter.ai/api/v1/chat/completions',
	-- 				--   model = 'google/gemini-2.0-flash-001',
	-- 				--   name = 'Openrouter',
	-- 				--   optional = {
	-- 				--     max_tokens = 56,
	-- 				--     top_p = 0.9,
	-- 				--     provider = {
	-- 				--       -- Prioritize throughput for faster completion
	-- 				--       sort = 'throughput',
	-- 				--     },
	-- 				--   },
	-- 				-- },
	-- 				openai_fim_compatible = {
	-- 					-- For Windows users, TERM may not be present in environment variables.
	-- 					-- Consider using APPDATA instead.
	-- 					api_key = "TERM",
	-- 					name = "Llama.cpp",
	-- 					end_point = "http://localhost:8012/v1/completions",
	-- 					-- The model is set by the llama-cpp server and cannot be altered
	-- 					-- post-launch.
	-- 					model = "PLACEHOLDER",
	-- 					optional = {
	-- 						max_tokens = 56,
	-- 						top_p = 0.9,
	-- 					},
	-- 					-- Llama.cpp does not support the `suffix` option in FIM completion.
	-- 					-- Therefore, we must disable it and manually populate the special
	-- 					-- tokens required for FIM completion.
	-- 					template = {
	-- 						prompt = function(context_before_cursor, context_after_cursor, _)
	-- 							return "<|fim_prefix|>"
	-- 								.. context_before_cursor
	-- 								.. "<|fim_suffix|>"
	-- 								.. context_after_cursor
	-- 								.. "<|fim_middle|>"
	-- 						end,
	-- 						suffix = false,
	-- 					},
	-- 				},
	-- 			},
	-- 		})
	--
	-- 		vim.api.nvim_create_autocmd("User", {
	-- 			pattern = "MinuetCompleteItems",
	-- 			callback = function(args)
	-- 				local items = args.data
	-- 				print(string.format("[Minuet] Returned %d completion items", #items))
	-- 				if #items == 0 then
	-- 					print("[Minuet] WARNING: Zero items returned!")
	-- 				end
	-- 			end,
	-- 		})
	-- 	end,
	-- },
}

-- https://github.com/olimorris/codecompanion.nvim
-- https://www.reddit.com/r/neovim/comments/1jw7pmm/use_lsp_as_context_provider_in_codecompanion/
-- https://www.reddit.com/r/neovim/comments/1jizh1s/contextfilesnvim_add_support_for_cursor_rules/
-- https://github.com/milanglacier/minuet-ai.nvim
-- https://www.reddit.com/r/neovim/comments/1jfci7i/minuetainvim_v04_update_now_with_inprocess_lsp/
-- https://www.reddit.com/r/neovim/comments/1jevayz/mcphubnvim_v350_custom_instructions_per_server/
