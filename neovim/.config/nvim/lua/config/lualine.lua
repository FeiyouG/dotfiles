local status, lualine = pcall(require, "lualine")
if (not status) then return end

lualine.setup {
  options = {
    icons_enabled = true,
    -- theme = 'material-nvim',
    -- theme = 'nord',
    theme = "onenord",
    section_separators = {left = '', right = ''},
    component_separators = {left = '', right = ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'filename'},
    lualine_c = {
      'branch',
      'diff'
      },
    lualine_x = {
      { 'diagnostics',
        sources = {"nvim_lsp"},
        symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
      'encoding',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
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
        sources = {"nvim_lsp"},
         symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '}
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
