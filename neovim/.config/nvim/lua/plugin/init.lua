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

-- Add commands to command_center in a vim.schedule block
local cc_add = function(commands, mode)
  vim.schedule(function()
    local command_center = utils.fn.require("command_center")
    if not command_center then return end

    -- Check if telescope is installed
    utils.fn.require("telescope",
      "Without telescope, keybindings registered by command_center can't be displayed nor searched")

    command_center.add(commands, mode)
  end)
end

-- Safely load modules without break all configs
local use = function(module_name)
  -- require module
  local module_loaded, module = pcall(require, module_name)
  if not module_loaded then
    utils.notify.failed_to_load(module_name, module)
    return
  end

  -- load plugins in module
  for i, plugin in ipairs(module or {}) do

    -- Skip invalid plugin declarations
    if type(plugin) ~= "table" or #plugin == 0 then
      local plugin_name = i .. "th plugin in module " ..module_name
      local details = "Invalid plugin declaration;\nexpecting a non-empty table"
      utils.notify.failed_to_load(plugin_name, details)
      goto continue
    end

    if type(plugin[1]) ~= "string" or #utils.string.split(plugin[1], "/") ~= 2 then
      local plugin_name = i .. "th plugin in module " ..module_name
      local details = "Invalid plugin declaration;\nexpecting first argument to be Github repo name ('user_name/repo_name'),\nbut was " .. plugin[1]
      utils.notify.failed_to_load(plugin_name, details)
      goto continue
    end

    -- use and config plugin through packer
    local plugin_name = utils.string.split(plugin[1], "/")[2]
    local ok, error = pcall(packer.use, plugin)
    if not ok then
      utils.notify.failed_to_load(plugin_name, error)
      goto continue
    end

    -- Execute funcitons in plugin.defer after all plugins are configured
    if plugin.defer and utils.fn.is_callable(plugin.defer) then
      vim.schedule(plugin.defer)
    end

    -- Add plugin.commands to command_center after all plugins are configured
    if plugin.commands then

      local commands = plugin.commands
      -- Evaluate plugin.commands if it is a function
      if utils.fn.is_callable(commands) then
        commands = plugin.commands()
      end

      -- Make sure final commands is a table
      if type(commands) ~= "table" then return end

      -- Add commands to command_center
      cc_add(commands)
    end

    ::continue::
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
use("plugin/submodes")


-- MARK: Add packer commands to command center
local packer_commands = {
  {
    description = "Sync plugins",
    cmd = packer.sync,
  }, {
    description = "Compile plugins",
    cmd = packer.compile
  }, {
    description = "Show plugins startup time",
    cmd = packer.profile
  }, {
    description = "Show plugins status",
    cmd = packer.status
  }, {
    description = "Install missing plugins",
    cmd = packer.install
  }
}

cc_add(packer_commands)

-- MARK: Sync config automatically if we just installed packer
if packer_bootstrap then packer.sync() end
