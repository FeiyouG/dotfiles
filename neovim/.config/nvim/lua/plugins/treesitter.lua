return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "comment", -- Comment tags like TODO, FIXME, NOTE, ...
        "regex",
        "vim",
      })
      opts.auto_install = true
      opts.highlight = {
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
      }
      opts.incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>", -- set to `false` to disable one of the mappings
          node_incremental = "<CR>",
          scope_incremental = "<S-CR>",
          node_decremental = "<BS>",
        },
      }
      opts.indent = {
        enable = true,
      }
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- MARK: Make bash treesitter also work for zsh
      vim.treesitter.language.register("bash", "zsh")
      vim.keymap.set("n", "<leader>sts", "<CMD>Telescope treesitter<CR>", { desc = "Show treesitter symbols" })
    end,
  },
  {
    "nvim-treesitter/playground",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "query" })
        opts.playground = {
          keybindings = {
            show_help = "g?",
          },
        }
        return opts
      end,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        opts.textobjects = {
          select = {
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
              ["@function.outer"] = "V",  -- linewise
              ["@class.outer"] = "V",     -- linewise
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
              ["]c"] = "@class.outer",
              ["]]"] = "@loop.outer",
              ["]i"] = "@conditional.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
              ["]O"] = "@loop.outer",
              ["]I"] = "@conditional.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
              ["[o"] = "@loop.outer",
              ["[i"] = "@conditional.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
              ["[O"] = "@loop.outer",
              ["[I"] = "@conditional.outer",
            },
          },
          lsp_interop = {
            border = settings.icons.editor.border.rounded_with_hl,
            peek_definition_code = {
              ["<leader>df"] = "@function.outer",
              ["<leader>dF"] = "@class.outer",
            },
          },
        }
      end,
    },
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      vim.g.skip_ts_context_commentstring_module = true
      require('ts_context_commentstring').setup {}
    end
  },
  {
    -- Editing injected language in a flowing window
    'AckslD/nvim-FeMaco.lua',
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    commander = {
      {
        cmd = "<CMD>FeMaco<CR>",
        desc = "Edit code block in popup",
      },
    },
    opts = {
      -- what to do after opening the float
      post_open_float = function(_)
        vim.keymap.set({ "n", "v" }, "q", vim.cmd.close, { desc = "Close current buffer", buffer = true })
      end,
    },
    config = function(_, opts)
      require("femaco").setup(opts)
      vim.list_extend(settings.ft.quit_on_q.buftype, { "femaco" })
    end
  }
}
