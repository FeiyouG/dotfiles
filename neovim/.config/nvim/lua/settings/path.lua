local M = {}
_G.settings.path = M

local fn = require("settings.fn")

M.stdpath = {
	config = vim.fn.stdpath("config"),
	cache = vim.fn.stdpath("cache"),
	data = vim.fn.stdpath("data"),
	state = vim.fn.stdpath("state"),
}

M.plugin = {
	home = M.stdpath.data .. "/plugins",
	dev = M.stdpath.data .. "/dev",
  lockfile = M.stdpath.cache .. "plugin/lock",
	manager = {
		name = "lazy",
		url = "https://github.com/folke/lazy.nvim.git",
		install_path = M.stdpath.data .. "/plugins/lazy.nvim",
	},
}

M.installer = {
	home = M.stdpath.data .. "/mason",
	packages = M.stdpath.data .. "/mason/packages",
	bin = M.stdpath.data .. "/mason/bin",
}

M.snippet = {
  home = M.stdpath.config .. "/snippets",
  vscode = M.stdpath.config .. "/snippets/vscode",
  lua = M.stdpath.config .. "/snippets/lua",
}

-- MARK: Java
local java_project_root = fn.project_root({
	".git",
	"build.xm", -- Ant
	"pom.xml", -- Maven
	"mvnw", -- Maven
	"gradlew", -- Gradle
	"settings.gradle", -- Gradle
})

M.java = {
	project_root = java_project_root,
	debug_adapter = vim.fn.glob(
		M.installer.packages .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
	),
	test = vim.fn.split(vim.fn.glob(M.installer.packages .. "/java-test/extension/server/*jar"), "\n"),
	lombok = vim.fn.glob(M.installer.packages .. "/jdtls/lombok.jar"),
	jdtls = vim.fn.glob(M.installer.packages .. "/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
	jdtls_config = vim.fn.glob(M.installer.packages .. "/jdtls/config_" .. fn.os_name()),
	jdtls_worksapce = M.stdpath.cache .. "/java/jdtls/" .. vim.fn.fnamemodify(java_project_root, ":p:h:t"),
}

-- MARK: python
M.python = {
	debugpy = vim.fn.glob(M.installer.bin .. "/debugpy"),
	virtualenv = vim.fn.glob(M.stdpath.data .. "/virtualenvs"),
	executable = os.getenv("VIRTUAL_ENV") or os.getenv("VIRTUALENVWRAPPER_PYTHON"),
}

M.xml = {
	lemminx_cache = M.installer.packages .. "/lemminx",
}

-- 	beancount = {
-- 		journal_file = fn.glob("$HOME/Vault/Fin/init.beancount"),
-- 	},
M.spell = {
  home = M.stdpath.config .. "/spell",
	spellfile = M.stdpath.config .. "/spell/en.utf-8.add",
}

-- Make sure spell.home directory is created
vim.fn.mkdir(M.spell.home, "p")

return M
