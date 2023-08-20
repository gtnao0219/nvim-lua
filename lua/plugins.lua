local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- lsp
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lsp-document-symbol'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-cmdline'
  use 'onsails/lspkind.nvim'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use({
    'L3MON4D3/LuaSnip',
    tag = 'v2.*',
    run = 'make install_jsregexp',
    config = function() require('luasnip.loaders.from_vscode').lazy_load() end
  })
  use 'saadparwaiz1/cmp_luasnip'

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  -- finder
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use {
    'startup-nvim/startup.nvim',
    requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    config = function() require('startup').setup() end
  }

  -- filer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' },
  }

  -- line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use {
    'akinsho/bufferline.nvim', tag = '*',
    requires = 'nvim-tree/nvim-web-devicons',
  }
  use {
    'sidebar-nvim/sidebar.nvim',
    config = function() require('sidebar-nvim').setup({ open = true }) end
  }

  use {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end
  }
  -- use {
  --   "windwp/nvim-autopairs",
  --   config = function() require("nvim-autopairs").setup() end
  -- }
  use 'lukas-reineke/indent-blankline.nvim'
  use 'machakann/vim-highlightedyank'
  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end
  }
  use {
    'folke/todo-comments.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('todo-comments').setup() end
  }

  use {
    'kylechui/nvim-surround',
    config = function() require('nvim-surround').setup() end
  }

  use {
    'akinsho/toggleterm.nvim',
    tag = '*',
    config = function() require('toggleterm').setup() end
  }

  -- colorschema
  use 'sainnhe/gruvbox-material'
  use 'folke/tokyonight.nvim'
  use 'rebelot/kanagawa.nvim'
  use 'EdenEast/nightfox.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
