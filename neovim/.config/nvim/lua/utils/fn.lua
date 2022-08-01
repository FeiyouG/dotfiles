local M = {}

local notify = require("utils.notify")
local str = require("utils.str")

---Shorthabd for printing out the content of a lua table
M.P = function(table)
  print(vim.inspect(table))
  return table
end

---@param obj any: the object to be checked
---@return true: iff obj is callable; false otherwise
M.is_callable = function(obj)
  if type(obj) == "function" then
    return true
  elseif type(obj) == "table" then
    local mt = getmetatable(obj)
    if mt then
      return type(mt.__call) == "function"
    end
  end
  return false
end

---Safely require a package; if failed, return nil and send a one-time notification
---@param name string: the name of the package to be requried
---@param ... any: additional detail to be included in the notification in case of failure
---@return nil|table
M.require = function(name, ...)
  local ok, res = pcall(require, name)
  if not ok then
    notify.failed_to_load(name, ..., res)
    return nil
  end
  return res
end

local validate_plugin_specification = function(plugin, module_name)
  if type(plugin) ~= "table" or vim.tbl_isempty(plugin) or not plugin[1] then
    notify.failed_to_load("a plugin in " .. module_name,
      "Invalid plugin declaration:",
      "  expecting a non-empty table with the first argument being a Github repo.")
    return false
  end

  if type(plugin[1]) ~= "string" or #str.split(plugin[1], "/") ~= 2 then
    notify.failed_to_load("a plugin in " .. module_name,
      "Invalid plugin declaration:",
      "  expecting first argument to be Github repo name ('user_name/repo_name')",
      "  but was '" .. plugin[1] .. "'.")
    return false
  end

  return true
end

local process_plugin_defer = function(plugin, plugin_name)
  if not plugin.defer then return end

  if not M.is_callable(plugin.defer) then
    notify.warn_once(plugin_name, "`plugin.defer` is not callable and will be ignored")
    return
  end

  -- Execute funcitons in plugin.defer after all plugins are configured
  vim.schedule(function()
    local defer_ok, defer_error = pcall(plugin.defer)
    if not defer_ok then
      notify.error(plugin_name, "`plugin.defer()` executated with an error:", defer_error)
    end
  end)
end

-- Add plugin.commands to command_center after all plugins are configured
local process_plugin_commands = function(plugin, plugin_name)
  if not plugin.commands then return end

  if not M.is_callable(plugin.commands) then
    notify.warn_once(plugin_name, "`plugin.commands` is not callable and will be ignored")
    return
  end

  -- Get commands
  local commands_ok, commands = pcall(plugin.commands)
  if not commands_ok then
    notify.error(plugin_name, "`plugin.commands()` executated with an error:", commands)
    return
  end

  -- Valid commands
  if type(commands) ~= "table" then
    notify.error(plugin_name, "Expecting `plugin.commands()` to return a table, but got a " .. type(commands))
    return
  end

  -- Add commands to command_center
  M.add_commands(commands)
end

---Safely load and configure plugins using packer;
---Send a one-time notification if anything went wrong and stop immediately.
---The plugin follows pack plugin-specification convetion with two additional fields: defer and commands
---@param plugin table: the plugin to be used by packer
---@param module_name string: the name of the module to be used
local load_plugin = function(plugin, module_name)
  local packer = M.require("packer", "Can't use or config any modules.")
  if not packer then return end

  if not validate_plugin_specification(plugin, module_name) then return end

  -- use and config plugin through packer
  local plugin_name = str.split(plugin[1], "/")[2]
  local use_ok, use_error = pcall(packer.use, plugin)
  if not use_ok then
    notify.failed_to_load(plugin_name, use_error)
    return
  end

  process_plugin_defer(plugin, plugin_name)
  process_plugin_commands(plugin, plugin_name)

end

---Safely load and configure plugins defined in a module using `packer.nvim`;
---Send a one-time notification if anything went wrong and stop immediately;
---@param module_name string: the name of the module to be used
M.load = function(module_name)
  -- require module
  local module_loaded, module = pcall(require, module_name)
  if not module_loaded then
    notify.failed_to_load(module_name .. "/init.lua", module)
    return
  end

  -- load plugins in module
  for _, plugin in ipairs(module or {}) do
    load_plugin(plugin, module_name)
  end
end

---Properly add commands and register keybindings using `command_center.nvim` in a vim.schedule block
---@param commands table: the commands to be added
---@param opts table?: the options to be passed to `command_center`
M.add_commands = function(commands, opts)
  vim.schedule(function()
    -- Check if comamnd_center is installed
    local command_center = M.require("command_center",
      "command_center is required to register keybindings",
      "Some keybindings may not be set.")
    if not command_center then return end

    -- Check if telescope is installed
    M.require("telescope",
      "Without telescope, keybindings registered by command_center can't be displayed nor searched")

    local add_ok, add_error = pcall(command_center.add, commands, opts)
    if not add_ok then
      notify.error_once("command_center",
        "The function `add()` executated with an error:", add_error)
    end
  end)
end

return M