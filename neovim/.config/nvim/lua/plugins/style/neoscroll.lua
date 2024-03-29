return {
  "karb94/neoscroll.nvim",

  event = { "VeryLazy" },

  config = function()
    require("neoscroll").setup({
      -- All these keys will be mapped to their corresponding default scrolling animation
      mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
      hide_cursor = true, -- Hide cursor while scrolling
      stop_eof = true,
      use_local_scrolloff = false,
      respect_scrolloff = true, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
      easing_function = nil, -- Default easing function
      pre_hook = nil, -- Function to run before the scrolling animation starts
      post_hook = nil, -- Function to run after the scrolling animation ends
      performance_mode = false, -- Disable "Performance Mode" on all buffers.
    })

    local t = {}
    t["<C-y>"] = { "scroll", { "-1", "true", "100" } }
    t["<C-e>"] = { "scroll", { "1", "true", "100" } }

    require("neoscroll.config").set_mappings(t)
  end,
}
