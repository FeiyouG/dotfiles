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

    -- MARK: Config `lspInfo` floating window
    local windows = require('lspconfig.ui.windows')
    windows.default_options.border = Utils.icons.border.rounded

    -- MARK: Add boarder to hover --
    local lsp_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or Utils.icons.border.rounded
      return lsp_util_open_floating_preview(contents, syntax, opts, ...)
    end

    -- MARK: Change diagnostic symbol in signl column
    local signs = {
      Error = Utils.icons.diagnostic.error,
      Warn = Utils.icons.diagnostic.warning,
      Hint = Utils.icons.diagnostic.hint,
      Info = Utils.icons.diagnostic.info
    }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end


    -- MARK: Setup Servers
    local lspconfig = require("lspconfig")

    -- initialize servers
    local servers = require("plugin/lsp/servers").nvim_lspconfig
    for server, server_config in pairs(servers) do

      -- Setup common server configs
      server_config.capabilities = vim.tbl_extend("force",
        Utils.lsp.capabilities, server_config.capabilities or {})

      -- Add common logics to on_attach functions
      local old_on_attach = server_config.on_attach
      server_config.on_attach = function(client, bufnr)
        -- Inject common on_attach logic
        Utils.lsp.on_attach(client, bufnr)

        -- Execute old_on_attach iff it is defined
        if Utils.is_callable(old_on_attach) then
          old_on_attach(client, bufnr)
        end
      end

      -- Setup
      lspconfig[server].setup(server_config)
    end

  end,


  commands = function()
    local keymap = Utils.keymap

    return {
      {
        description = "Show documentations (hover)",
        cmd = vim.lsp.buf.hover,
        keybindings = { "n", "K", keymap.silent_noremap },
      }, {
        description = "Show errors of the current line (floating window)",
        cmd = vim.diagnostic.open_float,
        keybindings = { "n", "E", keymap.silent_noremap },
      }, {
        description = "Go to the next diagnostic item",
        cmd = vim.diagnostic.goto_next,
        keybindings = { "n", "<leader>sen", keymap.silent_noremap },
      }, {
        description = "Go to the previous diagnostic item",
        cmd = vim.diagnostic.goto_prev,
        keybindings = { "n", "<leader>sep", keymap.silent_noremap },
      }, {
        description = "Show function signature",
        cmd = vim.lsp.buf.signature_help,
        keybindings = { "n", "<leader>sk", keymap.silent_noremap },
      }, {
        description = "Go to declarations",
        cmd = vim.lsp.buf.declaration,
        keybindings = { "n", "<leader>sD", keymap.silent_noremap },
      }, {
        description = "Rename symbol",
        cmd = vim.lsp.buf.rename,
        keybindings = { "n", "<leader>sn", keymap.silent_noremap },
      }, {
        description = "Format code (lint)",
        cmd = function()
          vim.lsp.buf.format({ async = true })
        end,
        keybindings = { "n", "<leader>sf", keymap.silent_noremap },
      },

      -- Commands that take advantages of Telescope
      {
        description = "Show code actions",
        cmd = vim.lsp.buf.code_action,
        keybindings = {
          { "n", "<leader>sa", keymap.noremap },
          { "v", "<leader>sa", keymap.noremap },
        },
      }, {
        description = "Go to definitions",
        cmd = "<CMD>Telescope lsp_definitions<CR>",
        keybindings = { "n", "<leader>sd", keymap.noremap },
      }, {
        description = "Go to type definitions",
        cmd = "<CMD>Telescope lsp_type_definitions<CR>",
        keybindings = { "n", "<leader>st", keymap.noremap },
      }, {
        description = "Show all references",
        cmd = "<CMD>Telescope lsp_references<CR>",
        keybindings = { "n", "<leader>sr", keymap.noremap },
      }, {
        description = "Show workspace errors (diagnostic)",
        cmd = "<CMD>Telescope diagnostics<CR>",
        keybindings = {
          { "n", "<leader>se", keymap.noremap },
          { "n", "<leader>sef", keymap.noremap },
        },
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
      }, {
        description = "show workspace symbols",
        cmd = "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>",
        keybindings = { "n", "<leader>ssw", keymap.noremap },
      }
    }
  end
}
