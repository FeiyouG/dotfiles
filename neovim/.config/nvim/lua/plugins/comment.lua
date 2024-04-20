return {
  {
    'numToStr/Comment.nvim',
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("Comment").setup({
        ignore = nil,
        toggler = {
          line = 'gc',
          block = 'gC',
        },
        opleader = {
          line = 'gc',
          block = 'gC',
        },
        mappings = {
          extra = false,
        },
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end
  },
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    opts = {
      keywords = {
        FIX = { icon = settings.icons.test.fix, color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, },
        TODO = { icon = settings.icons.comment.todo, color = "info" },
        HACK = { icon = settings.icons.comment.hack, color = "warning" },
        WARN = { icon = settings.icons.diagnostic.warning, color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = settings.icons.comment.optimized, alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" }, color = "hint" },
        NOTE = { icon = settings.icons.comment.note, color = "hint", alt = { "INFO" } },
        TEST = { icon = settings.icons.test.test, color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      merge_keywords = false,
    }
  }
}
