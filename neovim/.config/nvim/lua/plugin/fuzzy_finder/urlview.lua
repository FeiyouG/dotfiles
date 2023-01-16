return {
  "axieax/urlview.nvim",
  requires = {
    "nvim-telescope/telescope.nvim",
  },

  config = function()
    require("urlview").setup({
      default_picker = "telescope",
      default_prefix = "https://",
      default_action = "system",
      unique = true,
      sorted = true,
      jump = {
        ["prev"] = "[u",
        ["next"] = "]u",
      },
    })
  end,

  commands = function()
    return {
      {
        desc = "Show all buffer links",
        cmd = "<Cmd>UrlView<CR>",
        keys = {
          { { "n", "v" }, "<leader>fu" },
          { { "n", "v" }, "<leader>fub" },
        },
      },
      {
        desc = "Show all plugin links",
        cmd = "<Cmd>UrlView packer<CR>",
        keys = { { "n", "v" }, "<leader>fup" },
      },
    }
  end,
}
