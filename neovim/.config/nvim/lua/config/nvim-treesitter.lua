require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  -- Automatically install and upate treesitter
  ensure_installed = "maintained",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  -- ignore_install = { "javascript" },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "markdown" },
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

  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["fa"] = "@function.outer",
        ["fi"] = "@function.inner",
        ["ca"] = "@class.outer",
        ["ci"] = "@class.inner",
      },
    },

    -- swap = {
    --   enable = true,
    --   swap_next = {
    --     ["<leader>sa"] = "@parameter.inner",
    --   },
    --   swap_previous = {
    --     ["<leader>ssa"] = "@parameter.inner",
    --   },
    -- },

--    move = {
--       enable = true,
--       set_jumps = true, -- whether to set jumps in the jumplist
--       goto_next_start = {
--         ["<leader>fj"] = "@function.outer",
--         ["<leader>cj"] = "@class.outer",
--         ["<leader>ij"] = "@confitional.outer",
--         ["<leader>lj"] = "@loop.outer",
--         ["<leader>pj"] = "@parameter.outer",
--       },

--       goto_next_end = {
--         ["<leader><leader>fj"] = "@function.outer",
--         ["<leader><leader>cj"] = "@class.outer",
--         ["<leader><leader>ij"] = "@confitional.outer",
--         ["<leader><leader>lj"] = "@loop.outer",
--         ["<leader><leader>pj"] = "@parameter.outer",
--         },
--       goto_previous_start = {
--         ["<leader>fk"] = "@function.outer",
--         ["<leader>ck"] = "@class.outer",
--         ["<leader>ik"] = "@confitional.outer",
--         ["<leader>lk"] = "@loop.outer",
--         ["<leader>pk"] = "@parameter.outer",
--         },
--       goto_previous_end = {
--         ["<leader><leader>fk"] = "@function.outer",
--         ["<leader><leader>ck"] = "@class.outer",
--         ["<leader><leader>ik"] = "@confitional.outer",
--         ["<leader><leader>lk"] = "@loop.outer",
--         ["<leader><leader>pk"] = "@parameter.outer",
--       },
--     },

    lsp_interop = {
      enable = true,
      border = 'none',
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
  },
}
