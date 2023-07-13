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

---Return the name of the root directory of project based on patterns
---@param patterns {[integer]: string} | nil files/dirs that the root dir would contain; look for ,git folder by default
---@return string path the path of the root directory
function M.project_root(patterns)
  patterns = patterns or { ".git" }
  return vim.fs.dirname(vim.fs.find(patterns, { upward = true })[1])
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
    M.keymap.set({
      {
        description = "Format code (lint)",
        cmd = function()
          -- Trim trailing white space first
          if not vim.o.binary and vim.o.filetype ~= "diff" and vim.bo.modifiable then
            vim.cmd([[%s/\s\+$//e]])
            vim.cmd("noh")
          end

          vim.lsp.buf.format({ async = true })
        end,
        keybindings = { "n", "<leader>sf" },
      },
    })
  end

  M.keymap.set({
    {
      description = "Show documentations (hover)",
      cmd = vim.lsp.buf.hover,
      keybindings = { "n", "K" },
    },
    {
      description = "Show errors of the current line (floating window)",
      cmd = vim.diagnostic.open_float,
      keybindings = { "n", "E" },
    },
    {
      description = "Go to the next diagnostic item",
      cmd = vim.diagnostic.goto_next,
      keybindings = {
        { "n", "<leader>sen" },
        { "n", "]d" },
      },
    },
    {
      description = "Go to the previous diagnostic item",
      cmd = vim.diagnostic.goto_prev,
      keybindings = {
        { "n", "<leader>sep" },
        { "n", "[d" },
      },
    },
    {
      description = "Show function signature",
      cmd = vim.lsp.buf.signature_help,
      keybindings = { "n", "<leader>sk" },
    },
    {
      description = "Go to declarations",
      cmd = vim.lsp.buf.declaration,
      keybindings = { "n", "<leader>sD" },
    },
    {
      description = "Rename symbol",
      cmd = vim.lsp.buf.rename,
      keybindings = { "n", "<leader>sn" },
    },
    -- Commands that take advantages of Telescope
    {
      description = "Show code actions",
      cmd = vim.lsp.buf.code_action,
      keybindings = {
        { "n", "<leader>sa" },
        { "v", "<leader>sa" },
      },
    },
    {
      description = "Go to definitions",
      cmd = "<CMD>Telescope lsp_definitions<CR>",
      keybindings = { "n", "<leader>sd" },
    },
    {
      description = "Go to type definitions",
      cmd = "<CMD>Telescope lsp_type_definitions<CR>",
      keybindings = { "n", "<leader>st" },
    },
    {
      description = "Show all references",
      cmd = "<CMD>Telescope lsp_references<CR>",
      keybindings = { "n", "<leader>sr" },
    },
    {
      description = "Show workspace errors (diagnostic)",
      cmd = "<CMD>Telescope diagnostics<CR>",
      keybindings = {
        { "n", "<leader>se" },
        { "n", "<leader>sef" },
      },
    },
    {
      description = "Go to implementations",
      cmd = "<CMD>Telescope lsp_implementations<CR>",
      keybindings = { "n", "<leader>si" },
      category = "lsp",
    },
    {
      description = "Show document symbols",
      cmd = "<CMD>Telescope lsp_document_symbols<CR>",
      keybindings = {
        { "n", "<leader>ss" },
        { "n", "<leader>ssd" },
      },
    },
    {
      description = "show workspace symbols",
      cmd = "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>",
      keybindings = { "n", "<leader>ssw" },
    },
  })
end

M.keymap = {
  set = function(keymaps, opts)
    local commander_avail, commander = pcall(require, "commander")
    if commander_avail then
      commander.add(keymaps, opts)
    end
  end,
}

return M
