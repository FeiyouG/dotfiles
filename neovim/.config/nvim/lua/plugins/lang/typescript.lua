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
				single_file_support = true,
				filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
				init_options = {
					plugins = {
						{ -- Enable support for vue projects
							name = "@vue/typescript-plugin",
							location = settings.path.installer.packages
								.. '/vue-language-server/node_modules/@vue/language-server',
							languages = { "vue" },
							configNamespace = 'typescript',
						},
					},
				},
				settings = {
					javascript = {
						inlayHints = false
						-- 	includeInlayEnumMemberValueHints = true,
						-- 	includeInlayFunctionLikeReturnTypeHints = true,
						-- 	includeInlayFunctionParameterTypeHints = true,
						-- 	includeInlayParameterNameHints = 'none',
						-- 	includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						-- 	includeInlayPropertyDeclarationTypeHints = true,
						-- 	includeInlayVariableTypeHints = true,
						-- },
					},
					typescript = {
						inlayHints = false
							-- includeInlayEnumMemberValueHints = true,
							-- includeInlayFunctionLikeReturnTypeHints = true,
							-- includeInlayFunctionParameterTypeHints = true,
							-- includeInlayParameterNameHints = 'none',
							-- includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							-- includeInlayPropertyDeclarationTypeHints = true,
							-- includeInlayVariableTypeHints = true,
						-- },
					},
				},
			}
			--
			-- opts.vtsls = {
			-- 	settings = {
			-- 		vtsls = {
			-- 			tsserver = {
			-- 				globalPlugins = {
			-- 					{ -- Enable support for vue projects
			-- 						name = "@vue/typescript-plugin",
			-- 						location = settings.path.installer.packages
			-- 							.. '/vue-language-server/node_modules/@vue/language-server',
			-- 						languages = { "vue" },
			-- 						configNamespace = 'typescript',
			-- 					},
			-- 				},
			-- 			},
			-- 		},
			-- 	},
			-- 	filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
			-- }

			opts.vue_ls = {
				filetypes = { 'vue' },
				init_options = {
					vue = {
						hybridMode = false,
					},
					typescript = {
						tsdk = settings.path.installer.packages .. "/vue-language-server/node_modules/typescript/lib",
					},
					preferences = {
						disableSuggestions = false,
					},
					languageFeatures = {
						implementation = true,
						references = true,
						definition = true,
						typeDefinition = true,
						callHierarchy = true,
						hover = true,
						rename = true,
						renameFileRefactoring = true,
						signatureHelp = true,
						codeAction = true,
						workspaceSymbol = true,
						diagnostics = true,
						semanticTokens = true,
						completion = {
							defaultTagNameCase = 'both',
							defaultAttrNameCase = 'kebabCase',
							getDocumentNameCasesRequest = false,
							getDocumentSelectionRequest = false,
						},
					},
				},
				settings = {
					typescript = {
						inlayHints = false
						-- 	enumMemberValues = {
						-- 		enabled = true,
						-- 	},
						-- 	functionLikeReturnTypes = {
						-- 		enabled = true,
						-- 	},
						-- 	propertyDeclarationTypes = {
						-- 		enabled = true,
						-- 	},
						-- 	parameterTypes = {
						-- 		enabled = true,
						-- 		suppressWhenArgumentMatchesName = true,
						-- 	},
						-- 	variableTypes = {
						-- 		enabled = true,
						-- 	},
						-- },
					},
				},
			}

			opts.denols = {
				filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue" }
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
	},
}
