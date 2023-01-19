local fn = require("settings.fn")

return {
  "nvim-treesitter/nvim-treesitter",

  build = ":TSUpdate",

  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/playground",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },

  config = function()
    require("nvim-treesitter.configs").setup({
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
        "query", -- For treesitter query editor highlighting
      },

      -- Install languages synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      -- List of parsers to ignore installing
      -- ignore_install = { "javascript" },

      highlight = {
        enable = true,
        disable = function(lang, buf)
          if lang == "html" then
            return true
          end

          -- Disable treesitter on file larger than 100KB
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        -- additional_vim_regex_highlighting = { "markdown" },
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>", -- set to `false` to disable one of the mappings
          node_incremental = "<CR>",
          scope_incremental = "<S-CR>",
          node_decremental = "<BS>",
        },
      },

      indent = {
        enable = true,
      },

      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },

      autopairs = {
        enable = true,
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
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },

      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },

          -- You can choose the select mode (default is charwise 'v')
          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "V", -- linewise
          },

          include_surrounding_whitespace = false,
        },

        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },

        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
      },
    })

    -- MARK: Make bash treesitter also work for zsh
    local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
    ft_to_parser.zsh = "bash"

    -- MARK: Setup folding
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt.foldlevel = 99

    fn.keymap.set({
      {
        description = "Show treesitter symbols",
        cmd = "<CMD>Telescope treesitter<CR>",
        keybindings = { "n", "<leader>sts" },
      },
    })
  end,
}
