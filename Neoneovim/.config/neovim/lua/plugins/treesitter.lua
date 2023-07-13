return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		opts = function(_, opts)
			opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
				"comment", -- Comment tags like TODO, FIXME, NOTE, ...
				"regex",
				"vim",
			})
			opts.auto_install = true
			opts.highlight = {
				enable = true,
				disable = function(lang, buf)
					if lang == "html" then
						return true
					end

					-- Disable treesitter on file larger than 100KB
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			}
			opts.incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>", -- set to `false` to disable one of the mappings
					node_incremental = "<CR>",
					scope_incremental = "<S-CR>",
					node_decremental = "<BS>",
				},
			}
			opts.indent = {
				enable = true,
			}
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)

			-- MARK: Make bash treesitter also work for zsh
			vim.treesitter.language.register("bash", "zsh")

			settings.fn.keymap.set({
				{
					description = "Show treesitter symbols",
					cmd = "<CMD>Telescope treesitter<CR>",
					keybindings = { "n", "<leader>sts" },
				},
			})
		end,
	},
	{
		"nvim-treesitter/playground",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			opts = function(_, opts)
				opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "query" })
				opts.playground = {
					keybindings = {
						show_help = "g?",
					},
				}
				return opts
			end,
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			opts = function(_, opts)
				opts.textobjects = {
					select = {
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
						-- You can choose the select mode (default is charwise 'v')
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "V", -- linewise
						},
						include_surrounding_whitespace = false,
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]m"] = "@function.outer",
							["]c"] = "@class.outer",
							["]]"] = "@loop.outer",
							["]i"] = "@conditional.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
							["]O"] = "@loop.outer",
							["]I"] = "@conditional.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
							["[o"] = "@loop.outer",
							["[i"] = "@conditional.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
							["[O"] = "@loop.outer",
							["[I"] = "@conditional.outer",
						},
					},
					lsp_interop = {
						border = settings.icons.editor.border.rounded_with_hl,
						peek_definition_code = {
							["<leader>df"] = "@function.outer",
							["<leader>dF"] = "@class.outer",
						},
					},
				}
			end,
		},
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			opts = function(_, opts)
				opts.context_commentstring = {
					enable = true,
					enable_autocmd = false,
				}
			end,
		},
	},
}
