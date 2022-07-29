---- MARK: Automatically download packer if missing ----
local packer_bootstrap = nil

if vim.fn.empty(vim.fn.glob(Utils.fn.path.packer.installed_path)) > 0 then
  packer_bootstrap = vim.fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    Utils.fn.path.packer.installed_path
  })
end

-- MARK: setup packer
local packer = require("packer")
local packer_util = require("packer.util")

packer.reset()
packer.init({
  profile = {
    enable = true,
    threshold = 0,
  },

  display = {
    open_fn = packer_util.float,
  }
})

-- MARK: Load Modules
Utils.fn.load("plugin/core")
Utils.fn.load("plugin/cmp")
Utils.fn.load("plugin/dap")
Utils.fn.load("plugin/fuzzy_finder")
Utils.fn.load("plugin/git")
Utils.fn.load("plugin/lsp")
Utils.fn.load("plugin/markdown")
Utils.fn.load("plugin/misc")
Utils.fn.load("plugin/navigation")
Utils.fn.load("plugin/snip_engine")
Utils.fn.load("plugin/style")
Utils.fn.load("plugin/tmux")
Utils.fn.load("plugin/treesitter")
Utils.fn.load("plugin/submodes")

-- MARK: Sync config automatically if we just installed packer
if packer_bootstrap then packer.sync() end
