local fn = require("settings.fn")

local M = {
  executable = "java",
  project_root = fn.find_root({
    ".git",
    "build.xm", -- Ant
    "pom.xml", -- Maven
    "mvnw", -- Maven
    "gradlew", -- Gradle
    "settings.gradle", -- Gradle
  }),

  debug_adapter_jar = fn.glob(
    vim.env.PACKAGE_INSTALLED_PATH .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
  ),

  test_jars = fn.split(fn.glob(vim.env.PACKAGE_INSTALLED_PATH .. "/java-test/extension/server/*jar"), "\n"),

  lombok_jar = vim.env.PACKAGE_INSTALLED_PATH .. "/jdtls/lombok.jar",

  jdtls_jar = fn.glob(vim.env.PACKAGE_INSTALLED_PATH .. "/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),

  jdtls_config = vim.env.PACKAGE_INSTALLED_PATH .. "/jdtls/config_" .. fn.os_name(),
}

M.jdtls_worksapce = vim.env.XDG_CACHE_HOME .. "/java/jdtls/" .. fn.fnamemodify(M.project_root, ":p:h:t")

return M
