return {
  "neovim/nvim-lspconfig",

  event = { "BufReadPre" },

  dependencies = {
    "williamboman/mason.nvim",
  },

  config = function()
    local fn = require("settings.fn")
    local style = require("settings.style")

    -- SECTION: Diagnostic Settings: diable virtual text
    vim.diagnostic.config({
      virtual_text = false,
      float = {
        scope = "line", -- "buffer", "line", or "cursor"
        source = true, -- true, "if_mnay", or false
      },
    })

    -- SECTION: Config `lspInfo` floating window
    local windows = require("lspconfig.ui.windows")
    windows.default_options.border = style.border.rounded

    -- SECTION: Add boarder to hover --
    local lsp_util_open_floating_preview = vim.lsp.util.open_floating_preview
    vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or style.border.rounded
      return lsp_util_open_floating_preview(contents, syntax, opts, ...)
    end

    -- SECTION: Change diagnostic symbol in signl column
    for type, icon in pairs({
      Error = style.icons.diagnostic.error,
      Warn = style.icons.diagnostic.warning,
      Hint = style.icons.diagnostic.hint,
      Info = style.icons.diagnostic.info,
    }) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- SECTION: Setup Servers
    local lspconfig = require("lspconfig")

    -- vim.schedule(function()
    -- initialize servers
    local servers = require("plugins.lsp.servers").nvim_lspconfig
    for server, server_config in pairs(servers) do
      -- Setup common server configs
      server_config.capabilities =
      vim.tbl_extend("force", fn.lsp.get_capabilities(), server_config.capabilities or {})

      -- Add common logics to on_attach functions
      local server_on_attach = server_config.on_attach
      server_config.on_attach = function(client, bufnr)
        -- Inject common on_attach logic
        fn.lsp.on_attach(client, bufnr)

        -- Execute server-specific on_attach if there is one
        if fn.is_callable(server_on_attach) then
          server_on_attach(client, bufnr)
        end
      end

      -- Setup
      lspconfig[server].setup(server_config)
    end
    -- end)

    fn.keymap.set({
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
        keybindings = { "n", "<leader>sen" },
      },
      {
        description = "Go to the previous diagnostic item",
        cmd = vim.diagnostic.goto_prev,
        keybindings = { "n", "<leader>sep" },
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
  end,
}
