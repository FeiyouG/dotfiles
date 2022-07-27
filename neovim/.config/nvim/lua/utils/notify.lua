local M = {}

local notified = {}

-- Send a notification with default style and settings
-- @param title string: the title for the notification
-- @param message string: the body of the notification; can't be nil nor empty
-- @param level number: the logging level of this notification
-- @param opts table: additional nvim-notify options for this notification
M.default = function(title, message, level, opts)

  -- Ignore if message is nil or empty
  if not message or message == '' then return end

  -- Setup default values for parameters
  level = level or vim.log.levels.INFO
  opts = vim.tbl_deep_extend("force", {
    render = "default",
    title = title or "",
  }, opts or {})

  if opts.once and notified[title .. message] then
    return
  end

  notified[title .. message] = true
  opts.once = nil

  -- Send the notification after nvim-notify is fully configured
  vim.schedule(function()
    require("notify")(message, level, opts)
  end)
end

-- Send quick notification with minial style
-- @param message string: the body of the notification; can't be nil nor empty
-- @param level number: the logging level of this notification
-- @param opts table: additional nvim-notify options for this notification
M.minimal = function(message, level, opts)
  opts = opts or {}

  opts = vim.tbl_deep_extend("force", {
    timeout = 500,
    render = "minimal",
  }, opts or {})

  M.default("", message, level, opts)
end

-- Notify when entered a custom mode
-- @param mode_name string: the name of the submode that are entered
-- @paarm mode_icon string: the icon for the submode
M.enter_mode = function(mode_name, mode_icon)
  local message = " " .. mode_icon .. " Entered " .. mode_name .. " submode "
  M.minimal(message, vim.log.levels.INFO, {
    hide_from_history = true,
  })
end

-- Notify when exited a custom mode
-- @param mode_name string: the name of the submode that are exited
-- @paarm mode_icon string: the icon for the submode
M.exit_mode = function(mode_name, mode_icon)
  local message = " " .. mode_icon .. " Exited " .. mode_name .. " submode "
  M.minimal(message, vim.log.levels.INFO, {
    hide_from_history = true,
  })
end

-- Send a one-time notification when plugin is not loaded properly
-- @param name string: the name of the plugin that isn't loaded
-- @param ... string: additional details to be included in the notification
M.failed_to_load = function(name, ...)
  local message = "Failed to load " .. name
  local details = table.concat({ ... }, "\n")
  details = "Make sure " .. name .. " is installed.\n" .. details
  M.default(message, details, vim.log.levels.ERROR, { once = true })
end

return M
