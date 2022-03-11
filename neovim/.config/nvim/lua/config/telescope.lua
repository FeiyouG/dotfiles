vim.cmd "nnoremap <leader>ff <cmd>Telescope find_files<cr>"
vim.cmd "nnoremap <leader>fg <cmd>Telescope live_grep<cr>"

-- Vim Picker Mappings
vim.cmd "nnoremap <leader>fh <cmd>Telescope help_tags<cr>"
vim.cmd "nnoremap <leader>fb <cmd>Telescope buffers<cr>"
vim.cmd "nnoremap <leader>fm <cmd>Telescope man_pages<cr>"
vim.cmd "nnoremap <leader>fk <cmd>Telescope keymaps<cr>"
-- vim.cmd "nnoremap <leader>fc <cmd>Telescope commands<cr>"
vim.cmd "nnoremap <leader>fl <cmd>Telescope current_buffer_fuzzy_find<cr>"


-- Lists Picker
vim.cmd "nnoremap <leader>fp <cmd>Telescope builtin<cr>"

-- LSP Picker Mappings

-- Treesitter Picker
vim.cmd "nnoremap <leader>sts <cmd>Telescope treesitter<cr>"


local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup{
  defaults = {
    layout_strategy = 'flex',

    mappings = {
      n = {
        ["q"] = actions.close,
        ["<Esc>"] = actions.close
      },

      i = {
        ["<Esc>"] = actions.close,
        ["<C-u>"] = false, -- Clear the prompt
      }
    },

    file_ignore_patterns = {
      "node_modules",
    },
  },

  pickers = {
    lsp_code_actions = {
      theme = "cursor",
    },

    }
}
