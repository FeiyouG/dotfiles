return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- `main` does not support lazy-loading
    build = ":TSUpdate",
    opts = function(_, opts)
      -- Other specs (lang/*.lua) extend this list
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "comment", -- Comment tags like TODO, FIXME, NOTE, ...
        "regex",
        "vim",
        "vimdoc",
        "query", -- For :InspectTree / :EditQuery
      })
      return opts
    end,
    config = function(_, opts)
      local ts = require("nvim-treesitter")
      ts.setup({})
      ts.install(opts.ensure_installed or {})

      -- MARK: Make bash treesitter also work for zsh
      vim.treesitter.language.register("bash", "zsh")

      local max_filesize = 100 * 1024 -- 100 KB
      local available = nil -- lazily computed set of parsers nvim-treesitter can install

      local function should_disable(lang, buf)
        if lang == "html" then
          return true
        end
        -- Disable treesitter on file larger than 100KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        return ok and stats and stats.size > max_filesize
      end

      local function attach(buf, lang)
        if not vim.api.nvim_buf_is_valid(buf) then
          return
        end
        if not pcall(vim.treesitter.start, buf, lang) then
          return
        end
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        -- Incremental selection using the Neovim 0.12 built-in `an` / `in`
        if vim.bo[buf].buftype == "" then
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, remap = true, desc = desc })
          end
          map("n", "<CR>", "van", "Start treesitter node selection")
          map("x", "<CR>", "an", "Expand selection to parent node")
          map("x", "<BS>", "in", "Shrink selection to child node")
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
        callback = function(args)
          local buf, ft = args.buf, args.match
          local lang = vim.treesitter.language.get_lang(ft) or ft
          if should_disable(lang, buf) then
            return
          end

          -- Parser already available (installed or bundled with Neovim)
          if vim.treesitter.language.add(lang) then
            attach(buf, lang)
            return
          end

          -- Auto install parsers that nvim-treesitter knows about
          if not available then
            available = {}
            for _, l in ipairs(ts.get_available()) do
              available[l] = true
            end
          end
          if available[lang] then
            ts.install({ lang }):await(function()
              vim.schedule(function()
                attach(buf, lang)
              end)
            end)
          end
        end,
      })

      vim.keymap.set("n", "<leader>sts", "<CMD>Telescope treesitter<CR>", { desc = "Show treesitter symbols" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      select = {
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        -- You can choose the select mode (default is charwise 'v')
        selection_modes = {
          ["@parameter.outer"] = "v", -- charwise
          ["@function.outer"] = "V",  -- linewise
          ["@class.outer"] = "V",     -- linewise
        },
        include_surrounding_whitespace = false,
      },
      move = {
        set_jumps = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter-textobjects").setup(opts)

      local select = require("nvim-treesitter-textobjects.select")
      local swap = require("nvim-treesitter-textobjects.swap")
      local move = require("nvim-treesitter-textobjects.move")

      -- Select
      for lhs, query in pairs({
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      }) do
        vim.keymap.set({ "x", "o" }, lhs, function()
          select.select_textobject(query, "textobjects")
        end, { desc = "Select " .. query })
      end

      -- Swap
      vim.keymap.set("n", "<leader>a", function()
        swap.swap_next("@parameter.inner")
      end, { desc = "Swap with next parameter" })
      vim.keymap.set("n", "<leader>A", function()
        swap.swap_previous("@parameter.inner")
      end, { desc = "Swap with previous parameter" })

      -- Move
      local moves = {
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
      }
      for method, maps in pairs(moves) do
        for lhs, query in pairs(maps) do
          vim.keymap.set({ "n", "x", "o" }, lhs, function()
            move[method](query, "textobjects")
          end, { desc = method:gsub("_", " ") .. " " .. query })
        end
      end
    end,
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
