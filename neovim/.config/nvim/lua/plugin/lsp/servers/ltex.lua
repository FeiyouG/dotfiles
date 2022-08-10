---- MARK: Add user diciontary for ltex0ls ----
local util = require "lspconfig.util"
local handlers = require "vim.lsp.handlers"
local dictionary_name = vim.fn.stdpath('config') .. "/dictionary/ltex_config.json"

-- Load custom dictionary with words/diabledRules/hiddenFalsePositives as json
local function load_config()
  local file = io.open(dictionary_name, "r")
  if file then
    local config = vim.json.decode(file:read "a")
    file:close()
    return config
  end
  return { dictionary = {}, disabledRules = {}, hiddenFalsePositives = {} }
end

-- Update dictionairy in ltex with custom diciontary
-- contain words/diabledRules/hiddenFalsePositives a
local function update_config()
  local ltex = util.get_active_client_by_name(0, "ltex")
  local config = load_config()
  if ltex then
    ltex.config.settings.ltex = config
    ltex.request("workspace/didChangeConfiguration", ltex.config.settings, function(err, result) end)
  end
end

-- Add new words/diabledRules/hiddenFalsePositives custom dictionary
local function add_to_config(type, lang, value)
  local config = load_config()
  local key = config[type][lang]
  if key then
    if not vim.tbl_contains(key, value) then
      table.insert(key, value)
    end
  else
    config[type][lang] = { value }
  end

  local file = io.open(dictionary_name, "w")
  if file then
    file:write(vim.json.encode(config))
    file:close()
  end
  update_config()
end

---Write new words/diabledRules/hiddenFalsePositive to customdictionary
local function populate_config(type, data)
  for k, vv in pairs(data) do
    for _, v in pairs(vv) do
      add_to_config(type, k, v)
    end
  end
end

-- This function is meant to replace the the ltex-ls handlers
-- for executeCommand in order for the custom dictionary to work
local function on_workspace_executecommand(err, content, ctx)
  if ctx.params.command == "_ltex.addToDictionary" then
    local data = ctx.params.arguments[1].words
    populate_config("dictionary", data)
  elseif ctx.params.command == "_ltex.disableRules" then
    local data = ctx.params.arguments[1].ruleIds
    populate_config("disabledRules", data)
  elseif ctx.params.command == "_ltex.hideFalsePositives" then
    local data = ctx.params.arguments[1].falsePositives
    populate_config("hiddenFalsePositives", data)
  else
    handlers[ctx.method](err, content, ctx)
  end
end

return {
  on_init = function(client)
    client.config.settings.ltex = load_config()
  end,

  handlers = {
    ["workspace/executeCommand"] = on_workspace_executecommand,
  }
}
