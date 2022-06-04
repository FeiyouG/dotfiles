local utils = require("utils")

-- Patterns of root folder
local root_markers = {
  '.git',
  'mvnw',
  'gradlew',
  'Config', -- Amazon
}
local root_dir = require('jdtls.setup').find_root(root_markers) -- Project root directory

local jdtls_home = '$XDG_DATA_HOME/nvim/lsp_servers/jdtls'
local jdtls_workspace = utils.path.concat('$XDG_CACHE_HOME/jdtls-workspace', vim.fn.fnamemodify(root_dir, ":p:h:t"))

-- Create jdtls_workspace if it doesn't exist
utils.path.safe_path(jdtls_workspace)


--- MARK: Setup bundles
local jdtls_bundles = {}

-- Setup debugger
vim.list_extend(jdtls_bundles, utils.path.java.java_debug_jars)
vim.list_extend(jdtls_bundles, utils.path.java.vscode_java_test_jars)
-- local java_debug_path = vim.fn.glob "$XDG_DATA_HOME/java/java-debug"
-- if vim.fn.isdirectory(java_debug_path) == 1 then
--   table.insert(jdtls_bundles, utils.path.concat(java_debug_path, "com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"))
-- end
--
-- local vscode_java_test_path = vim.fn.glob "$XDG_DATA_HOME/java/vscode_java_test"
-- if vim.fn.isdirectory(vscode_java_test_path) == 1 then
--   vim.list_extend(jdtls_bundles, vim.split(utils.path.concat(vscode_java_test_path, "server/*.jar"), "\n"))
-- end


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
if utils.path.java.lombok_jars then
  vim.list_extend(jdtls_cmd, {
    "-javaagent:" .. utils.path.java.lombok_jars[1],
    -- "-Xbootclasspath/a:" .. utils.path.java.lombok_jars[1],
  })
end

vim.list_extend(jdtls_cmd, {
  '-jar', vim.fn.glob(utils.path.concat(jdtls_home, 'plugins/org.eclipse.equinox.launcher_*.jar')),
  '-configuration', vim.fn.glob(utils.path.concat(jdtls_home, '/config_' .. utils.get_os())),
  '-data', vim.fn.glob(jdtls_workspace),
})

P(jdtls_cmd)


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
    bundles = jdtls_bundles
  },
}
