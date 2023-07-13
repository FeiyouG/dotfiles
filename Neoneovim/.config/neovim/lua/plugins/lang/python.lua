return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = {
			-- require("null-ls").builtins.diagnostics.flake8,
			require("null-ls").builtins.formatting.isort,
			require("null-ls").builtins.formatting.black,
		},
	},

	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts.pylsp = {
				settings = {
					pylsp = {
						plugins = {
							jedi_completion = {
								enabled = true,
								include_params = true,
								include_class_objects = true,
								include_function_objects = true,
								fuzzy = true,
								eager = false,
								resolve_at_most = 18,
							},
							jedi_definition = {
								enabled = true,
								follow_imports = true,
								follow_builtin_imports = true,
							},
							jedi_hover = { enabled = true },
							jedi_references = { enabled = true },
							jedi_signature_help = { enabled = true },
							jedi_symbols = {
								enabled = true,
								all_scopes = true,
								include_import_symbols = true,
							},
							black = { enabled = true },
							isort = { enabled = true },
							-- rope_autoimport = { enabled = true, memory = false },
							-- rope_completion = { enabled = true, eager = false },
						},
					},
				},
			}
			return opts
		end,
	},
	{
		"mfussenegger/nvim-dap",
		opts = {
			python = {
				adapters = {
					type = "executable",
					command = settings.path.python.debugpy,
					args = { "-m", "debugpy.adapter" },
				},
				configurations = {
					{
						-- The first three options are required by nvim-dap
						type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
						request = "launch",
						name = "Launch file",
						-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

						program = "${file}", -- This configuration will launch the current file if used.
						pythonPath = function()
							if settings.path.python.executable then
								return settings.path.python.executable
							end
							vim.notify("nvim-dap", "python executable not found")
							return nil
						end,
					},
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "python" })
			return opts
		end,
	},
}
