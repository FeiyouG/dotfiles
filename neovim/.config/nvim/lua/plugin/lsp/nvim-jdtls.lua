return {
  "mfussenegger/nvim-jdtls",

  config = function()
    local jdtls = require("jdtls")
    local jdtls_setup = require("jdtls.setup")
    local jdtls_config = require("plugin.lsp.servers").jdtls.java

    local function setup_and_start_jdtls()
      -- MARK: Starts a new client & server,
      jdtls_config.capabilities = Utils.lsp.capabilities
      jdtls.start_or_attach(jdtls_config)
      jdtls_setup.add_commands()

      -- MARK: Amazon + Bemol
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

      local command_center = Utils.require("command_center")
      if command_center then
        command_center.add(commands, {
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
