return {
	"nvim-tree/nvim-tree.lua",
	event = { "VeryLazy" },
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local nvim_tree = require("nvim-tree")
		local style = require("settings.style")
		local fn = require("settings.fn")

		-- a list of groups can be found at `:help nvim_tree_highlight`
		-- vim.cmd "highlight NvimTreeFolderIcon guibg=blue"
		-- local custom_mapping = {
		-- 	{ key = { "<CR>", "<2-LeftMouse>" }, action = "edit" },
		-- 	{ key = { "o", "C-e" }, action = "edit_in_place" },
		-- 	{ key = { "O" }, action = "edit_no_picker" },
		-- 	{ key = { "<C-c>" }, action = "cd" },
		-- 	{ key = "<C-v>", action = "vsplit" },
		-- 	{ key = "<C-s>", action = "split" },
		-- 	{ key = "<C-t>", action = "tabnew" },
		-- 	{ key = "<C-k>", action = "prev_sibling" },
		-- 	{ key = "<C-j>", action = "next_sibling" },
		-- 	{ key = "P", action = "parent_node" },
		-- 	{ key = "x", action = "close_node" },
		-- 	{ key = "<Tab>", action = "preview" },
		-- 	{ key = "<C-u>", action = "first_sibling" },
		-- 	{ key = "<C-d>", action = "last_sibling" },
		-- 	{ key = "H", action = "toggle_ignored" },
		-- 	{ key = "I", action = "toggle_dotfiles" },
		-- 	{ key = "R", action = "refresh" },
		-- 	{ key = "a", action = "create" },
		-- 	{ key = "d", action = "remove" },
		-- 	{ key = "D", action = "trash" },
		-- 	{ key = "r", action = "rename" },
		-- 	{ key = "<C-r>", action = "full_rename" },
		-- 	{ key = "<c-x>", action = "cut" },
		-- 	{ key = "c", action = "copy" },
		-- 	{ key = "p", action = "paste" },
		-- 	{ key = "yy", action = "copy_name" },
		-- 	{ key = "yd", action = "copy_path" },
		-- 	{ key = "yp", action = "copy_absolute_path" },
		-- 	{ key = "[c", action = "prev_git_item" },
		-- 	{ key = "]c", action = "next_git_item" },
		-- 	{ key = "u", action = "dir_up" },
		-- 	{ key = "o", action = "system_open" },
		-- 	{ key = "f", action = "live_filter" },
		-- 	{ key = "F", action = "clear_live_filter" },
		-- 	{ key = "q", action = "close" },
		-- 	{ key = "X", action = "collapse_all" },
		-- 	{ key = "E", action = "expand_all" },
		-- 	{ key = "S", action = "search_node" },
		-- 	{ key = ".", action = "run_file_command" },
		-- 	{ key = "K", action = "toggle_file_info" },
		-- 	{ key = "?", action = "toggle_help" },
		-- }

		local function on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- Default mappings not inserted as:
			--  remove_keymaps = true
			--  OR
			--  view.mappings.custom_only = true

			-- Mappings migrated from view.mappings.list
			--
			-- You will need to insert "your code goes here" for any mappings with a custom action_cb
			vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
			vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
			vim.keymap.set("n", "o", api.node.open.replace_tree_buffer, opts("Open: In Place"))
			vim.keymap.set("n", "C-e", api.node.open.replace_tree_buffer, opts("Open: In Place"))
			vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
			vim.keymap.set("n", "<C-c>", api.tree.change_root_to_node, opts("CD"))
			vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
			vim.keymap.set("n", "<C-s>", api.node.open.horizontal, opts("Open: Horizontal Split"))
			vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
			vim.keymap.set("n", "<C-k>", api.node.navigate.sibling.prev, opts("Previous Sibling"))
			vim.keymap.set("n", "<C-j>", api.node.navigate.sibling.next, opts("Next Sibling"))
			vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
			vim.keymap.set("n", "x", api.node.navigate.parent_close, opts("Close Directory"))
			vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
			vim.keymap.set("n", "<C-u>", api.node.navigate.sibling.first, opts("First Sibling"))
			vim.keymap.set("n", "<C-d>", api.node.navigate.sibling.last, opts("Last Sibling"))
			vim.keymap.set("n", "H", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
			vim.keymap.set("n", "I", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
			vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
			vim.keymap.set("n", "a", api.fs.create, opts("Create"))
			vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
			vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
			vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
			vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
			vim.keymap.set("n", "<c-x>", api.fs.cut, opts("Cut"))
			vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
			vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
			vim.keymap.set("n", "yy", api.fs.copy.filename, opts("Copy Name"))
			vim.keymap.set("n", "yd", api.fs.copy.relative_path, opts("Copy Relative Path"))
			vim.keymap.set("n", "yp", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
			vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
			vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
			vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("Up"))
			vim.keymap.set("n", "o", api.node.run.system, opts("Run System"))
			vim.keymap.set("n", "f", api.live_filter.start, opts("Filter"))
			vim.keymap.set("n", "F", api.live_filter.clear, opts("Clean Filter"))
			vim.keymap.set("n", "q", api.tree.close, opts("Close"))
			vim.keymap.set("n", "X", api.tree.collapse_all, opts("Collapse"))
			vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
			vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
			vim.keymap.set("n", ".", api.node.run.cmd, opts("Run Command"))
			vim.keymap.set("n", "K", api.node.show_info_popup, opts("Info"))
			vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
		end

		-- each of these are documented in `:help nvim-tree.OPTION_NAME`
		nvim_tree.setup({
      on_attach =on_attach,
			disable_netrw = true,
			hijack_netrw = true,
			auto_reload_on_write = false,
			create_in_closed_folder = false,
			open_on_tab = false,
			sort_by = "name",
			hijack_unnamed_buffer_when_opening = false,
			hijack_cursor = false,
			update_cwd = true,
			reload_on_bufenter = false,
			respect_buf_cwd = true,
			hijack_directories = {
				enable = true,
				auto_open = true,
			},
			update_focused_file = {
				enable = true,
				update_cwd = true,
				ignore_list = {},
			},
			system_open = {
				cmd = nil,
				args = {},
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				icons = {
					hint = style.icons.diagnostic.hint_filled,
					info = style.icons.diagnostic.info_filled,
					warning = style.icons.diagnostic.warning_filled,
					error = style.icons.diagnostic.error_filled,
				},
			},
			on_attach = "disabled",
			remove_keymaps = true,
			view = {
				hide_root_folder = false,
				width = 30,
				side = "left",
				preserve_window_proportions = true,
				number = false,
				relativenumber = true,
				signcolumn = "yes",
				mappings = {
					-- list = custom_mapping,
				},
			},
			renderer = {
				add_trailing = true,
				group_empty = true,
				highlight_git = true,
				highlight_opened_files = "icon",
				root_folder_modifier = ":~",
				indent_markers = {
					enable = true,
					icons = {
						corner = "└",
						item = "│",
						edge = "│",
						none = "  ",
					},
				},
				icons = {
					webdev_colors = true,
					git_placement = "after",
					padding = " ",
					symlink_arrow = style.icons.symbolic_arrow,
					show = {
						file = true,
						folder = true,
						folder_arrow = false,
						git = true,
					},
					glyphs = {
						default = style.icons.file.default,
						symlink = style.icons.file.symlink,
						git = {
							unstaged = style.icons.git.unstaged,
							staged = style.icons.git.staged,
							unmerged = style.icons.git.unmerged,
							renamed = style.icons.git.renamed,
							untracked = style.icons.git.untracked,
							deleted = style.icons.git.deleted,
							ignored = style.icons.git.ignored,
						},
						folder = {
							arrow_open = style.icons.folder.indicator_open,
							arrow_closed = style.icons.folder.indicator_closed,
							default = style.icons.folder.closed,
							open = style.icons.folder.open,
							empty = style.icons.folder.empty_closed,
							empty_open = style.icons.folder.empty_open,
							symlink = style.icons.folder.symlink_closed,
							symlink_open = style.icons.folder.symlink_open,
						},
					},
				},
				special_files = { "README.md", "Makefile", "MAKEFILE" },
			},
			filters = {
				dotfiles = false,
				custom = {},
				exclude = {},
			},
			git = {
				enable = true,
				ignore = true,
				timeout = 400,
			},
			actions = {
				use_system_clipboard = true,
				change_dir = {
					enable = true,
					global = false,
					restrict_above_cwd = false,
				},
				open_file = {
					quit_on_open = false,
					resize_window = false,
					window_picker = {
						enable = true,
						chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
						exclude = {
							filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
							buftype = { "nofile", "terminal", "help" },
						},
					},
				},
			},
			trash = {
				cmd = "trash",
				require_confirm = true,
			},
		})

		-- SECTION: Open on startup
		local function open_nvim_tree(data)
			local open = false
			open = open or (data.file == "" and vim.bo[data.buf].buftype == "") -- buffer is a [No Name]
			open = open or vim.fn.isdirectory(data.file) == 1 -- buffer is a directory

			if open then
				require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
			end
		end

		vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

		-- SECTION: Keymaps
		fn.keymap.set({
			{
				desc = "Toggle nvim-tree",
				cmd = "<CMD>NvimTreeToggle<CR>",
				keys = { "n", "<leader>tt" },
			},
			{
				desc = "Refresh nvim-tree",
				cmd = "<CMD>NvimTreeRefresh<CR>",
				keys = { "n", "<leader>tr" },
			},
			{
				desc = "Reveal current file in nvim-tree",
				cmd = "<CMD>NvimTreeFindFile<CR>",
				keys = { "n", "<leader>tf" },
			},
		})
	end,
}
