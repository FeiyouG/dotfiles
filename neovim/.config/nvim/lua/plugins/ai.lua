return {
  -- {
  -- 	"yetone/avante.nvim",
  -- 	-- event = "VeryLazy",
  -- 	lazy = false,
  -- 	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- 	build = "make",
  -- 	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  -- 	dependencies = {
  -- 		"stevearc/dressing.nvim",
  -- 		"nvim-lua/plenary.nvim",
  -- 		"MunifTanjim/nui.nvim",
  -- 		--- The below dependencies are optional,
  -- 		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
  -- 		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
  -- 		"nvim-tree/nvim-web-devicons",
  -- 		{
  -- 			-- support for image pasting
  -- 			"HakonHarnes/img-clip.nvim",
  -- 			event = "VeryLazy",
  -- 			opts = {
  -- 				-- recommended settings
  -- 				default = {
  -- 					embed_image_as_base64 = false,
  -- 					prompt_for_file_name = false,
  -- 					drag_and_drop = {
  -- 						insert_mode = true,
  -- 					},
  -- 					-- required for Windows users
  -- 					use_absolute_path = true,
  -- 				},
  -- 			},
  -- 		},
  -- 	},
  -- 	opts = {
  -- 		file_selector = {
  -- 			provider = "telescope",
  -- 		},
  -- 		-- add any opts here
  -- 	},
  -- },
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
      -- vim.api.nvim_create_autocmd("User", {
      --   pattern = "OpencodeEvent:*", -- Optionally filter event types
      --   callback = function(args)
      --     ---@type opencode.cli.client.Event
      --     local event = args.data.event
      --     ---@type number
      --     local port = args.data.port
      --
      --     -- See the available event types and their properties
      --     vim.notify(vim.inspect(event))
      --     -- Do something useful
      --     if event.type == "session.idle" then
      --       vim.notify("`opencode` finished responding")
      --     end
      --   end,
      -- })
    end,
  }
}

-- https://github.com/olimorris/codecompanion.nvim
-- https://www.reddit.com/r/neovim/comments/1jw7pmm/use_lsp_as_context_provider_in_codecompanion/
-- https://www.reddit.com/r/neovim/comments/1jizh1s/contextfilesnvim_add_support_for_cursor_rules/
-- https://github.com/milanglacier/minuet-ai.nvim
-- https://www.reddit.com/r/neovim/comments/1jfci7i/minuetainvim_v04_update_now_with_inprocess_lsp/
-- https://www.reddit.com/r/neovim/comments/1jevayz/mcphubnvim_v350_custom_instructions_per_server/
