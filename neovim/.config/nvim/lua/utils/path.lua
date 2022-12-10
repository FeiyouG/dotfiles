-- Path related utils
local M = {}
local system = require("utils.system")

M.sep = system.os_name == "win" and "\\" or "/"

---Concatenate paths
M.join = function(...)
	return table.concat(vim.tbl_flatten({ ... }), M.sep)
end

---Check whether directory exist on path
M.is_dir = function(path)
	return vim.fn.isdirectory(vim.fn.glob(path)) == 1
end

---Check whether file exists on path
M.is_file = function(path)
	return vim.fn.filereadable(vim.fn.glob(path)) == 1
end

M.exists = function(path)
	return vim.fn.glob(path) ~= ""
end

---Create dir recursively if dir doesn't exit
M.create_dir = function(path)
	vim.api.nvim_exec("silent !mkdir -p " .. path, false)
	return path
end

---Return the root dir of project based on patterns
M.get_project_root = function(patterns)
	return vim.fs.dirname(vim.fs.find(patterns, { upward = true })[1])
end

---The only difference between this function and vim.fn.glob
---is that this function will return a list of paths that matches the pattern
function M.glob(...)
	local paths = vim.fn.glob(M.join(...))
	if paths == "" then
		return ""
	end

	paths = vim.fn.split(paths, "\n")
	return #paths == 1 and paths[1] or paths
end

---The only difference between this function and vim.fn.expand
---is that this function will return a list of paths that matches the pattern
---The only difference between this function and glob
---Is that this function will return the expanded version of path
---regardless whether it exists or not
function M.expand(...)
	local paths = vim.fn.expand(M.join(...))
	paths = vim.fn.split(paths, "\n")
	return #paths == 1 and paths[1] or paths
end

---If path is not found, then default is returned
function M.glob_with_default(default, ...)
	local paths = M.glob(...)
	if paths == "" then
		return M.glob(default)
	end
	return paths
end

-- If the directory is not found, then create it
function M.expand_and_create(...)
	local paths = M.glob(...)
	if paths == "" then
		paths = M.expand(...)
		vim.api.nvim_exec("silent !mkdir -p " .. paths, false)
		return paths
	end

	return paths
end

-- MARK: System
M.XDG_DIR = {
	CONFIG = M.glob_with_default("$HOME/.config", "$XDG_CONFIG_HOME"),
	CACHE = M.glob_with_default("$HOME/.cache", "$XDG_CACHE_HOME"),
	DATA = M.glob_with_default("$HOME/.local/share", "$XDG_DATA_HOME"),
	STATE = M.glob_with_default("$HOME/.local/state", "$XDG_STATE_HOME"),
}

-- MARK: Plugin related Paths
M.packer = {
	install_path = M.expand(vim.fn.stdpath("data"), "site/pack/packer/start/packer.nvim"),
	snapshot_path = M.expand(vim.fn.stdpath("cache"), "packer.nvim"),
}

M.mason = {
	package_dir = M.glob(vim.fn.stdpath("data"), "mason/packages"),
	bin_dir = M.glob(vim.fn.stdpath("data"), "mason/bin"),
}

-- MARK: Java
M.java = {
	-- executable = JAVA_HOME and M.join(JAVA_HOME, "bin/java") or "java",
	executable = "java",
	project_root = M.get_project_root({
		".git",
		"build.xm", -- Ant
		"pom.xml", -- Maven
		"mvnw", -- Maven
		"gradlew", -- Gradle
		"settings.gradle", -- Gradle
	}),

	debug_adapter_jar = M.glob(
		M.mason.package_dir,
		"java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
	),

	test_jars = M.glob(M.mason.package_dir, "vscode-java-test/server/*jar"),

	lombok_jar = M.glob(M.mason.package_dir, "jdtls/lombok.jar"),

	jdtls_jar = M.glob(M.mason.package_dir, "jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),

	jdtls_config = M.glob(M.mason.package_dir, "jdtls/config_" .. require("Utils.system").os_name),
}

M.java.jdtls_worksapce = M.expand(M.XDG_DIR.CACHE, vim.fn.fnamemodify(M.java.project_root, ":p:h:t"))

-- MARK: Python
M.python = {
	debugby_exec = M.glob(M.mason.install_dir, "packages/debugpy/venv/bin/python"),
	venvPath = M.glob(M.XDG_DIR.DATA, "virtualenvs"),
}

M.xml = {
	lemminx_cache = M.expand(M.XDG_DIR.CACHE, "lemminx"),
}

return M
