local M = {}

local fn = require("utils.fn")

-- MARK: Packer related path
M.packer = {
  installed_path = fn.path.concat(vim.fn.stdpath('data'), 'site/pack/packer/start/packer.nvim'),
}

local java = {
  java_debug_path = vim.fn.glob "$XDG_DATA_HOME/java/java-debug",
  vscode_java_test_path = vim.fn.glob "$XDG_DATA_HOME/java/vscode-java-test",
  lombok_path = vim.fn.glob "$XDG_DATA_HOME/nvim/mason/packages/jdtls/lombok.jar",
}

-- MARK: Java related path
M.java = {
  java_debug_jars = fn.path.dir_exists(java.java_debug_path) and {
    fn.path.concat(java.java_debug_path, "com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"),
  } or {},

  vscode_java_test_jars = fn.path.dir_exists(java.vscode_java_test_path) and
    vim.split(fn.path.concat(java.vscode_java_test_path, "server/*.jar"), "\n") or {},

  lombok_jars = fn.path.file_exists(java.lombok_path) and { java.lombok_path } or {}
}

return M
