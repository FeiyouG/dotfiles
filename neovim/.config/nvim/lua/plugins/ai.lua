return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
      { "FeiyouG/commander.nvim", lazy = true },
    },
    commander = {
      {
        desc = "Ask opencode",
        cmd = function()
          require("opencode").ask("@this: ", { submit = true })
        end,
        keys = { { "n", "x" }, "<leader>la" },
      },
      {
        desc = "Execute opencode action",
        cmd = function()
          require("opencode").select()
        end,
        keys = { { "n", "x" }, "<leader>lx" },
      },
      {
        desc = "Toggle opencode",
        cmd = function()
          require("opencode").toggle()
        end,
        keys = { { "n", "t" }, "<leader>lt" },
      },
      {
        desc = "Add range to opencode",
        cmd = function()
          return require("opencode").operator("@this ")
        end,
        keys = { {"n", "x"}, "<leader>lr" }
      },
      {
        desc = "Add line to opencode",
        cmd = function()
          return require("opencode").operator("@this ") .. "_"
        end,
        keys = { {"n"}, "<leader>lr" }
      }
    },
    config = function()
      vim.g.opencode_opts = {
        provider = {
          enabled = "tmux",
        }
      }

      vim.o.autoread = true

      -- Handle `opencode` events
      vim.api.nvim_create_autocmd("User", {
        pattern = "OpencodeEvent:*", -- Optionally filter event types
        callback = function(args)
          ---@type opencode.cli.client.Event
          local event = args.data.event
          ---@type number
          local port = args.datport

          local notification_opts = {
            title = "Opencode",
            render = "compact"
          }

          -- See the available event types and their properties
          -- vim.notify(vim.inspect(event))
          -- Do something useful
          if event.type == "session.idle" then
            vim.notify("Finshed responding", "info", notification_opts)
          end

          if event.type == "server.connected" then
            vim.notify( "Server connected", "info", notification_opts)
          end
        end,
      })
    end,
  },
  {
    'milanglacier/minuet-ai.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('minuet').setup {
        provider = 'openai_compatible',
        request_timeout = 2.5,
        throttle = 1500, -- Increase to reduce costs and avoid rate limits
        debounce = 600, -- Increase to reduce costs and avoid rate limits
        provider_options = {
          openai_compatible = {
            api_key = "OPENROUTER_API_KEY",
            end_point = 'https://openrouter.ai/api/v1/chat/completions',
            model = 'moonshotai/kimi-k2',
            name = 'Openrouter',
            optional = {
              max_tokens = 56,
              top_p = 0.9,
              provider = {
                -- Prioritize throughput for faster completion
                sort = 'throughput',
              },
            },
          },
        },
        -- virtualtext = {
        --   keymap = {
        --     -- accept whole completion
        --     accept = '<A-A>',
        --     -- accept one line
        --     accept_line = '<A-a>',
        --     -- accept n lines (prompts for number)
        --     -- e.g. "A-z 2 CR" will accept 2 lines
        --     accept_n_lines = '<A-z>',
        --     -- Cycle to prev completion item, or manually invoke completion
        --     prev = '<A-[>',
        --     -- Cycle to next completion item, or manually invoke completion
        --     next = '<A-]>',
        --     dismiss = '<A-e>',
        --   },
        -- },
      }
    end,
  },
}

-- https://github.com/olimorris/codecompanion.nvim
-- https://www.reddit.com/r/neovim/comments/1jw7pmm/use_lsp_as_context_provider_in_codecompanion/
-- https://www.reddit.com/r/neovim/comments/1jizh1s/contextfilesnvim_add_support_for_cursor_rules/
-- https://github.com/milanglacier/minuet-ai.nvim
-- https://www.reddit.com/r/neovim/comments/1jfci7i/minuetainvim_v04_update_now_with_inprocess_lsp/
-- https://www.reddit.com/r/neovim/comments/1jevayz/mcphubnvim_v350_custom_instructions_per_server/
