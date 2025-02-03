local emmet_ft = {
	"css",
	"eruby",
	"html",
	"javascript",
	"javascriptreact",
	"less",
	"sass",
	"scss",
	"svelte",
	"pug",
	"typescriptreact",
	"vue",
}
return {
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts.ts_ls = {
				init_options = {
					plugins = {
						{ -- Enable support for vue projects
							name = "@vue/typescript-plugin",
							location = settings.path.installer.packages
								.. "/vue-language-server/node_modules/@vue/typescript-plugin",
							languages = { "vue" },
						},
					},
				},
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayVariableTypeHintsWhenTypeMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
			}

			opts.volar = {
				init_options = {
					vue = {
						hybridMode = true,
					},
				},
				settings = {
					typescript = {
						inlayHints = {
							enumMemberValues = {
								enabled = true,
							},
							functionLikeReturnTypes = {
								enabled = true,
							},
							propertyDeclarationTypes = {
								enabled = true,
							},
							parameterTypes = {
								enabled = true,
								suppressWhenArgumentMatchesName = true,
							},
							variableTypes = {
								enabled = true,
							},
						},
					},
				},
			}


			opts.emmet_language_server = {
				filetypes = emmet_ft,
			}
			return opts
		end,
	},
{
		"olrtg/nvim-emmet",
		ft = emmet_ft,
		--   keys = {
		--     {
		--       "<localleader>ge",
		--       function()
		--         require('nvim-emmet').wrap_with_abbreviation()
		--       end,
		--       desc = "Wrap with emmet",
		--       mode = { "n", "v" }
		--     }
		--   },
		commander = {
			{
				desc = "Wrap with emmet",
				cmd = function()
					require("nvim-emmet").wrap_with_abbreviation()
				end,
				keys = { { "n", "v" }, "<localleader>ge" },
			},
		},
	}
}
