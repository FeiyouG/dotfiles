local M = {}

-- MARK: Java
local get_java_debug_jars = function()
  local path = vim.fn.glob(M.join(
    "$XDG_DATA_HOME/java/java-debug",
    "com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
  ))
  return path ~= "" and { path } or {}
end

local get_vscode_java_test_jars = function()
  local path = vim.fn.glob("$XDG_DATA_HOME/java/vscode-java-test/server/*jar")
  return path ~= "" and vim.fn.split(path, "\n") or {}
end

local get_lombok_jars = function()
  local path = vim.fn.glob("$XDG_DATA_HOME/nvim/mason/packages/jdtls/lombok.jar")
  return path ~= "" and { path } or {}
end

local get_project_root = function()
  return vim.fs.dirname(vim.fs.find({'.git', 'mvnw', 'gradlew'}, { upward = true })[1])
end

local get_jdtls_home = function()
  local path = "$XDG_DATA_HOME/nvim/mason/packages/jdtls"
  if not M.dir_exists(path) then vim.loop.fs_mkdir(path, 493) end
  return vim.fn.glob(path)
end

local get_jdtls_workspace = function()
  local path = M.join(
    "$XDG_CACHE_HOME/jdtls-workspace",
    vim.fn.fnamemodify(get_project_root(), ":p:h:t")
  )
  return vim.fn.glob(path)
end

M.java = {
    project_root = get_project_root(),

    java_debug_jars = get_java_debug_jars(),
    vscode_java_test_jars = get_vscode_java_test_jars(),
    lombok_jars = get_lombok_jars(),

    jdtls_home = get_jdtls_home(),
    jdtls_workspace = get_jdtls_home(),
    get_home = get_jdtls_home(),
    get_workspace = get_jdtls_workspace(),
  }

return M
