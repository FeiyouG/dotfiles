-- Patterns of root folder
local root_dir = Utils.path.java.project_root
local jdtls_home = Utils.path.java.jdtls_home

--- MARK: Setup bundles
local jdtls_bundles = vim.tbl_flatten({
  Utils.path.java.java_debug_jars,
  Utils.path.java.vscode_java_test_jars,
})

-- MARK: Setup Commands
local jdtls_cmd = {
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
}

-- Setup Lombok support; must in front of `-jar`
if Utils.path.java.lombok_jars then
  vim.list_extend(jdtls_cmd, {
    "-javaagent:" .. Utils.fn.constants.java.lombok_jars[1],
  })
end

vim.list_extend(jdtls_cmd, {
  '-jar', vim.fn.glob(Utils.path.join(
    jdtls_home,
    'plugins/org.eclipse.equinox.launcher_*.jar')
  ),
  '-configuration', vim.fn.glob(Utils.path.join(
    jdtls_home,
    '/config_' .. Utils.system.os_name)
  ),
  '-data', Utils.path.java.jdtls_workspace,
})


-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
return {
  -- The command that starts the lanjuage server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = jdtls_cmd,

  root_dir = root_dir,

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
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = jdtls_bundles,
  },
}
