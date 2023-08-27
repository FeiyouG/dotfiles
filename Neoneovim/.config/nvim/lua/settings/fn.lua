local M = {}
_G.settings.fn = M

-- SECTION: Utility

local os_name = nil

---Get current OS name
---@return string os_name one of "mac", "win", "linux", and "unkown"
function M.os_name()
  if os_name ~= nil then return os_name end

  for os, name in pairs({
    mac = "mac",
    win32 = "win",
    linux = "linux",
  }) do
    if vim.fn.has(os) == 1 then
      os_name = name
      return name
    end
  end

  os_name = "unkown"
  return os_name
end

---@param obj any the object to be checked
---@return boolean is_callable true if obj is callable
function M.is_callable(obj)
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

---Return the name of the root directory of the current project based on patterns
---@param patterns {[integer]: string} | nil files/dirs that the root dir would contain; look for ,git folder by default
---@return string path the path of the root directory
function M.project_root(patterns)
  patterns = patterns or { ".git" }
  return vim.fs.dirname(vim.fs.find(patterns, { upward = true })[1])
end

-- SECTION: Plugin
M.plugin = {}

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
---@param plugin_name string the name of the plugin to be checked
function M.plugin.is_installed(plugin_name)
  load_plugin_spec()
  return plugins[plugin_name] ~= nil
end

---Return the spec of the given plugin, or nil if
---@param plugin_name string the name of a plugin
---@return LazyPlugin|nil
function M.plugin.get_spec(plugin_name)
  load_plugin_spec()
  return plugins[plugin_name]
end

---Immediately load the plugin if it is configured and installed and return it
---@param plugin_name string the name of the plugin
---@return any plugin
function M.plugin.load(plugin_name)
  if not M.plugin.is_installed(plugin_name) then return nil end
  require("lazy").load({
    plugins = { plugins[plugin_name].name },
    show = false,
    wait = false,
  })
  return require(plugin_name)
end

-- SECTION: Command
-- M.command = {
--   ---@param items Item
--   ---@param opts? Config
--   add = function(items, opts)
--     if not M.plugin.is_installed("commander") then return end
--     print("HERE!")
--     M.plugin.load("commander").add(items, opts)
--   end
-- }

-- SECTION: LSP
M.lsp = {}

---@type {string: any}
local capabilities = nil

---Get the lsp client capabilities
---@return {string: any} capabilities
M.lsp.get_capabilities = function()
  if capabilities then
    return capabilities
  end

  capabilities = vim.lsp.protocol.make_client_capabilities()

  if M.plugin.is_installed("cmp_nvim_lsp") then
    capabilities.textDocument.completion = M.plugin.load("cmp_nvim_lsp")
        .default_capabilities().textDocument.completion
  end

  if M.plugin.is_installed("luasnip") then
    capabilities.textDocument.completion.completionItem.snippetSupport = true
  end

  if M.plugin.is_installed("ufo") then
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }
  end

  return capabilities
end

---Common logic in on_attach method shared by all language servers
M.lsp.on_attach = function(client, bufnr)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentations (hover)" })
  vim.keymap.set("n", "E", vim.diagnostic.open_float, { desc = "Show errors of the current line (floating window)" })
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to the next diagnostic item" })
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to the previous diagnostic item" })
  vim.keymap.set("n", "<leader>sk", vim.lsp.buf.signature_help, { desc = "Show function signature" })
  vim.keymap.set("n", "<leader>sD", vim.lsp.buf.declaration, { desc = "Go to declarations" })
  vim.keymap.set("n", "<leader>sn", vim.lsp.buf.rename, { desc = "Rename symbol" })
  vim.keymap.set("n", "<leader>sen", vim.diagnostic.goto_next, { desc = "Go to the next diagnostic item" })
  vim.keymap.set("n", "<leader>sep", vim.diagnostic.goto_prev, { desc = "Go to the previous diagnostic item" })
  vim.keymap.set({ "n", "v" }, "<leader>sa", vim.lsp.buf.code_action, { desc = "Show code actions" })
  vim.keymap.set("n", "<leader>sf",
    function()
      -- Trim trailing white space first
      if not vim.o.binary and vim.o.filetype ~= "diff" and vim.bo.modifiable then
        vim.cmd([[%s/\s\+$//e]])
        vim.cmd("noh")
      end

      if client.server_capabilities.documentFormattingProvider then
        vim.lsp.buf.format({ async = true })
      end
    end, { desc = "Show documentations (hover)" })

  if M.plugin.is_installed("telescope") then
    M.plugin.load("telescope")

    vim.keymap.set("n", "<leader>sd", "<CMD>Telescope lsp_definitions<CR>", { desc = "Go to definitions" })
    vim.keymap.set("n", "<leader>st", "<CMD>Telescope lsp_type_definitions<CR>", { desc = "Go to type definitions" })
    vim.keymap.set("n", "<leader>sr", "<CMD>Telescope lsp_references<CR>", { desc = "Show all references" })
    vim.keymap.set(
      "n",
      "<leader>ssw",
      "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>",
      { desc = "show workspace symbols" }
    )
    vim.keymap.set("n", "<leader>si", "<CMD>Telescope lsp_implementations<CR>", { desc = "Go to implementations" })
    vim.keymap.set("n", "<leader>se", "<CMD>Telescope diagnostics<CR>", { desc = "Show workspace errors (diagnostic)" })
    vim.keymap.set(
      "n",
      "<leader>sef",
      "<CMD>Telescope diagnostics<CR>",
      { desc = "Show workspace errors (diagnostic)" }
    )
    vim.keymap.set("n", "<leader>ssd", "<CMD>Telescope lsp_document_symbols<CR>", { desc = "Show document symbols" })
    vim.keymap.set("n", "<leader>ss", "<CMD>Telescope lsp_document_symbols<CR>", { desc = "Show document symbols" })
  end
end

return M
