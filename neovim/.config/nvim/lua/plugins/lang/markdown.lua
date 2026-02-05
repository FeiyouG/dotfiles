return {
	{
		"nvimtools/none-ls.nvim",
		opts = function(_, opts)
			local null_ls = require("null-ls")
			return vim.list_extend(opts, {
				null_ls.builtins.diagnostics.markdownlint.with({
					args = {
						"--stdin",
						"--disable",
						"MD007", -- disable ul-indent - Unordered list indentation
					},
				}),
				null_ls.builtins.formatting.markdownlint.with({
					args = {
						"--fix",
						"$FILENAME",
						"--disable",
						"MD007", -- disable ul-indent - Unordered list indentation
						"--disable",
						"MD053", -- disable Unused link or image reference definition
					},
				}),
			})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = { "markdown" },
		cmd = { "MarkdownPreviewToggle" },
		keys = {
			{
				"<localleader>p",
				"<Plug>MarkdownPreviewToggle",
				desc = "Toggle markdown preview",
				remap = true,
			},
		},
		config = function()
			vim.cmd("let g:mkdp_open_to_the_world = 1")
			vim.cmd("let g:mkdp_echo_preview_url = 1")
			vim.cmd("let g:mkdp_page_title = '${name}'")
			vim.g.mkdp_preview_options = {
				mkit = {},
				katex = {},
				uml = {},
				maid = {},
				disable_sync_scroll = 1,
				sync_scroll_type = "middle",
				hide_yaml_meta = 0,
				sequence_diagrams = {},
				flowchart_diagrams = {},
				content_editable = false,
				disable_filename = 0,
				toc = {},
			}
		end,
	},
	{
		"mzlogin/vim-markdown-toc",

		ft = { "markdown" },

		cmd = { "GenTocGFM", "GenTocRedcarpet", "GenTocGitLab", "GenTocMarked", "RemoveToc" },

		commander = {
			{
				cmd = "<CMD>GenTocGFM<CR>",
				desc = "Generate table of contents (GFM)",
			},
		},

		config = function()
			vim.cmd("let g:vmt_fence_text='TOC'")
			vim.cmd("let g:vmt_fence_closing_text='/TOC'")
			vim.cmd("let g:vmt_list_item_char = '-'")
			vim.cmd("let g:vmt_include_headings_before = 0")
		end,
	},
	{
		"dhruvasagar/vim-table-mode",

		ft = { "markdown" },

		keys = { "<Leader>tm" },

		cmd = { "TableModeToggle" },

		commander = {
			{
				cmd = "<CMD>TableModeToggle<CR>",
				desc = "Toggle Markdown table mode",
				keys = { "n", "<leader>tm" },
				set = false,
			},
		},

		config = function()
			vim.cmd("let g:table_mode_corner='|'")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			-- Enable markdown parser extensions by exporting env vars
			vim.env.EXTENSION_TAGS = 1
			vim.env.EXTENSION_WIKI_LINK = 1

			-- Force treesitter-generate to run before compiling
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.markdown.install_info.requires_generate_from_grammar = true
			parser_config.markdown_inline.install_info.requires_generate_from_grammar = true

			opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "markdown", "markdown_inline" })
			return opts
		end,
	},
	{
		"OXY2DEV/markview.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local mkv = require("markview")
			local presets = require("markview.presets")

			mkv.setup({
				preview = {
					icon_provider = "devicons",
					filetypes = { "md", "markdown", "norg", "rmd", "org", "vimwiki", "Avante" },
					max_length = 99999,
				},
				markdown = {
					headings = presets.glow,
					tables = presets.rounded,
					horizontal_rules = presets.thick,
					list_items = {
						marker_dot = {
							text = "•",
						},
						marker_minus = {
							text = "•",
						},
						marker_star = {
							text = "•",
						},
					}
				},
				yaml = {
					enable = nil,
					properties = {
						data_types = {
							["text"] = {
								text = " ", hl = "MarkviewIcon4"
							},
							["checkbox"] = {
								---@diagnostic disable
								text = function (_, item)
									return item.value == "true" and "⊙ " or "⤬ "
								end,
								---@diagnostic enable
								hl = "MarkviewIcon6"
							},
						},

						default = {
							use_types = true,

							border_top = nil,
							border_middle = nil,
							border_bottom = nil,

							border_hl = nil,
						},

						["^description$"] = {
							match_string = "^description$",
							use_types = false,

							text = "󰦨 ",
							hl = "MarkviewIcon0"
						},
						["^tools$"] = {
							match_string = "^tools$",
							use_types = false,

							text = " ",
							hl = "MarkviewIcon0"
						},
						["^prompt"] = {
							match_string = "^prompt$",
							use_types = false,

							text = "󰍩 ",
							hl = "MarkviewIcon3"
						},
						["^model"] = {
							match_string = "^tools$",
							use_types = false,

							text = "󰚩 ",
							hl = "MarkviewIcon3"
						}
					},
					}

			})
		end,
    commander = {
      {
        cmd = "<CMD>Markview<CR>",
        desc = "Toggles `markview` previews globally.",
      },
    },
		ft = { "markdown", "Avante" },
	},
	-- { -- Only used for Avante, as markview can't be loaded for Avante
	-- 	"MeanderingProgrammer/render-markdown.nvim",
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- 	opts = {
	-- 		filetypes = {  "avante" },
	-- 	},
	-- 	ft = { "Avante" },
	-- },
}
