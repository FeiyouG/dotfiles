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
        theme = "onenord",
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = {},
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000
        }
      },
      sections = {
        lualine_a = {
          "mode",
        },
        lualine_b = {
          {
            'filename',
            file_status = false,
            newfile_status = true,
            path = 0,
            symbols = {
              modified = "[" .. Utils.icons.file.modified .. "]",
              readonly = "[" .. Utils.icons.file.readonly .. "]",
              unnamed = "[No Name]",
              newfile = "[New]",
            }
          }
        },
        lualine_c = {
          { 'branch' },
          {
            'diff',
            source = diff_source,
            symbols = {
              added = Utils.icons.git.added_line,
              modified = Utils.icons.git.modified_line,
              removed = Utils.icons.git.deleted_line,
            },
            diff_color = Utils.highlight.lualine.diff
          },
        },
        lualine_x = {
          {
            'diagnostics',
            sources = { "nvim_lsp" },
            symbols = {
              error = Utils.icons.diagnostic.error,
              warn = Utils.icons.diagnostic.warning,
              info = Utils.icons.diagnostic.info,
              hint = Utils.icons.diagnostic.hint,
            }
          },
          'encoding',
          {
            'filetype',
            colored = true,
            icon_only = false,
            icon = { align = "left" }
          }
        },
        lualine_y = {
          { 'progress' },
        },
        lualine_z = {
          { 'location' }
        }
      },
      inactive_sections = {
        lualine_a = {
          'filename',
          'branch'
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {
          {
            'diagnostics',
            sources = { "nvim_lsp" },
            symbols = {
              error = Utils.icons.diagnostic.error,
              warn = Utils.icons.diagnostic.warning,
              info = Utils.icons.diagnostic.info,
              hint = Utils.icons.diagnostic.hint,
            }
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
