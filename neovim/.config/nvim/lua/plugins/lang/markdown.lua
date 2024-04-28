return {
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")
      return vim.list_extend(opts, {
        null_ls.builtins.diagnostics.alex, -- Catch insensitive, inconsiderate writing.
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.formatting.markdownlint,
      })
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    ft = { "markdown" },
    cmd = { "MarkdownPreviewToggle" },
    keys = {
      {
        "<localleader>p",
        "<Plug>MarkdownPreviewToggle",
        desc = "Toggle markdown preview",
        remap = true
      }
    },
    config = function()
      vim.cmd("let g:mkdp_open_to_the_world = 1")
      vim.cmd("let g:mkdp_echo_preview_url = 1")
      vim.cmd("let g:mkdp_page_title = '${name}'")
      vim.g.mkdp_preview_options = {
          mkit = {},
          katex = {},
          uml = {},
          maid = {},
          disable_sync_scroll = 1,
          sync_scroll_type = 'middle',
          hide_yaml_meta = 0,
          sequence_diagrams = {},
          flowchart_diagrams = {},
          content_editable = false,
          disable_filename = 0,
          toc = {}
}
    end,
  },
  {
    "mzlogin/vim-markdown-toc",

    ft = { "markdown" },

    cmd = { "GenTocGFM", "GenTocRedcarpet", "GenTocGitLab", "GenTocMarked", "RemoveToc" },

    commander = {
      {
        cmd = "<CMD>GenTocGFM<CR>",
        desc = "Generate table of contents (GFM)",
      }
    },

    config = function()
      vim.cmd("let g:vmt_fence_text='TOC'")
      vim.cmd("let g:vmt_fence_closing_text='/TOC'")
      vim.cmd("let g:vmt_list_item_char = '-'")
      vim.cmd("let g:vmt_include_headings_before = 0")
    end,
  },
  {
    "dhruvasagar/vim-table-mode",

    ft = { "markdown" },

    keys = { "<Leader>tm", },

    cmd = { "TableModeToggle" },

    commander = {
      {
        cmd = "<CMD>TableModeToggle<CR>",
        desc = "Toggle Markdown table mode",
        keys = { "n", "<leader>tm" },
        set = false
      }
    },

    config = function()
      vim.cmd("let g:table_mode_corner='|'")
    end,

  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Enable markdown parser extensions by exporting env vars
      vim.env.EXTENSION_TAGS = 1
      vim.env.EXTENSION_WIKI_LINK = 1

      -- Force treesitter-generate to run before compiling
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.markdown.install_info.requires_generate_from_grammar = true
      parser_config.markdown_inline.install_info.requires_generate_from_grammar = true

      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "markdown", "markdown_inline" })
      return opts
    end,
  }
}
