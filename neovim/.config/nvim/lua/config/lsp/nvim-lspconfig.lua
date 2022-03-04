-- MARK: Key Mappings
local map = vim.api.nvim_set_keymap
local noremap = {noremap = true}
local silent_noremap = {noremap = true, silent = true}

map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", silent_noremap)
map("n", "E", "<cmd>lua vim.diagnostic.open_float()<CR>", silent_noremap)
map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", silent_noremap)
map("n", "<leader>sD", "<cmd>lua vim.lsp.buf.declaration()<CR>", silent_noremap)
map("n", "<leader>sn", "<cmd>lua vim.lsp.buf.rename()<CR>", silent_noremap)
map("n", "<leader>sf", "<cmd>lua vim.lsp.buf.formatting()<CR>", silent_noremap)

-- Keymaps that depend on Telescope
map("n", "<leader>sa", "<cmd>Telescope lsp_code_actions<CR>", noremap)
map("v", "<leader>sa", "<cmd>Telescope lsp_range_code_actions<CR>", noremap)
map("n", "<leader>sd", "<cmd>Telescope lsp_definitions<CR>", noremap)
map("n", "<leader>st", "<cmd>Telescope lsp_type_definitions<CR>", noremap)
map("n", "<leader>sr", "<cmd>Telescope lsp_references<CR>", noremap)
map("n", "<leader>se", "<cmd>Telescope diagnostic<CR>", noremap)
map("n", "<leader>si", "<cmd>Telescope lsp_implementations<CR>", noremap)
map("n", "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>", noremap)
map("n", "<leader><leader>ss", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", noremap)

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
