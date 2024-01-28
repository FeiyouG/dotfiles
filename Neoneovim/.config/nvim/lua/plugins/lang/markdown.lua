return {
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
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
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "markdown", "markdown_inline" })
      return opts
    end,
  }
}
