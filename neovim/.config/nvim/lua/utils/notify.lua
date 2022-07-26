local M = {}

-- Send a notification with default style and settings
M.default = function(message, level, opts)
  -- Ignore if message is nil or empty
  if not message or message == '' then return end

  -- Setup default values for parameters
  level = level or vim.log.levels.INFO
  opts = vim.tbl_deep_extend("force", {
    render = "default"
  }, opts or {})

  if opts.once then
    opts.once = nil
    require("notify").notify_once(message, level, opts)
  else
    require("notify")(message, level, opts)
  end
end

-- Send quick notification with minial style
M.minimal = function(message, level, opts)
  opts = opts or {}

  opts = vim.tbl_deep_extend("force", {
    timeout = 50,
    render = "minimal",
  }, opts or {})

  M.default(message, level, opts)
end

-- Notify when entered a custom mode
M.enter_mode = function(mode_name, mode_icon)
  local message = " " .. mode_icon .. " Entered " .. mode_name .. " submode"
  M.minimal(message, vim.log.levels.INFO, {
    hide_from_history = true,
  })
end

-- Notify when exited a custom mode
M.exit_mode = function(mode_name, mode_icon)
  local message = " " .. mode_icon .. " Exited " .. mode_name .. " submode"
  M.minimal(message, vim.log.levels.INFO, {
    hide_from_history = true,
  })
end

return M
