---- MARK: Automatically download packer if missing ----
local packer_bootstrap = nil

if vim.fn.empty(Utils.path.packer.install_path) > 0 then
  packer_bootstrap = vim.fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    Utils.path.packer.install_path
  })
  vim.cmd [[packadd packer.nvim]]
end
-- MARK: setup packer
local packer = require("packer")
local packer_util = require("packer.util")

packer.reset()
packer.init({
  ensure_dependencies = true, -- Should packer install plugin dependencies?
  profile             = {
    enable = true,
    threshold = 0,
  },

  display = {
    open_fn = packer_util.float,
  }
})


-- MARK: Load Modules
Utils.load("plugin/core")
Utils.load("plugin/cmp")
Utils.load("plugin/buffer")
Utils.load("plugin/dap")
Utils.load("plugin/fuzzy_finder")
Utils.load("plugin/git")
Utils.load("plugin/lsp")
Utils.load("plugin/markdown")
Utils.load("plugin/misc")
Utils.load("plugin/navigation")
Utils.load("plugin/snip_engine")
Utils.load("plugin/style")
Utils.load("plugin/tmux")
Utils.load("plugin/treesitter")
Utils.load("plugin/submodes")
Utils.load("plugin/installer")

-- MARK: Sync config automatically if we just installed packer
if packer_bootstrap then packer.sync() end
