-- MARK: Key Mappings
local noremap = {noremap = true}
local silent_noremap = {noremap = true, silent = true}
local command_center = require('command_center')

command_center.add({
    {
    description = "Show documentations (hover)",
    command = "lua vim.lsp.buf.hover()",
    keybindings = { "n", "K", silent_noremap },
  }, {
    description = "Show errors of the current line",
    command = "lua vim.diagnostic.open_float()",
    keybindings = { "n", "E", silent_noremap },
  }, {
    description = "Show function signature",
    command = "lua vim.lsp.buf.signature_help()",
    keybindings = { "n", "<leader>sk", silent_noremap },
  }, {
    description = "Go to declarations",
    command = "lua vim.lsp.buf.declaration()",
    keybindings = { "n", "<leader>sD", silent_noremap },
  }, {
    description = "Rename symbol",
    command = "lua vim.lsp.buf.rename()",
    keybindings = { "n", "<leader>sn", silent_noremap },
  }, {
    description = "Format code (lint)",
    command = "lua vim.lsp.buf.formatting()",
    keybindings = { "n", "<leader>sf", silent_noremap },
  }
})

-- Commands takes advantages of Telescope
command_center.add({
  {
    description = "Show code actions",
    command = "Telescope lsp_code_actions",
    keybindings = { "n", "<leader>sa", noremap },
  },{
    description = "Show range code actions",
    command = "Telescope lsp_range_code_actions",
    keybindings = { "v", "<leader>sa", noremap },
  },{
    description = "Go to definitions",
    command = "Telescope lsp_definitions",
    keybindings = { "n", "<leader>sd", noremap },
  },{
    description = "Go to type definitions",
    command = "Telescope lsp_type_definitions",
    keybindings = { "n", "<leader>st", noremap },
  },{
    description = "Show all references",
    command = "Telescope lsp_references",
    keybindings = { "n", "<leader>sr", noremap },
  },{
    description = "Show workspace errors (diagnostic)",
    command = "Telescope diagnostics",
    keybindings = { "n", "<leader>se", noremap },
  },{
    description = "Go to implementations",
    command = "Telescope lsp_implementations",
    keybindings = { "n", "<leader>si", noremap },
  },{
    description = "Show document symbols",
    command = "Telescope lsp_document_symbols",
    keybindings = {
      {"n", "<leader>ss", noremap },
      {"n", "<leader>ssd", noremap },
    },
  },{
    description = "show workspace symbols",
    command = "Telescope lsp_dynamic_workspace_symbols",
    keybindings = { "n", "<leader>ssw", noremap },
  }
})


-- MARK: Diagnostic Settings
-- Diable virtual text
vim.diagnostic.config({
  virtual_text = false,
  float = {
    scope = "line",     -- "buffer", "line", or "cursor"
    source = true,      -- true, "if_mnay", or false
  }

})

-- Show diagnostic on the current line in a floating window
-- vim.diagnostic.open_float({
--   scope = "line",     -- "buffer", "line", or "cursor"
--   source = true,      -- true, "if_mnay", or false
--   prefix = "",
-- })

---- MARK: Change diagnostic symbol in signl column
-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


-- MARK: Go to defintion in a split window
-- local function goto_definition(split_cmd)
--   local util = vim.lsp.util
--   local log = require("vim.lsp.log")
--   local api = vim.api

--   -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
--   local handler = function(_, result, ctx)
--     if result == nil or vim.tbl_isempty(result) then
--       local _ = log.info() and log.info(ctx.method, "No location found")
--       return nil
--     end

--     if split_cmd then
--       vim.cmd(split_cmd)
--     end

--     if vim.tbl_islist(result) then
--       util.jump_to_location(result[1])

--       if #result > 1 then
--         util.set_qflist(util.locations_to_items(result))
--         api.nvim_command("copen")
--         api.nvim_command("wincmd p")
--       end
--     else
--       util.jump_to_location(result)
--     end
--   end

--   return handler
-- end

-- vim.lsp.handlers["textDocument/definition"] = goto_definition('split')


---- MARK: Add boarder to lsp popup window
-- vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
-- vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]
-- local border = {
--   { "🭽", "FloatBorder" },
--   { "▔", "FloatBorder" },
--   { "🭾", "FloatBorder" },
--   { "▕", "FloatBorder" },
--   { "🭿", "FloatBorder" },
--   { "▁", "FloatBorder" },
--   { "🭼", "FloatBorder" },
--   { "▏", "FloatBorder" },
-- }
-- -- local border = {
-- --       {"", "FloatBorder"},
-- --       {"⎺", "FloatBorder"},
-- --       {"⌝", "FloatBorder"},
-- --       {"⏐", "FloatBorder"},
-- --       {"⌟", "FloatBorder"},
-- --       {"_", "FloatBorder"},
-- --       {"⌞", "FloatBorder"},
-- --       {"⎸", "FloatBorder"},
-- -- }

-- -- To instead override globally
-- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
--   opts = opts or {}
--   opts.border = opts.border or border
--   return orig_util_open_floating_preview(contents, syntax, opts, ...)
-- end
