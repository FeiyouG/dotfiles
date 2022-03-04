---- MARK: Keybinding
-- Use <leader>fc to open command paletter
vim.cmd "nnoremap <leader>fc <cmd>Telescope command_palette<cr>"
vim.cmd "vnoremap <leader>fc <cmd>Telescope command_palette<cr>"
-- If ever hesitate when using telescope start with <leader>f,
-- also open command pallete
vim.cmd "nnoremap <leader>f <cmd>Telescope command_palette<cr>"
vim.cmd "vnoremap <leader>f <cmd>Telescope command_palette<cr>"

---- MARK: Setups
local telescope = require('telescope')

telescope.setup {
  extensions = {
    command_palette = {
      {"Help & Manual",
        {"Find help (<leader>fh>)", ":Telescope help_tags", 1 },
        {"Show man pages (<leader>fm)", ":Telescope man_pages", 1 },
        {"Show all telecope commands (<leader>fa)", ":Telescope builtin", 1 },
        {"Show all autocommands", ":Telescope autocommands", 1},
        {"Show all avaliable filetypes", ":Telescope filetypes", 1},
        {"Show all avaliable highlights", ":Telescope highlights", 1},
        {"Show all keymaps (<leader>kl)", ":Telescope  keymaps", 1},
        {"Check health", ":checkhealth" },
      },
      {"LSP",
        {"Hover (K)", ":lua vim.lsp.buf.hover()"},
        {"Show signature help (<C-k>)", ":lua vim.lsp.buf.signature_help()"},
        {"Go to Delaration (<leader>gD)", ":lua vim.lsp.buf.declaration()"},
        {"Rename (<leader>gn)", ":lua vim.lsp.buf.rename()"},
        {"code actions (<leader>ga)", ":Telescope lsp_code_actions"},
        {"range code actions (<leader>gga)", ":Telescope lsp_range_code_actions"},
        {"Go to definitions (<leader>gd)", ":Telescope lsp_definitions"},
        {"Go to type definitions (<leader>gt)", ":Telescope lsp_type_definitions"},
        {"Go to references (<leader>gr)", ":Telescope lsp_references"},
        {"Show diagnostics (<leader>ge)", ":Telescope diagnostics"},
        {"Go to implementaions (<leader>gi)", ":Telescope lsp_implementations"},
        {"Show document symbols (<leader>gds)", ":Telescope lsp_document_symbols"},
        {"Show workspace symbols (<leader>gs)", ":Telescope lsp_workspace_symbols"},
        {"Show dynamic workspace symbols (<leader>ggs)", ":Telescope lsp_dynamic_workspace_symbols"},
        {"Show treesitter symbols (<leader>gts)", ":Telescope treesitter"},
        {"Format code <leader>gf", ":lua vim.lsp.buf.formatting()"},
      },
      {"Git",
        {"Show all git commits", ":Telescope git_commits"},
        {"Show current buffer commits", ":Telescope git_bcommits"},
        {"Show git branches", ":Telescope git_branches"},
        {"Show git status", ":Telescope git_status"},
        {"Show git stash", ":Telescope git_stash"},
      },
      {"Themes, Styles, & Icons",
        {"Show colorsheme", ":Telescope colorscheme"},
        {"Change to Material Deep Ocean", ":lua require('material.functions').change_style('deep ocean')"},
        {"Change to Material Oceanic", ":lua require('material.functions').change_style('oceanic')"},
        {"Change to Material Lighter", ":lua require('material.functions').change_style('lighter')"},
        {"Change to Material Darker", ":lua require('material.functions').change_style('darker')"},
        {"Change to Material Palenight", ":lua require('material.functions').change_style('palenight')"},
        {"Toggle Focus Mode", "Twilight"},
        {"Find math symbols", ":lua require'telescope.builtin'.symbols{ sources = {'math', 'latex'} }", 1},
        {"Find emojis & Icons", ":lua require'telescope.builtin'.symbols{ sources = {'emoji', 'gitmoji'} }", 1},
      },
      {"Buffer/File",
        {"Find in current buffer (<leader>fl)", ":Telescope current_buffer_fuzzy_find", 1 },
        {"Show all opening buffers (<leader>fb)", ":Telescope buffers" },
        {"Show recent buffers", ":Telescope oldfiles"},
        {"Show marks", ":Telescope marks"},
        {"Show spell suggestions", ":Telescope spell_suggest"},
      },
      {"Workspace",
        {"Find in working direcotry (<leader>fg>)", ":Telescope live_grep", 1 },
        {"Find files (<leader>fg>)", ":Telescope find_files", 1 },
      },
      {"History & lists",
        {"Show tags", ":Telescope tags"},
        {"Show quickfix", ":Telescope quickfix"},
        {"Show location list", ":Telescope loclist"},
        {"Show jumplist", ":Telescope jumplist"},
        {"Show registers", ":Telescope registers"},
        {"Show all keymaps (<leader>fk)", ":Telescope keymaps", 1 },
        {"Show all commands (<leader>fc)", ":Telescope commands", 1 },
        {"Show command history", ":Telescope commad_history"},
        {"Show search hisotry", ":Telescope search_history"},
        {"Show previous telescope session", ":Telescope pickers"},
      },
      {"Zettlekasten & Markdown",
        {"Open markdown preview", ":MarkdownPreview"},
        {"Close markdown preview", ":MarkdownPreviewStop"},
        {"Toggle markdown preview", ":MarkdownPreviewToggle"},
        {"Generate table of content", ":GenTocGFM"},
        {"Remove table of content", ":TemoveToc"},
        {"Open calendar", ":CalenderVR"},
      }
    }
  }
}

telescope.load_extension('command_palette')
