local fn = require("settings.fn")

local M = {
  java = require("settings.lang.java"),

  python = {
    debugby_exec = fn.glob(vim.env.PACKAGE_INSTALLED_PATH .. "/debugpy/venv/bin/python"),
    venvPath = fn.glob(vim.env.XDG_DATA_HOME .. "/virtualenvs"),
    executable = os.getenv("VIRTUAL_ENV") or os.getenv("VIRTUALENVWRAPPER_PYTHON"),
  },

  xml = {
    lemminx_cache = vim.env.XDG_CACHE_HOME .. "/lemminx",
  },

  beancount = {
    journal_file = fn.glob("$HOME/Vault/Fin/init.beancount"),
  },
}

return M
