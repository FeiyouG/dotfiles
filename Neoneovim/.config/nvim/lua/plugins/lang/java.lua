local java = settings.path.java

return {
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    event = { "BufReadPre" },
    opts = {
      -- The command that starts the lanjuage server
      -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        java.lombok and "-javaagent:" .. java.lombok or "", -- Setup Lombok support; must in front of `-jar`
        "-Xbootclasspath/a:" .. java.lombok,
        "-jar",
        java.jdtls,
        "-configuration",
        java.jdtls_config,
        "-data",
        java.jdtls_worksapce,
      },
      root_dir = java.project_root,
      -- Here you can configure eclipse.jdt.ls specific settings
      -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
      -- for a list of options
      settings = {
        java = {
          signatureHelp = {
            enabled = true,
          },
          codeGeneration = {
            toString = {
              template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
        },
      },
      -- Language server `initializationOptions`
      -- You need to extend the `bundles` with paths to jar files
      -- if you want to use additional eclipse.jdt.ls plugins.
      init_options = {
        bundles = vim.tbl_flatten({
          java.debug_adapter,
          java.test,
        }),
      },
      on_attach = function(client, bufnr)
        require("jdtls").setup_dap({
          hotcodereplace = "auto",
          config_overrides = {
            args = function()
              local args = vim.fn.input("args: ", "")
              if args then
                return args
              end
            end,
          },
        })
      end,
    },
    config = function(_, opts)
      local jdtls = require("jdtls")
      local jdtls_setup = require("jdtls.setup")

      opts.capabilities = vim.tbl_extend("force", settings.fn.lsp.get_capabilities(), opts.capabilities or {})

      -- Starts a new client & server on java file
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          local server_on_attach = opts.on_attach
          opts.on_attach = function(client, bufnr)
            settings.fn.lsp.on_attach(client, bufnr)
            server_on_attach(client, bufnr)
          end

          if vim.env.AMAZON == "true" then -- Amazon + Bemol
            opts.root_dir = settings.fn.project_root({ ".bemol" })
              local file = io.open(opts.root_dir .. "/.bemol/ws_root_folders", "r")
              if file then
                for line in file:lines() do
                  vim.lsp.buf.add_workspace_folder(line)
                end
                file:close()
              end
          end


          jdtls.start_or_attach(opts)
          jdtls_setup.add_commands()



          --				settings.fn.keymap.set({
          --					{
          --						description = "Jdtls Organize Imports",
          --						cmd = jdtls.organize_imports,
          --					},
          --					{
          --						description = "Jdtls Extract Variable",
          --						cmd = jdtls.extract_variable,
          --					},
          --					{
          --						description = "Jdtls Extract Constant",
          --						cmd = jdtls.extract_constant,
          --					},
          --					{
          --						description = "Jdtls Test Neareast Method",
          --						cmd = jdtls.test_nearest_method,
          --					},
          --					{
          --						description = "Jdtls Test Class",
          --						cmd = jdtls.test_class,
          --					},
          --					{
          --						description = "Jdtls Update Config",
          --						cmd = "<CMD>JdtlsUpdateConfig<CR>",
          --					},
          --				}, {
          --					category = "lsp",
          --					keys_opts = { buffer = true },
          --				})
        end,
        group = vim.api.nvim_create_augroup("JDTLS_AUGROUP", { clear = true }),
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "java" })
      return opts
    end,
  },
}
