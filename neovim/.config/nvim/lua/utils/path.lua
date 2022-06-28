-- Path related utils
local M = {}

-- Concatenate paths with '/'
M.concat = function(...)
  return table.concat({ ... }, '/')
end

-- Check whether directory exist on path
M.dir_exists = function(path)
  return vim.fn.isdirectory(vim.fn.glob(path)) == 1
end

-- Check whether file exists on path
M.file_exists = function(path)
  return vim.fn.filereadable(vim.fn.glob(path)) == 1
end

-- Create directory recursice if path doesn't exist
M.safe_path = function(path)
  vim.api.nvim_exec("!safe_path " .. path, false)
end

-- MARK: Packer related path
M.packer = {
  installed_path = M.concat(vim.fn.stdpath('data'), 'site/pack/packer/start/packer.nvim'),
  -- compiled_path = M.concat(vim.fn.stdpath('data'), 'site/pack/packer/start/packer.nvim/lua/packer_compiled.lua')
}


local java = {
  java_debug_path = vim.fn.glob "$XDG_DATA_HOME/java/java-debug",
  vscode_java_test_path = vim.fn.glob "$XDG_DATA_HOME/java/vscode-java-test",
  lombok_path = vim.fn.glob "$XDG_DATA_HOME/java/lombok.jar",
}

-- MARK: Java related path
M.java = {
  java_debug_jars = M.dir_exists(java.java_debug_path) and {
    M.concat(java.java_debug_path, "com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"),
  } or {},

  vscode_java_test_jars = M.dir_exists(java.vscode_java_test_path) and
    vim.split(M.concat(java.vscode_java_test_path, "server/*.jar"), "\n") or {},

  lombok_jars = M.file_exists(java.lombok_path) and { java.lombok_path } or P{}
}

return M
