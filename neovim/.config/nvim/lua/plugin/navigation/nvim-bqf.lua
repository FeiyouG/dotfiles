return {
  "kevinhwang91/nvim-bqf",

  config = function()

    local bqf = require('bqf')

    bqf.setup({
      auto_enable = true,
      auto_resize_height = true, -- highly recommended enable
      preview = {
        auto_preview = true,
        border_chars = { '┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█' },
        delay_syntax = 80,
        win_height = 12,
        win_vheight = 12,
        wrap = false,
        should_preview_cb = function(bufnr, qwinid)
          local ret = true
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          local fsize = vim.fn.getfsize(bufname)
          if fsize > 100 * 1024 then
            -- skip file size greater than 100k
            ret = false
          elseif bufname:match('^fugitive://') then
            -- skip fugitive buffer
            ret = false
          end
          return ret
        end
      },
      func_map = {
        open = "<CR>",
        openc = "o",
        drop = "O",
        tabdrop = "",
        tab = "<C-t>",
        tabb = "<C-T>",
        tabc = "",
        split = "<C-s>",
        vsplit = "<C-v>",
        prevfile = "<C-p>",
        nextfile = "<C-n>",
        prevhist = "<",
        nexthist = ">",
        lastleave = "'\"",
        stoggleup = "<S-Tab>",
        stoggledown = "<Tab>",
        stogglevm = "<Tab>",
        stogglebuf = "'<Tab>",
        sclear = "z<Tab>",
        pscrollup = "<C-u>",
        pscrolldown = "<C-d>",
        pscrollorig = "zo",
        ptogglemode = "<leader>z",
        ptoggleitem = "p",
        ptoggleauto = "P",
        filter = "zn",
        filterr = "zN",
        fzffilter = "zf",
      },
    })
  end,

  defer = function()

    local has_command_center, command_center = pcall(require, 'command_center')
    if not has_command_center then return end

    local noremap = { noremap = true }

    command_center.add({
      {
        description = "Toggle quick fix list",
        cmd = "<CMD>BqfAutoToggle<CR>",
        keybindings = {
          { "n", "<leader>q", noremap },
          { "n", "<leader>qq", noremap },
        }
      },
      {
        description = "Go to the next item in quickfix list",
        cmd = "<CMD>cn<CR>",
        keybindings = { "n", "<leader>qn", noremap }
      },
      {
        description = "Go to the previous item in quickfix list",
        cmd = "<CMD>cp<CR>",
        keybindings = { "n", "<leader>qp", noremap }
      },
    })
  end
}
