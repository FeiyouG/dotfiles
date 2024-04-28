return {
	"zk-org/zk-nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim", -- picker
	},

	opts = {
		picker = "telescope",
		auto_attach = {
			enabled = true,
			filetypes = { "md", "markdown" },
		},
	},

	config = function(_, opts)
		opts.lsp = opts.lsp or {}
		opts.lsp.config = opts.lsp.config or {}

		-- Initialize capabilities
		opts.lsp.config.capabilities =
			vim.tbl_extend("force", settings.fn.lsp.get_capabilities(), opts.lsp.config.capabilities or {})

		-- add common logics to on_attach functions
		local server_on_attach = opts.lsp.config.on_attach
		opts.lsp.config.on_attach = function(client, bufnr)
			settings.fn.lsp.on_attach(client, bufnr)
			if server_on_attach ~= nil then
				server_on_attach(client, bufnr)
			end
		end

		require("zk").setup(opts)
	end,

	commander = function(_, opts)
		local zk = require("zk")
		local zk_api = require("zk.api")

		local select_group = function(callback)
			local choices = {
				"zettel",
				"moc",
				"log",
			}

			vim.ui.select(choices, {
				prompt = "Select a group: ",
			}, function(choice)
				callback(choice)
			end)
		end

		local select_title_or_content = function(callback)
			local choices = {
				"title",
				"content",
				"skip",
			}

			vim.ui.select(choices, {
				prompt = "Use seletion as ",
			}, function(choice)
				callback(choice)
			end)
		end

		local function notify_abortion_of_note_creation(group)
			group = group or "zettel"
			vim.notify(group .. " creation aborted (zk)", vim.log.levels.WARN)
		end

		return {
			{
				cmd = function()
					select_group(function(group)
						if group == nil then
							notify_abortion_of_note_creation(group)
							return
						end
						zk.new({ group = group })
					end)
				end,
				desc = "Create a new zettel in notebook",
				keys = { "n", "<leader>zn" },
			},
			{
				cmd = function()
					-- NOTE: Block selection is not supported

					local range, lines = settings.fn.get_visual_selection_range()
					local location = settings.fn.lsp.get_location_from_selection(range)
					local selection = table.concat(lines or {}, "\n")
					local ft = vim.bo[0].filetype

					local cmd_opts = {}

					-- Escape quotes, colons, and hyphens, and strip spaces&nelwines
					if string.find(selection, ":") or string.find(selection, "-") then
						selection = string.gsub(selection, '"', '\\"')
						selection = '"' .. selection .. '"'
					end

					-- Select group and title/content to populate
					select_group(function(group)
						if group == nil then
							notify_abortion_of_note_creation(group)
							return
						end
						cmd_opts.group = group
						select_title_or_content(function(title_or_content)
							if title_or_content == nil then
								notify_abortion_of_note_creation(group)
								return
							end

							if title_or_content == "title" then
								cmd_opts.title = selection
								cmd_opts.insertLinkAtLocation = location
							elseif title_or_content == "content" then
								-- Currently broken in zk
								cmd_opts.content = selection
								cmd_opts.insertLinkAtLocation = location
							end

							if not vim.tbl_contains(opts.auto_attach.filetypes, ft) then
								print(vim.inspect(opts))
								cmd_opts.insertLinkAtLocation = nil
							end

							zk.new(cmd_opts)
						end)
					end)
				end,
				desc = "Create a new zettel with selected content",
				keys = { "v", "<leader>zn" },
			},
			{
				cmd = "<CMD>ZkTags<CR>",
				desc = "Find zettels with the selected tag",
				keys = { "n", "<leader>zt" },
			},
			{
				cmd = "<CMD>ZkNotes<CR>",
				desc = "Find zettels in notebook (sort by last modified)",
				keys = { "n", "<leader>zf" },
			},
			{
				cmd = function()
					local range, lines = settings.fn.get_visual_selection_range()
					local selection = table.concat(lines or {}, "\n")
					selection = vim.trim(selection)
					zk.edit({
						---@diagnostic disable-next-line: undefined-global
						sort = modified,
						match = selection,
					}, {
						title = "Finding notes matching " .. selection,
					})
				end,
				desc = "Search zettels in notebook (sort by last modified)",
				keys = { "v", "<leader>zf" },
			},
			{
				cmd = "<CMD>ZkBacklinks<CR>",
				desc = "Show backlins to this zettel",
				keys = { "n", "<leader>zr" },
			},
			{
				cmd = "<CMD>ZkInsertLinksCR>",
				desc = "Search zettels and insert a link at the cursor location",
				keys = { "n", "<leader>za" },
			},
			{
				cmd = "<CMD>ZkInsertLinksCR>",
				desc = "Search zettels and insert a link at the cursor location",
				keys = { "n", "<leader>za" },
			},
			{
				cmd = function()
					local range, lines = settings.fn.get_visual_selection_range()
					local location = settings.fn.lsp.get_location_from_selection(range)
					local selection = table.concat(lines or {}, "\n")
					selection = vim.trim(selection)
					zk.pick_notes({
						---@diagnostic disable-next-line: undefined-global
						sort = modified,
						match = { selection },
					}, {
						title = "Finding notes matching " .. selection,
						multi_select = false,
					}, function(note)
						if not note then
							vim.notify("Link insertion aborted - no note selected (zk)", vim.log.levels.WARN)
							return
						end
						print(vim.inspect(note))
						zk_api.link(note.path, location, nil, { title = selection }, function(err, res)
							if not res then
								vim.notify("Link insertion failed with err: " .. vim.inspect(err), vim.log.levels.ERROR)
							end
						end)
					end)
				end,
				desc = "Search zettels with selected content and replace with a link",
				keys = { "v", "<leader>za" },
			},
		}
	end,
}
