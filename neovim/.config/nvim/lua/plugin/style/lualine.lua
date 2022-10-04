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
        cond = function()
          return #vim.api.nvim_list_tabpages() > 1
        end
      }
    end

    local function buffers_comp()
      return {
        "buffers",
        cond = {}
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
        lualine_b = {},
        lualine_c = { tabs_comp(), "buffers" },
        lualine_x = { diff_comp(), 'branch' },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      -- inactive_sections = {
      --   lualine_a = { 'filename', 'branch' },
      --   lualine_b = {},
      --   lualine_c = {},
      --   lualine_x = { diagnostic_comp() },
      --   lualine_y = {},
      --   lualine_z = {}
      -- },
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

  -- commands = function()
  --   return {
  --     {
  --       desc = "Go to previous buffer",
  --       cmd = "<CMD>bp<CR>",
  --       keys = { "n", "<C-b>h", Utils.keymap.noremap }
  --     }, {
  --       desc = "Got to next buffer",
  --       cmd = "<CMD>bn<CR>",
  --       keys = { "n", "<C-b>n", Utils.keymap.noremap }
  --     }, {
  --       desc = "Move previous buffer",
  --       cmd = "<CMD><CR>",
  --       keys = { "n", "H", Utils.keymap.noremap }
  --     }, {
  --       desc = "Move next buffer",
  --       cmd = "<CMD>BufferMoveNext<CR>",
  --       keys = { "n", "L", Utils.keymap.noremap }
  --     }, {
  --       desc = "Pin buffer",
  --       cmd = "<CMD>BufferPin<CR>",
  --       keys = { "n", "p", Utils.keymap.noremap }
  --     }, {
  --       desc = "Chose buffer",
  --       cmd = "<CMD>BufferPick<CR>",
  --       keMoveys = { "n", "s", Utils.keymap.noremap }
  --     }, {
  --       desc = "Close buffer",
  --       cmd = "<CMD>BufferClose<CR>",
  --       keys = { "n", "c", Utils.keymap.noremap }
  --     }, {
  --       desc = "Order buffer by number",
  --       cmd = "<CMD>BufferOrderByBufferNumber<CR>",
  --     }, {
  --       desc = "Order buffer by directory",
  --       cmd = "<CMD>BufferOrderByBufferDirectory<CR>",
  --     }, {
  --       desc = "Order buffer by language",
  --       cmd = "<CMD>BufferOrderByBufferLanguage<CR>",
  --     }, {
  --       desc = "Order buffer by window number",
  --       cmd = "<CMD>BufferOrderByBufferWindowNumber<CR>",
  --     }
  --   }
  -- end
}
