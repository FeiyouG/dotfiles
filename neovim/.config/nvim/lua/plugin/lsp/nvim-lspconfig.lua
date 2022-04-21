local plugin = {
  "neovim/nvim-lspconfig"
}

plugin.config = function()
  -- MARK: Diagnostic Settings
  -- Diable virtual text
 vim.diagnostic.config({
    virtual_text = false,
    float = {
      scope = "line",     -- "buffer", "line", or "cursor"
      source = true,      -- true, "if_mnay", or false
    }

  })

  -- MARK: Change diagnostic symbol in signl column
  -- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

plugin.defer = function()
  -- vim.schedule( function ()
    -- MARK: Register and add to command_center
    local has_command_center, command_center = pcall(require, 'command_center')
    if not has_command_center then return end

    local noremap = {noremap = true}
    local silent_noremap = {noremap = true, silent = true}

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
  -- end )
end

return plugin


-- return {
--   -- Plugin name
--   "neovim/nvim-lspconfig",
--
--   config = function()
--
--     -- MARK: Diagnostic Settings
--     -- Diable virtual text
--     vim.diagnostic.config({
--       virtual_text = false,
--       float = {
--         scope = "line",     -- "buffer", "line", or "cursor"
--         source = true,      -- true, "if_mnay", or false
--       }
--
--     })
--
--     -- MARK: Change diagnostic symbol in signl column
--     -- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
--     local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
--     for type, icon in pairs(signs) do
--       local hl = "DiagnosticSign" .. type
--       vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
--     end
--
--   end
-- }




-- -- MARK: Diagnostic Settings
-- -- Diable virtual text
-- vim.diagnostic.config({
--   virtual_text = false,
--   float = {
--     scope = "line",     -- "buffer", "line", or "cursor"
--     source = true,      -- true, "if_mnay", or false
--   }
--
-- })

-- Show diagnostic on the current line in a floating window
-- vim.diagnostic.open_float({
--   scope = "line",     -- "buffer", "line", or "cursor"
--   source = true,      -- true, "if_mnay", or false
--   prefix = "",
-- })

-- ---- MARK: Change diagnostic symbol in signl column
-- -- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
-- for type, icon in pairs(signs) do
--   local hl = "DiagnosticSign" .. type
--   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end

