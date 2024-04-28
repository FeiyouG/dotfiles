local M = {}

---@type {string : LazyPlugin}
local plugins = nil

---Load plugin specs into memory
local function load_plugin_spec()
	if not plugins then
		plugins = {}
		for _, plugin_config in ipairs(require("lazy").plugins()) do
			local main = require("lazy.core.loader").get_main(plugin_config) or plugin_config.name
			plugins[main] = plugin_config
		end
	end
end

---Return true if plugin is installed (may not be loaded)
---
---@param plugin_name string the name of the plugin to be checked
function M.is_installed(plugin_name)
	load_plugin_spec()
	return plugins[plugin_name] ~= nil
end

---Return the spec of the given plugin, or nil if
---
---@param plugin_name string the name of a plugin
---@return LazyPlugin|nil
function M.get_spec(plugin_name)
	load_plugin_spec()
	return plugins[plugin_name]
end

---Immediately load the plugin if it is configured and installed and return it
---
---@param plugin_name string the name of the plugin
---@return any plugin
function M.load(plugin_name)
	if not M.is_installed(plugin_name) then
		return nil
	end
	require("lazy").load({
		plugins = { plugins[plugin_name].name },
		show = false,
		wait = false,
	})
	return require(plugin_name)
end

return M
