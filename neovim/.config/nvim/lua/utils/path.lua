-- Path related utils
local M = {}

M.sep = require("utils.system").os_name == "win" and "\\" or "/"

---Concatenate paths||
M.join = function(...)
  return table.concat(vim.tbl_flatten { ... }, M.sep)
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

M.get_project_root = function(patterns)
  return vim.fs.dirname(vim.fs.find(patterns, { upward = true })[1])
end

local function get_path(...)
  local path = vim.fn.glob(M.join(...))
  return path ~= "" and vim.fn.split(path, "\n") or {}
end

-- MARK: Plugin related Paths
M.packer = {
  install_path = M.join(
    vim.fn.stdpath('data'),
    'site/pack/packer/start/packer.nvim'
  ),
}

M.mason = {
  install_dir = get_path(
    vim.fn.stdpath('data'),
    "mason"
  )[1],

  package_dir = get_path(
    vim.fn.stdpath('data'),
    "mason/packages"
  )[1]
}

-- MARK: Java
local JAVA_HOME = os.getenv("JAVA_HOME")
M.java = {
  -- executable = JAVA_HOME and M.join(JAVA_HOME, "bin/java") or "java",
  executable = "java",
  project_root = M.get_project_root({ '.git', 'mvnw', 'gradlew' }),

  debug_adapter_jar = get_path(
    M.mason.package_dir,
    "java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
  )[1],

  test_jars = get_path(
    M.mason.package_dir,
    "vscode-java-test/server/*jar"
  ),

  lombok_jar = get_path(
    M.mason.package_dir,
    "jdtls/lombok.jar"
  )[1],

  jdtls_jar = get_path(
    M.mason.package_dir,
    'jdtls/plugins/org.eclipse.equinox.launcher_*.jar'
  )[1],

  jdtls_config = get_path(
    M.mason.package_dir,
    'jdtls/config_' .. require("Utils.system").os_name
  )[1],

  jdtls_worksapce = M.join(
    vim.fn.glob("$XDG_CACHE_HOME/jdtls-workspace"),
    vim.fn.fnamemodify(
      M.get_project_root({ '.git', 'mvnw', 'gradlew' }),
      ":p:h:t")
  )
}

-- MARK: Python
M.python = {
  debugby_exec = get_path(
    M.mason.install_dir,
    "packages/debugpy/venv/bin/python"
  )[1],
}

return M
