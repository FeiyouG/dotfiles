return {
  'nvim-treesitter/nvim-treesitter',

  run = ':TSUpdate',

  config = function()

    require 'nvim-treesitter.configs'.setup {
      -- One of "all" or a list of languages
      -- Automatically install and upate treesitter
      ensure_installed = {
        "bash",
        "c",
        "comment", -- Comment tags like TODO, FIXME, NOTE:  ...
        "cpp",
        "css",
        "help", -- vimdoc
        "html",
        "http",
        "java",
        "javascript",
        "typescript",
        "jsdoc",
        "json",
        "json5",
        "latex",
        "lua",
        "markdown",
        "python",
        "regex",
        "vim",
        "go",
        "gomod",
        "ruby",
        "query" -- For treesitter query editor highlighting
      },

      -- Install languages synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      -- List of parsers to ignore installing
      -- ignore_install = { "javascript" },

      highlight = {
        enable = true,
        disable = { "html" },
        -- additional_vim_regex_highlighting = { "markdown" },
      },

      indent = {
        enable = true,
      },

      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },

      autopairs = {
        enable = true
      },

      autotag = {
        enable = true,
      },

      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
        },
      }

    }

    -- MARK: Make bash treesitter also work for zsh
    local ft_to_parser = require "nvim-treesitter.parsers".filetype_to_parsername
    ft_to_parser.zsh = "bash"

    -- MARK: Setup folding
    vim.cmd "set foldmethod=expr"
    vim.cmd "set foldexpr=nvim_treesitter#foldexpr()"
  end,

  commands = function()
    return {
      {
        description = "Show treesitter symbols",
        cmd = "<CMD>Telescope treesitter<CR>",
        keybindings = { "n", "<leader>sts", Utils.keymap.noremap }
      }
    }
  end
}
