-- SECTION: Diagnostic Settings: disable virtual text
vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  sign = true,
  float = {
    scope = "line", -- "buffer", "line", or "cursor"
    source = true, -- true, "if_mnay", or false
  },
  update_in_insert = false,
  severity_sort = true,
})

-- SECTION: Add boarder to floating window
local lsp_util_open_floating_preview = vim.lsp.util.open_floating_preview
local icons = require("settings.icons")

---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or icons.editor.border.rounded_with_hl
  return lsp_util_open_floating_preview(contents, syntax, opts, ...)
end

-- SECTION: Change diagnostic symbol in sign column
for type, icon in pairs({
  Error = settings.icons.diagnostic.error,
  Warn = settings.icons.diagnostic.warning,
  Hint = settings.icons.diagnostic.hint,
  Info = settings.icons.diagnostic.info,
}) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
