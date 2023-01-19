local fn = require("settings.fn")
-- XDG Directories
fn.set_envs({
  XDG_CONFIG_HOME = "$HOME/.config",
  XDG_CACHE_HOME = "$HOME/.cache",
  XDG_DATA_HOME = "$HOME/.local/share",
  XDG_STATE_HOME = "$HOME/.local/state",
})

-- Plugins
fn.set_envs({
  PLUGIN_HOME = vim.fn.stdpath("data") .. "/lazy",
  PLUGIN_MANAGER_PATH = vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
})

-- Package manager
fn.set_envs({
  PACKAGE_HOME = vim.fn.stdpath("data") .. "/mason",
  PACKAGE_INSTALLED_PATH = vim.fn.stdpath("data") .. "/mason/packages",
  PACKAGE_BIN_PATH = vim.fn.stdpath("data") .. "/mason/bin",
})

-- Misc
fn.set_envs({
  DEV_HOME = vim.fn.stdpath("data") .. "/dev",
})
