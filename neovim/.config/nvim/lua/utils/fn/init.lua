local M = {
  str = require("utils.fn.str"),
  lsp = require("utils.fn.lsp"),
  notify = require("utils.fn.notify"),
  path = require("utils.fn.path"),
}

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
    M.notify.failed_to_load(name, ..., res)
    return nil
  end
  return res
end

---Safely load and configure plugins using packer;
---Send a one-time notification if anything went wrong and stop immediately.
---The plugin follows pack plugin-specification convetion with two additional fields: defer and commands
---@param plugin table: the plugin to be used by packer
---@param module_name string: the name of the module to be used
local load_plugin = function(plugin, module_name)
  local packer = M.require("packer", "Can't use or config any modules.")
  if not packer then return end

  -- Skip invalid plugin declarations
  if type(plugin) ~= "table" or vim.tbl_isempty(plugin) or not plugin[1] then
    M.notify.failed_to_load("a plugin in " .. module_name,
      "Invalid plugin declaration:",
      "  expecting a non-empty table with the first argument being a Github repo.")
    return
  end

  if type(plugin[1]) ~= "string" or #M.str.split(plugin[1], "/") ~= 2 then
    M.notify.failed_to_load("a plugin in " .. module_name,
      "Invalid plugin declaration:",
      "  expecting first argument to be Github repo name ('user_name/repo_name')",
      "  but was '" .. plugin[1] .. "'.")
    return
  end

  -- use and config plugin through packer
  local plugin_name = M.str.split(plugin[1], "/")[2]
  local use_ok, use_error = pcall(packer.use, plugin)
  if not use_ok then
    M.notify.failed_to_load(plugin_name, use_error)
    return
  end

  -- Execute funcitons in plugin.defer after all plugins are configured
  if plugin.defer and M.is_callable(plugin.defer) then
    vim.schedule(function()
      local defer_ok, defer_error = pcall(plugin.defer)
      if not defer_ok then
        M.notify.error(plugin_name, "The function `plugin.defer()` executated with an error:", defer_error)
      end
    end)
  end

  -- Add plugin.commands to command_center after all plugins are configured
  if plugin.commands then

    local commands = plugin.commands
    -- Evaluate plugin.commands if it is a function
    if M.is_callable(commands) then
      local commands_ok, commands_res = pcall(plugin.commands)
      if not commands_ok then
        M.notify.error(plugin_name, "The function `plugin.commands()` executated with an error:", commands_res)
        return
      end
      commands = commands_res
    end

    -- Make sure final commands is a table
    if type(commands) ~= "table" then
      M.notify.error(plugin_name, "Expect a table returned by `plugin.commands`, but got a " .. type(commands))
      return
    end

    -- Add commands to command_center
    M.add_commands(commands)
  end
end

---Safely load and configure plugins defined in a module using `packer.nvim`;
---Send a one-time notification if anything went wrong and stop immediately;
---@param module_name string: the name of the module to be used
M.load = function(module_name)
  -- require module
  local module_loaded, module = pcall(require, module_name)
  if not module_loaded then
    M.notify.failed_to_load(module_name .. "/init.lua", module)
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
      M.notify.error_once("command_center",
        "The function `add()` executated with an error:", add_error)
    end
  end)
end

return M
