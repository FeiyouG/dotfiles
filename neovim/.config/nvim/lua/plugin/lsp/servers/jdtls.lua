-- See `:hel vim.lsp.start_client` for an overview of the supported `config` options.
return {
  -- The command that starts the lanjuage server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    "-javaagent:" .. Utils.path.java.lombok_jar, -- Setup Lombok support; must in front of `-jar`
    '-jar', Utils.path.java.jdtls_jar,
    '-configuration', Utils.path.java.jdtls_config,
    '-data', Utils.path.java.jdtls_worksapce
  },

  root_dir = Utils.path.java.project_root,

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      signatureHelp = {
        enabled = true
      };

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
      Utils.path.java.java_debug_jar,
      Utils.path.java.java_test_jars,
    }),
  },

  on_attach = function(client, bufnr)
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
  end,
}
