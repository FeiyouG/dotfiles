return {
  'nvim-lualine/lualine.nvim',

  require = {
    'kyazdani42/nvim-web-devicons',
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

    local diff_source = function()
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return {
          added = gitsigns.added,
          modified = gitsigns.changed,
          removed = gitsigns.removed
        }
      end
      return nil
    end

    local function submode_comp()
      local hydra = Utils.require("hydra.statusline")
      if not hydra then return nil end

      return {
        hydra.get_name,
        cond = hydra.is_active
      }
    end

    -- Get diff source from gitsigns
    local function filename_comp()
      return {
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
    end

    local function diagnostic_comp()
      return {
        'diagnostics',
        sources = { "nvim_lsp" },
        symbols = {
          error = Utils.icons.diagnostic.error,
          warn = Utils.icons.diagnostic.warning,
          info = Utils.icons.diagnostic.info,
          hint = Utils.icons.diagnostic.hint,
        }
      }
    end

    local function diff_comp()
      local gitsigns = vim.b.gitsigns_status_dict
      return {
        'diff',
        source = diff_source,
        symbols = {
          added = Utils.icons.git.added_line,
          modified = Utils.icons.git.modified_line,
          removed = Utils.icons.git.deleted_line,
        },
        diff_color = Utils.highlight.lualine.diff
      }
    end

    local function filetype_comp()
      return {
        'filetype',
        colored = true,
        icon_only = false,
        icon = { align = "left" }
      }
    end

    local function tabs_comp()
      return {
        'tabs',
        mode = 0,
        separator = "",
        cond = function()
          return #vim.api.nvim_list_tabpages() > 1
        end
      }
    end

    local function buffers_comp()
      return {
        "buffers",
        separator = "",
        symbols = {
          modified = "[" .. Utils.icons.file.modified .. "]", -- Text to show when the buffer is modified
          alternate_file = "", -- Text to show to identify the alternate file
          directory = Utils.icons.folder.open, -- Text to show when the buffer is a directory
        },
        cond = function()
          return Utils.state.statusline.show_tabs
        end
      }
    end

    local function navic_comp()
      local navic = Utils.require("nvim-navic")
      if not navic then return {} end

      return {
        navic.get_location,
        cond = navic.is_available,
      }
    end

    lualine.setup {
      options = {
        theme = "onenord",
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = {
          winbar = {
            "NvimTree",
            "DiffviewFiles"
          }
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000
        }
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { submode_comp() },
        lualine_c = { tabs_comp(), buffers_comp() },
        lualine_x = { diff_comp(), 'branch' },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = { 'filename', 'branch' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = { diagnostic_comp() },
        lualine_y = {},
        lualine_z = {}
      },
      winbar = {
        lualine_b = { filename_comp(), },
        lualine_c = { navic_comp() },
        lualine_x = { "encoding", },
        lualine_y = { filetype_comp() }
        -- lualine_y = { "progress", "location" },
      },
      inactive_winbar = {
        lualine_c = { filename_comp(), },
      },
      tabline = {},
      -- extensions = { 'nvim-tree' }
    }
  end,
}
