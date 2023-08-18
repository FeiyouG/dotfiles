local M = {}
_G.settings.fn = M

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

local plugins = nil

---Return true if plugin is installed (may not be loaded)
---@param plugin_name string the name of the plugin to be checked
function M.is_installed(plugin_name)
  if not plugins then
    plugins = {}
    for _, plugin_config in ipairs(require("lazy").plugins()) do
      plugins[plugin_config.name] = plugin_config
    end
  end
  return plugins[plugin_name] ~= nil
end

local os_name = nil

---Get current OS name
---@return string os_name one of "mac", "win", "linux", and "unkown"
function M.os_name()
  if os_name ~= nil then
    return os_name
  end

  local os_list = {
    mac = "mac",
    win32 = "win",
    linux = "linux",
  }

  for os, name in pairs(os_list) do
    if vim.fn.has(os) == 1 then
      os_name = name
      return name
    end
  end

  return "unkown"
end

-- function M.safe_access(t, ...)
-- 	local keys = { ... }
-- 	local table = t
-- 	for _, key in ipairs(keys) do
-- 		if table[key] ~= "table" then
-- 			return nil
-- 		end
-- 		table = table[key]
-- 	end
-- 	return table
-- end

-- ---Create and return an augroup with name
-- ---@param name string
-- ---@return string
-- function M.augroup(name)
-- 	return vim.api.nvim_create_augroup("nvim" .. name, { clear = true })
-- end

---Append those of vals to the end of lst
---if they aren't in lst already;
---if lst is nil, then return an empty list
-- function M.set_append(lst, vals)
-- 	lst = lst or {}
-- 	if not vals then
-- 		return lst
-- 	end
--
-- 	if type(vals) ~= "table" then
-- 		vals = { vals }
-- 	end
-- 	for _, val in ipairs(vals) do
-- 		if not vim.tbl_contains(lst, val) then
-- 			table.insert(lst, val)
-- 		end
-- 	end
-- 	return lst
-- end

-- MARK: LSP
M.lsp = {}
local capabilities = nil

---Get the lsp client capabilities
---@return table capabilities
M.lsp.get_capabilities = function()
  if capabilities then
    return capabilities
  end

  capabilities = vim.lsp.protocol.make_client_capabilities()

  local cmp_avail, cmp = pcall(require, "cmp_nvim_lsp")
  if cmp_avail then
    capabilities.textDocument.completion = cmp.default_capabilities().textDocument.completion
  end

  local snip_avail, _ = pcall(require, "luasnip")
  if snip_avail then
    capabilities.textDocument.completion.completionItem.snippetSupport = true
  end

  local ufo_avil, _ = pcall(require, "ufo")
  if ufo_avil then
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }
  end

  return capabilities
end

---on_attach method shared by all language servers
M.lsp.on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    vim.keymap.set("n", "<leader>sf", function()
      -- Trim trailing white space first
      if not vim.o.binary and vim.o.filetype ~= "diff" and vim.bo.modifiable then
        vim.cmd([[%s/\s\+$//e]])
        vim.cmd("noh")
      end
      vim.lsp.buf.format({ async = true })
    end, { desc = "Format code (lint)" })
    -- 	M.keymap.set({
    -- 		{
    -- 			description = "Format code (lint)",
    -- 			cmd = function()
    -- 				-- Trim trailing white space first
    -- 				if not vim.o.binary and vim.o.filetype ~= "diff" and vim.bo.modifiable then
    -- 					vim.cmd([[%s/\s\+$//e]])
    -- 					vim.cmd("noh")
    -- 				end
    --
    -- 				vim.lsp.buf.format({ async = true })
    -- 			end,
    -- 			keybindings = { "n", "<leader>sf" },
    -- 		},
    -- 	})
  end

  vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentations (hover)" })
  vim.keymap.set("n", "E", vim.diagnostic.open_float, { desc = "Show errors of the current line (floating window)" })
  vim.keymap.set("n", "<leader>sk", vim.lsp.buf.signature_help, { desc = "Show function signature" })
  vim.keymap.set("n", "<leader>sD", vim.lsp.buf.declaration, { desc = "Go to declarations" })
  vim.keymap.set("n", "<leader>sn", vim.lsp.buf.rename, { desc = "Rename symbol" })
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
  vim.keymap.set("n", "<leader>sen", vim.diagnostic.goto_next, { desc = "Go to the next diagnostic item" })
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to the next diagnostic item" })
  vim.keymap.set("n", "<leader>sep", vim.diagnostic.goto_prev, { desc = "Go to the previous diagnostic item" })
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to the previous diagnostic item" })
  vim.keymap.set({ "n", "v" }, "<leader>sa", vim.lsp.buf.code_action, { desc = "Show code actions" })
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

M.keymap = {
  -- set = function(keymaps, opts)
  -- 	local commander_avail, commander = pcall(require, "commander")
  -- 	if commander_avail then
  -- 		commander.add(keymaps, opts)
  -- 	end
  -- end,
}

return M
