-- Path related utils
local M = {}

M.sep = require("utils.system").os_name == "win" and "\\" or "/"

---Concatenate paths||
M.join = function(...)
  return table.concat(vim.tbl_flatten {...}, M.sep)
end

---Check whether directory exist on path
M.dir_exists = function(path)
  return vim.fn.isdirectory(vim.fn.glob(path)) == 1
end

---Check whether file exists on path
M.file_exists = function(path)
  return vim.fn.filereadable(vim.fn.glob(path)) == 1
end

---Create path recursively if path doesn't exit
M.safe_path = function(path)
  vim.api.nvim_exec("!safe_path " .. path, false)
end

M.get_root = function(markers, bufname)
  bufname = bufname or vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
  local dirname = vim.fn.fnamemodify(bufname, ':p:h')
  local getparent = function(p)
    return vim.fn.fnamemodify(p, ':h')
  end
  while getparent(dirname) ~= dirname do
    for _, marker in ipairs(markers) do
      if vim.loop.fs_stat(M.join(dirname, marker)) then
        return dirname
      end
    end
    dirname = getparent(dirname)
  end
end

-- MARK: Packer related path
M.packer = {
  installed_path = vim.fn.glob(M.join(
    vim.fn.stdpath('data'),
    'site/pack/packer/start/packer.nvim'
  )),
}

-- MARK: Java related path
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
  return path ~= "" and path or nil
end

local get_project_root = function()
  return M.get_root({ ".git", "mvnw", "gradlew" })
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
