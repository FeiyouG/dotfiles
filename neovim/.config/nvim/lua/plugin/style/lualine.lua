return {
  'nvim-lualine/lualine.nvim',

  require = {
    'kyazdani42/nvim-web-devicons',
    'anuvyklack/hydra.nvim',
  },

  config = function()
    local lualine = require("lualine")

    local custom_mode = {}

    -- Custom component for custom modes
    custom_mode.is_active = function()
      local has_hydra, hydra = pcall(require, "hydra.statusline")
      return has_hydra and hydra.is_active()
    end

    custom_mode.name = function()
      if not custom_mode.is_active() then return nil end
      local hydra = require("hydra.statusline")
      return hydra.get_name() .. " submode"
    end

    -- Get diff source from gitsigns
    local diff_source = function()
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return {
          added = gitsigns.added,
          modified = gitsigns.changed,
          removed = gitsigns.removed
        }
      end
    end

    lualine.setup {
      options = {
        icons_enabled = true,
        theme = "onenord",
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
      },
      sections = {
        lualine_a = {
          { "mode" },
          {
            custom_mode.name,
            cond = custom_mode.is_active,
          }
        },
        lualine_b = { 'filename' },
        lualine_c = {
          { 'branch' },
          { 'diff', source = diff_source },
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
