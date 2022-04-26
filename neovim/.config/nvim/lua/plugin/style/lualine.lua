local M = {
  'nvim-lualine/lualine.nvim',

  require = {
    'kyazdani42/nvim-web-devicons',
  },

  config = function()
    local lualine = require("lualine")

    lualine.setup {
      options = {
        icons_enabled = true,
        theme = "onenord",
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'filename' },
        lualine_c = {
          'branch',
          'diff'
        },
        lualine_x = {
          { 'diagnostics',
            sources = { "nvim_lsp" },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } },
          'encoding',
          'filetype'
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {
          'filename',
          'branch'
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {
          { 'diagnostics',
            sources = { "nvim_lsp" },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }
          },
          --'filetype',
          --'location'
        },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = { 'nvim-tree' }
    }
  end
}

return M
