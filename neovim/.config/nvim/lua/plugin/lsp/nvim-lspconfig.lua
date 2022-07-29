return {
  "neovim/nvim-lspconfig",

  requires = {
    'hrsh7th/nvim-cmp',
  },

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
    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or Utils.constants.border.rounded
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
    local lspconfig = require("lspconfig")

    -- initialize servers
    local servers = require("plugin/lsp/servers")
    for server, server_config in pairs(servers) do
      -- Setup common server configs
      server_config.capabilities = Utils.fn.lsp.capabilities()
      lspconfig[server].setup(server_config)
    end

  end,


  commands = function()
    local keymap = Utils.constants.keymap

    return {
      {
        -- If hesitate, show lsp-related commands
        description = "jdtls related commands",
        cmd = "<CMD>Telescope command_center category=lsp<CR>",
        keybindings = {
          { "n", "<leader>s", keymap.silent_noremap },
          { "v", "<leader>s", keymap.silent_noremap },
        },
        mode = keymap.cc_mode.REGISTRER_ONLY,
      },
      {
        description = "Show documentations (hover)",
        cmd = vim.lsp.buf.hover,
        keybindings = { "n", "K", keymap.silent_noremap },
        category = "lsp",
      }, {
        description = "Show errors of the current line (floating window)",
        cmd = vim.diagnostic.open_float,
        keybindings = { "n", "E", keymap.silent_noremap },
        category = "lsp",
      }, {
        description = "Go to the next diagnostic item",
        cmd = vim.diagnostic.goto_next,
        keybindings = { "n", "<leader>sen", keymap.silent_noremap },
        category = "lsp",
      }, {
        description = "Go to the previous diagnostic item",
        cmd = vim.diagnostic.goto_prev,
        keybindings = { "n", "<leader>sep", keymap.silent_noremap },
        category = "lsp",
      }, {
        description = "Show function signature",
        cmd = vim.lsp.buf.signature_help,
        keybindings = { "n", "<leader>sk", keymap.silent_noremap },
        category = "lsp",
      }, {
        description = "Go to declarations",
        cmd = vim.lsp.buf.declaration,
        keybindings = { "n", "<leader>sD", keymap.silent_noremap },
        category = "lsp",
      }, {
        description = "Rename symbol",
        cmd = vim.lsp.buf.rename,
        keybindings = { "n", "<leader>sn", keymap.silent_noremap },
        category = "lsp",
      }, {
        description = "Format code (lint)",
        cmd = vim.lsp.buf.formatting,
        keybindings = { "n", "<leader>sf", keymap.silent_noremap },
        category = "lsp",
      },

      -- Commands that take advantages of Telescope
      {
        description = "Show code actions",
        cmd = vim.lsp.buf.code_action,
        keybindings = {
          {"n", "<leader>sa", keymap.noremap },
          {"v", "<leader>sa", keymap.noremap },
        },
        category = "lsp",
      }, {
        description = "Go to definitions",
        cmd = "<CMD>Telescope lsp_definitions<CR>",
        keybindings = { "n", "<leader>sd", keymap.noremap },
        category = "lsp",
      }, {
        description = "Go to type definitions",
        cmd = "<CMD>Telescope lsp_type_definitions<CR>",
        keybindings = { "n", "<leader>st", keymap.noremap },
        category = "lsp",
      }, {
        description = "Show all references",
        cmd = "<CMD>Telescope lsp_references<CR>",
        keybindings = { "n", "<leader>sr", keymap.noremap },
        category = "lsp",
      }, {
        description = "Show workspace errors (diagnostic)",
        cmd = "<CMD>Telescope diagnostics<CR>",
        keybindings = {
          { "n", "<leader>se", keymap.noremap },
          { "n", "<leader>sef", keymap.noremap },
        },
        category = "lsp",
      }, {
        description = "Go to implementations",
        cmd = "<CMD>Telescope lsp_implementations<CR>",
        keybindings = { "n", "<leader>si", keymap.noremap },
        category = "lsp",
      }, {
        description = "Show document symbols",
        cmd = "<CMD>Telescope lsp_document_symbols<CR>",
        keybindings = {
          { "n", "<leader>ss", keymap.noremap },
          { "n", "<leader>ssd", keymap.noremap },
        },
        category = "lsp",
      }, {
        description = "show workspace symbols",
        cmd = "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>",
        keybindings = { "n", "<leader>ssw", keymap.noremap },
        category = "lsp",
      }
    }
  end
}
