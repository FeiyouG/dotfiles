return {
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
		{
			"uga-rosa/cmp-dictionary",
			config = function()
				require("cmp_dictionary").setup({
					dic = {
						["*"] = { "/usr/share/dict/words" },
						spelllang = {
							en = require("settings.lang").spell.spellfile,
						},
					},
					exact = 2,
					max_items = 5,
					first_case_insensitive = true,
					async = true,
				})

				-- Force load dictionary on InsertEnter
				require("cmp_dictionary").update()
			end,
		},
		-- Snippet
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",

		-- Dap
		{
			"rcarriga/cmp-dap",
			config = function()
				require("cmp").setup({
					enabled = function()
						return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
							or require("cmp_dap").is_dap_buffer()
					end,
				})
			end,
		},

		-- LSP
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lsp-document-symbol",
		"hrsh7th/cmp-nvim-lsp-signature-help",

		-- Git
		{ "petertriho/cmp-git", config = true },
		"davidsierradz/cmp-conventionalcommits",
	},

	config = function()
		local luasnip = require("luasnip")
		local cmp = require("cmp")
		local style = require("settings.style")

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
			preselect = cmp.PreselectMode.None, -- Don't preselect item

			window = {
				documentation = {
					border = style.border.rounded,
					winhighlight = style.border.winhighlight,
				},
				completion = {
					border = style.border.rounded,
					winhighlight = style.border.winhighlight,
				},
			},

			-- view = {
			--   entries = {name = 'custom', selection_order = 'near_cursor' }
			-- },

			-- mapping = cmp.mapping.preset.insert(mapping),
			mapping = mapping,

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "calc" },
				{ name = "tmux" },
				{ name = "nerdfont" },
				{ name = "dictionary", max_item_count = 3 },
			}, {
				{ name = "buffer" },
				{ name = "nvim_lsp_signature_help" },
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
					local icon = style.icons.cmp[kind] or style.icons.lsp[kind]

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

					-- Show lsp client name
					-- if entry.source.name == "nvim_lsp" then
					-- 	vim_item.menu = vim_item.menu .. " " .. entry.source.source.client.name
					-- end

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
}
