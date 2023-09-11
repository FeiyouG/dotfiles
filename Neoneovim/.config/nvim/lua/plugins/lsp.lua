return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function(_, sources)
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = sources,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>sd",  "<CMD>Telescope lsp_definitions<CR>",               mode = "n", desc = "Go to definitions" },
      { "<leader>st",  "<CMD>Telescope lsp_type_definitions<CR>",          mode = "n", desc = "Go to type definitions" },
      { "<leader>sr",  "<CMD>Telescope lsp_references<CR>",                mode = "n", desc = "Show all references" },
      { "<leader>ssw", "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>", mode = "n", desc = "show workspace symbols" },
      { "<leader>si",  "<CMD>Telescope lsp_implementations<CR>",           mode = "n", desc = "Go to implementations" },
      { "<leader>ssd", "<CMD>Telescope lsp_document_symbols<CR>",          mode = "n", desc = "Show document symbols" },
      { "<leader>ss",  "<CMD>Telescope lsp_document_symbols<CR>",          mode = "n", desc = "Show document symbols" },
      {
        "<leader>se",
        "<CMD>Telescope diagnostics<CR>",
        mode = "n",
        desc = "Show workspace errors (diagnostic)"
      },
      {
        "<leader>sef",
        "<CMD>Telescope diagnostics<CR>",
        mode = "n",
        desc = "Show workspace errors (diagnostic)"
      },
    },
    config = function(_, opts)
      -- Config `lspInfo` floating window
      local windows = require("lspconfig.ui.windows")
      windows.default_options.border = settings.icons.editor.border.rounded_with_hl

      -- Setup Servers
      local lspconfig = require("lspconfig")

      -- initialize servers
      for server, server_config in pairs(opts) do
        server_config.capabilities =
            vim.tbl_extend("force", settings.fn.lsp.get_capabilities(), server_config.capabilities or {})

        -- add common logics to on_attach functions
        local server_on_attach = server_config.on_attach

        server_config.on_attach = function(client, bufnr)
          settings.fn.lsp.on_attach(client, bufnr)

          -- execute server-specific on_attach if there is one
          if settings.fn.is_callable(server_on_attach) then
            server_on_attach(client, bufnr)
          end
        end

        -- setup
        lspconfig[server].setup(server_config)
      end

      -- FIX: lua_ls has to be setup explicitly or it won't attach
      lspconfig.lua_ls.setup(opts.lua_ls)
    end,
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      local navic = require("nvim-navic")
      local icons = require("settings.icons")
      navic.setup({
        icons = icons.lsp,
        lsp = {
          auto_attach = true,
          preference = nil,
        },
        highlight = false,
        separator = " ❯ ",
        depth_limit = 3,
        depth_limit_indicator = "…",
        safe_output = true,
      })
    end,
  },
}
