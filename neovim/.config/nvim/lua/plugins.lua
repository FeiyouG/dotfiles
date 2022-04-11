---- MARK: Automatically download packer if missing ----
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap = nil

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end

require("command_center").add({
  {
    description = "Sync plugins",
    command = "PackerSync",
  }, {
    description = "Show plugins startup time",
    command = "PackerProfile",
  }, {
    description = "Show plugins status",
    command = "PackerStatus",
  },
})

local function get_config(name)
    return string.format("require(\"config/%s\")", name)
end


---- MARK: Initialize Packer ----
local packer = require("packer")
packer.init {
  profile = {
    enable = true,
    threshold = 0,
  },

  display = {
    open_fn = require('packer.util').float,
  }
}

local use = packer.use
packer.reset()


---- MARK: Install and Manage Plugins ----
-- Packer can manage itself
use {'wbthomason/packer.nvim'}

---- Reduce startup time by caching ----
use { 'lewis6991/impatient.nvim', config = get_config("impatient")}

---- MISCS ----
use {
  {'kyazdani42/nvim-tree.lua', config = get_config("nvim-tree")},
  { 'ahmedkhalf/project.nvim', config = get_config("project") },
  {'lukas-reineke/indent-blankline.nvim'},
  {'numToStr/Comment.nvim', config = get_config("comment")},
  {'tpope/vim-fugitive'}
}


---- Theme, Styles, and Icons ----
use {
  -- {'marko-cerovac/material.nvim', config = get_config("material")},
  -- {'shaunsingh/nord.nvim', config = get_config("nord")},
  {'rmehri01/onenord.nvim', config = get_config("onenord")},
  {'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}, config = get_config('lualine')},
  {'fladson/vim-kitty'} -- Syntax highlight for kitty config files
  -- {'sindrets/diffview.nvim',  requires = 'nvim-lua/plenary.nvim'},
  -- {'sidebar-nvim/sidebar.nvim'}
  -- {'folke/twilight.nvim'}
  -- {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'},
}


---- Treesitter ----
use {
  {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = get_config("nvim-treesitter")},
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'JoosepAlviste/nvim-ts-context-commentstring' },
}


---- LSP ----
use {
  {'neovim/nvim-lspconfig', config = get_config("lsp/nvim-lspconfig")},
  { 'williamboman/nvim-lsp-installer', config = get_config("lsp/nvim-lsp-installer")},
  { 'jose-elias-alvarez/null-ls.nvim', config = get_config("lsp/null-ls")},
  -- {'mfussenegger/nvim-lint', config = get_config("nvim-lint"),},
}

---- Snip Engine and Snippets ----
use {
  {'L3MON4D3/LuaSnip', config = get_config("luasnip")},
  { 'rafamadriz/friendly-snippets' },
}

---- nvim-cmp Ecosystem for Autocompletion ----
use {
  {'hrsh7th/nvim-cmp', requires = { 'nvim-lua/plenary.nvim' }, config = get_config("nvim-cmp")},
  { 'hrsh7th/cmp-cmdline'},
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  {'hrsh7th/cmp-path' },
  { 'saadparwaiz1/cmp_luasnip' },
  {'hrsh7th/cmp-nvim-lsp-document-symbol' },
  { 'uga-rosa/cmp-dictionary', config = get_config("cmp-dictionary") },
  -- {'jc-doyle/cmp-pandoc-references'}
  -- {'kdheepak/cmp-latex-symbols'}
  -- {'aspeddro/cmp-pandoc.nvim'}
}

---- Autopair ----
use  {
  {'windwp/nvim-ts-autotag', config = get_config("nvim-ts-autotag")},
  {'windwp/nvim-autopairs', config = get_config("nvim-autopairs")},
}

---- Tmux Integegration
-- use { '$XDG_DATA_HOME/tmux/plugins/tmux-navigate'}
use {
  {'RyanMillerC/better-vim-tmux-resizer', config = get_config("better-vim-tmux-resizer")},
  {'christoomey/vim-tmux-navigator'},
}

---- Telescope Ecosystem for Search ----
use {
  {'nvim-telescope/telescope.nvim',requires = { 'nvim-lua/plenary.nvim'}, config = get_config("telescope")},
  { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', config = get_config("fzf") },
  { 'fhill2/telescope-ultisnips.nvim' },
  {'git@github.com:FeiyouG/command_center.nvim.git', config = get_config("command_center")},
-- {'/Users/feiyouguo/Documents/Mine/UW/Current_Quarter/my_project/command-center.nvim', get_confi}
  { 'nvim-telescope/telescope-symbols.nvim' },
}

---- Markdown and ZK Ecosytem ----
use {
  {"mickael-menu/zk-nvim", config = get_config("lsp/custom_servers/zk-nvim")},
  {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', config = get_config("markdown-preview")},
  {'mzlogin/vim-markdown-toc', config = get_config("vim-markdown-toc")},
}



---- MARK: Automatically install and update plugins ----
vim.api.nvim_exec([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]], false)
