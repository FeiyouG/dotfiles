return {
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdLineEnter" },
		dependencies = {
			"nvim-lua/plenary.nvim",

			-- MISC
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-calc",
			"andersevenrud/cmp-tmux",
			"chrisgrieser/cmp-nerdfont",

			-- Snippet
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",

			-- Dap
			"rcarriga/cmp-dap",

			-- LSP
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-nvim-lsp-signature-help",

			-- Git
			{ "petertriho/cmp-git", config = true },
			"davidsierradz/cmp-conventionalcommits",
		},
		config = function(_, opts)
			local luasnip = require("luasnip")
			local cmp = require("cmp")

			local mapping = {
				["<C-n>"] = cmp.mapping(function(fallback)
					if luasnip.choice_active() then
						require("luasnip.extras.select_choice")()
					elseif cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-p>"] = cmp.mapping(function(fallback)
					if luasnip.choice_active() then
						require("luasnip.extras.select_choice")()
					elseif cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if luasnip.locally_jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
				-- Select the completion item, excluding preselected
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
				["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
			}

			cmp.setup({
				enabled = function() -- cmp-dap
					return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
				end,
				preselect = cmp.PreselectMode.None, -- Don't preselect item
				window = {
					documentation = {
						border = settings.icons.editor.border.rounded_with_hl,
						winhighlight = settings.icons.editor.border.winhighlight,
					},
					completion = {
						border = settings.icons.editor.border.rounded_with_hl,
						winhighlight = settings.icons.editor.border.winhighlight,
					},
				},
				performance = {
					debounce = 450,
				},
				mapping = mapping,
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "render-markdown" }, -- For markdown
					{ name = "path" },
					{ name = "dictionary", max_item_count = 3 },
				}, {
					{ name = "buffer" },
					{ name = "tmux" },
					{ name = "calc" },
					{ name = "nerdfont" },
				}),
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				formatting = {
					format = function(entry, vim_item)
						-- Show kind icons
						local kind = ({
							calc = "Result",
							nerdfont = "Icon",
							tmux = "Tmux",
							git = "Git",
							conventionalcommits = "Git",
							dap = "Dap",
							treesitter = "Treesitter",
							dictionary = "Word",
						})[entry.source.name] or vim_item.kind
						local icon = settings.icons.cmp[kind] or settings.icons.lsp[kind]

						vim_item.kind = string.format("%s %s", icon, kind)

						-- Show source
						vim_item.menu = ({
							cmdline = "[CMDLINE]",
							buffer = "[BUFFER]",
							nvim_lsp = "[LSP]",
							nvim_lua = "[API]",
							path = "[PATH]",
							luasnip = "[SNIPPET]",
							nvim_lsp_document_symbol = "[SYMBOL]",
							tmux = "[TMUX]",
							calc = "[CALC]",
							nerdfont = "[NERDFONT]",
							dap = "[DAP]",
							git = "[GIT]",
							conventionalcommits = "[GIT]",
							treesitter = "[TS]",
							dictionary = "[DICT]",
						})[entry.source.name]

						-- Custumize padding
						vim_item.abbr = " " .. vim_item.abbr

						return vim_item
					end,
				},
				experimental = {
					native_menu = false,
					ghost_text = true,
				},
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "nvim_lsp_document_symbol" }, -- trigger by "/@"
				}, {
					{ name = "buffer" },
				}),
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "git" },
					{ name = "conventionalcommits" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
				sources = cmp.config.sources({
					{ name = "dap" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
		},
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = true,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
}
