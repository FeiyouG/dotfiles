
return {
  "neovim/nvim-lspconfig",

  config = function()
    -- MARK: Diagnostic Settings: diable virtual text
    vim.diagnostic.config({
      virtual_text = false,
      float = {
        scope = "line", -- "buffer", "line", or "cursor"
        source = true, -- true, "if_mnay", or false
      }

    })

    -- MARK: Add boarder to hover --
    local border = {
      { "╭", "FloatBorder" },
      { "─", "FloatBorder" },
      { "╮", "FloatBorder" },
      { "│", "FloatBorder" },
      { "╯", "FloatBorder" },
      { "─", "FloatBorder" },
      { "╰", "FloatBorder" },
      { "│", "FloatBorder" },
    }

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or border
      return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end

    -- MARK: Change diagnostic symbol in signl column
    -- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end


    -- MARK: Setup Servers
    local utils = require("utils")
    local lspconfig = require("lspconfig")

    -- initialize servers
    local servers = require("plugin/lsp/servers")
    for server, server_config in pairs(servers) do
      -- Setup common server configs
      server_config.capabilities = utils.lsp.capabilities
      lspconfig[server].setup(server_config)
    end

  end,


  defer = function()
    -- MARK: Register and add to command_center
    local has_command_center, command_center = pcall(require, 'command_center')
    if not has_command_center then return end

    local noremap = { noremap = true }
    local silent_noremap = { noremap = true, silent = true }

    command_center.add({
      {
        description = "Show documentations (hover)",
        cmd = vim.lsp.buf.hover,
        keybindings = { "n", "K", silent_noremap },
      }, {
        description = "Show errors of the current line",
        cmd = vim.diagnostic.open_float,
        keybindings = { "n", "E", silent_noremap },
      }, {
        description = "Show function signature",
        cmd = vim.lsp.buf.signature_help,
        keybindings = { "n", "<leader>sk", silent_noremap },
      }, {
        description = "Go to declarations",
        cmd = vim.lsp.buf.declaration,
        keybindings = { "n", "<leader>sD", silent_noremap },
      }, {
        description = "Rename symbol",
        cmd = vim.lsp.buf.rename,
        keybindings = { "n", "<leader>sn", silent_noremap },
      }, {
        description = "Format code (lint)",
        cmd = vim.lsp.buf.formatting,
        keybindings = { "n", "<leader>sf", silent_noremap },
      }
    })

    -- Commands takes advantages of Telescope
    command_center.add({
      {
        description = "Show code actions",
        cmd = vim.lsp.buf.code_action,
        keybindings = { "n", "<leader>sa", noremap },
      }, {
        description = "Go to definitions",
        cmd = "<CMD>Telescope lsp_definitions<CR>",
        keybindings = { "n", "<leader>sd", noremap },
      }, {
        description = "Go to type definitions",
        cmd = "<CMD>Telescope lsp_type_definitions<CR>",
        keybindings = { "n", "<leader>st", noremap },
      }, {
        description = "Show all references",
        cmd = "<CMD>Telescope lsp_references<CR>",
        keybindings = { "n", "<leader>sr", noremap },
      }, {
        description = "Show workspace errors (diagnostic)",
        cmd = "<CMD>Telescope diagnostics<CR>",
        keybindings = { "n", "<leader>se", noremap },
      }, {
        description = "Go to implementations",
        cmd = "<CMD>Telescope lsp_implementations<CR>",
        keybindings = { "n", "<leader>si", noremap },
      }, {
        description = "Show document symbols",
        cmd = "<CMD>Telescope lsp_document_symbols<CR>",
        keybindings = {
          { "n", "<leader>ss", noremap },
          { "n", "<leader>ssd", noremap },
        },
      }, {
        description = "show workspace symbols",
        cmd = "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>",
        keybindings = { "n", "<leader>ssw", noremap },
      }
    })
  end
}
