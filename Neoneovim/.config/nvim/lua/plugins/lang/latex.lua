return {
  {
    "nvimtools/none-ls.nvim",
    opts = {
      require("null-ls").builtins.formatting.latexindent,
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local util = require("lspconfig.util")
      local handlers = require("vim.lsp.handlers")

      ---Get words from file as a list
      local function get_words(filename)
        local file = io.open(filename)
        if not file then
          return {}
        end

        local words = {}
        io.input(file)
        for line in io.lines() do
          local word = vim.fn.trim(line)
          if #word > 1 and string.sub(word, 1, 1) ~= "#" then
            words[#words + 1] = vim.fn.trim(line)
          end
        end
        io.input():close()

        return words
      end

      ---Add a word to ltex's dictionary
      local function ltex_add_word(word)
        local ltex = util.get_active_client_by_name(0, "ltex")
        if ltex then
          local words = ltex.config.settings.ltex.dictionary["en-US"]
          words[#words + 1] = word

          ltex.request("workspace/didChangeConfiguration", ltex.config.settings, function(err, result) end)
        end
      end

      ---Remove a word from ltex's dictionary
      local function ltex_remove_word(word)
        local ltex = util.get_active_client_by_name(0, "ltex")
        if ltex then
          local words = ltex.config.settings.ltex.dictionary["en-US"]
          for i, w in ipairs(words) do
            if w == word then
              table.remove(words, i)
              break
            end
          end

          ltex.request("workspace/didChangeConfiguration", ltex.config.settings, function(err, result) end)
        end
      end

      -- This function is meant to replace the the ltex-ls handlers
      -- for executeCommand in order for the custom dictionary to work
      local function on_workspace_executecommand(err, content, ctx)
        if ctx.params.command == "_ltex.addToDictionary" then
          local data = ctx.params.arguments[1].words
          for _, vv in pairs(data) do
            for _, v in pairs(vv) do
              vim.cmd("spellgood " .. v)
              ltex_add_word(v)
            end
          end
        elseif ctx.params.command == "_ltex.disableRules" then
          local data = ctx.params.arguments[1].ruleIds
          -- print(vim.inspect(data))
          -- populate_config("disabledRules", data)
        elseif ctx.params.command == "_ltex.hideFalsePositives" then
          -- local data = ctx.params.arguments[1].falsePositives
          -- populate_config("hiddenFalsePositives", data)
        else
          handlers[ctx.method](err, content, ctx)
        end
      end

      opts.ltex = {
        settings = {
          ltex = {
            dictionary = {
              ["en-US"] = get_words(settings.path.spell.spellfile),
            },
            disabledRules = {
              ["en-US"] = {
                "ENGLISH_WORD_REPEAT_BEGINNING_RULE",
                "UPPERCASE_SENTENCE_START",
                "WHITESPACE_RULE",
                "COMMA_PARENTHESIS_WHITESPACE",
                "UNIT_SPACE",
              },
            },
          },
        },
        filetypes = {
          "bib",
          "gitcommit",
          "markdown",
          "org",
          "plaintex",
          "rst",
          "rnoweb",
          "tex",
          "pandoc",
          "norg",
          "org",
        },
        handlers = {
          ["workspace/executeCommand"] = on_workspace_executecommand,
        },
        on_attach = function()
          -- ltex-ls will take over spell and grammar checks
          vim.opt_local.spell = false

          -- Mimic spell keymaps
          vim.keymap.set("n", "zg", function()
            local word = vim.fn.expand("<cword>")
            vim.cmd("spellgood " .. word)
            ltex_add_word(word)
          end, { buffer = true })

          vim.keymap.set("n", "zG", function()
            ltex_add_word(vim.fn.expand("<cword>"))
          end, { buffer = true })

          vim.keymap.set("n", "zug", function()
            local word = vim.fn.expand("<cword>")
            vim.cmd("spellundo " .. word)
            ltex_remove_word(word)
          end, { buffer = true })

          vim.keymap.set("n", "zuG", function()
            ltex_remove_word(vim.fn.expand("<cword>"))
          end, { buffer = true })
        end,
      }
      return opts
    end,
  },
  {
    "lervag/vimtex",
    ft = { "latex", "tex" },
    commander = {
      {
        desc = "Compile and repreview latex doc",
        keys = { "n", "<localleader>p" },
        cmd = " <CMD>VimtexCompile<CR>",
      }
    },
    config = function()
      vim.g.vimtex_compiler_latexmk = {
        build_dir = "out",
      }
    end,
  }
}
