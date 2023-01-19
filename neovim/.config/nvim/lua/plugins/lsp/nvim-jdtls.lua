return {
	"mfussenegger/nvim-jdtls",

	ft = { "java" },

	event = { "BufReadPre" },

	config = function()
		local jdtls = require("jdtls")
		local jdtls_setup = require("jdtls.setup")
		local server_config = require("plugins.lsp.servers").jdtls
		local fn = require("settings.fn")

		local function setup_and_start_jdtls()
			-- SECTION: Starts a new client & server,
			server_config.capabilities =
				vim.tbl_extend("force", fn.lsp.get_capabilities(), server_config.capabilities or {})
			jdtls.start_or_attach(server_config)
			jdtls_setup.add_commands()

			-- SECTION: Amazon + Bemol
			-- local root_dir = require("jdtls.setup").find_root({ "packageInfo" }, "Config") -- Project root directory
			-- if root_dir then
			--   local file = io.open(root_dir .. "/.bemol/ws_root_folders", "r")
			--   if file then
			--     for line in file:lines() do
			--       vim.lsp.buf.add_workspace_folder(line)
			--     end
			--     file:close()
			--   end
			-- end
		end

		local function add_jdtls_commands()
			local commands = {
				{
					description = "Jdtls Organize Imports",
					cmd = jdtls.organize_imports,
				},
				{
					description = "Jdtls Extract Variable",
					cmd = jdtls.extract_variable,
				},
				{
					description = "Jdtls Extract Constant",
					cmd = jdtls.extract_constant,
				},
				{
					description = "Jdtls Test Neareast Method",
					cmd = jdtls.test_nearest_method,
				},
				{
					description = "Jdtls Test Class",
					cmd = jdtls.test_class,
				},
				{
					description = "Jdtls Update Config",
					cmd = "<CMD>JdtlsUpdateConfig<CR>",
				},
			}

			local commander = fn.require("commander")
			if commander then
				commander.add(commands, {
					category = "lsp",
					keys_opts = { buffer = true },
				})
			end
		end

		local start_jdtls_on_filetype = vim.api.nvim_create_augroup("StartJdtlsOnFiletype", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "java",
			callback = function()
				setup_and_start_jdtls()
				add_jdtls_commands()
			end,
			group = start_jdtls_on_filetype,
		})
	end,
}
