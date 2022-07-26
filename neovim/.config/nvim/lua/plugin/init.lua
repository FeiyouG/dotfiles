local utils = require("utils")

---- MARK: Automatically download packer if missing ----
local packer_bootstrap = nil

if vim.fn.empty(vim.fn.glob(utils.path.packer.installed_path)) > 0 then
  packer_bootstrap = vim.fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    utils.path.packer.installed_path
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

-- Safely load modules without break all configs
local use = function(module_name)
  -- Load Module
  local module_loaded, module = pcall(require, module_name)
  if not module_loaded then
    print("Failed to load module [" .. module_name .. "]: " .. module)
    return
  end

  -- Load plugins in module
  for _, plugin in ipairs(module or {}) do
    -- P(plugin)
    local plugin_loaded, error = pcall(packer.use, plugin)
    if plugin_loaded then
      -- function in schedule will be executated after all plugin is installed
      if plugin.defer then vim.schedule(plugin.defer) end
    else
      print("Failed to load plugin [" .. plugin[0] .. "]: \n" .. error)
    end
  end

end

-- Reduce Startup time by caching
packer.use { 'wbthomason/packer.nvim' }
packer.use { 'lewis6991/impatient.nvim' }

-- Modules
use("plugin/cmp_engine")
use("plugin/dap")
use("plugin/fuzzy_finder")
use("plugin/git")
use("plugin/lsp")
use("plugin/markdown")
use("plugin/misc")
use("plugin/navigation")
use("plugin/snip_engine")
use("plugin/style")
use("plugin/tmux")
use("plugin/treesitter")
use("plugin/modes")


-- MARK: Add commands to command center
local has_command_center, command_center = pcall(require, "command_center")
if has_command_center then
  command_center.add({
    {
      description = "Sync plugins",
      cmd = packer.sync
    }, {
      description = "Compile plugins",
      cmd = packer.compile
    }, {
      description = "Show plugins startup time",
      cmd = packer.profile
    }, {
      description = "Show plugins status",
      cmd = packer.status
    },
  })
end


-- MARK: Automatically update

-- Sync config automatically if we just installed packer
if packer_bootstrap then packer.sync() end

-- Compile config automatically after saving this file
local auto_packer_sync = vim.api.nvim_create_augroup("auto_packer_sync", { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  callback = function() packer.compile() end,
  -- callback = function() packer.sync()  end,
  group = auto_packer_sync,
  pattern = "**/nvim/lua/plugin/init.lua"
})
