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

  -- lib
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'kkharji/sqlite.lua'
  use 'rcarriga/nvim-notify'

  -- lsp
  use {
    'hrsh7th/nvim-cmp',
    config = function() require('plugins.cmp') end
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lsp-document-symbol'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-cmdline'
  use 'uga-rosa/cmp-dictionary'
  use 'onsails/lspkind.nvim'
  use {
    'neovim/nvim-lspconfig',
    config = function() require('plugins.lspconfig') end
  }
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'jayp0521/mason-null-ls.nvim'
  use {
    'tami5/lspsaga.nvim',
    config = function() require('plugins.lspsaga') end
  }
  use {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    config = function() require('fidget').setup() end
  }
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
    config = function() require('plugins.nvim-treesitter') end
  }
  use {
    'JoosepAlviste/nvim-ts-context-commentstring',
  }
  use 'windwp/nvim-ts-autotag'

  -- finder
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    requires = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      'nvim-telescope/telescope-frecency.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim'
    },
    config = function() require('plugins.telescope') end
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
    config = function() require('plugins.nvim-tree') end
  }

  -- line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function() require('lualine').setup() end
  }
  use {
    'akinsho/nvim-bufferline.lua',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function() require('plugins.bufferline') end
  }
  use {
    "petertriho/nvim-scrollbar",
    config = function() require('scrollbar').setup() end
  }

  use { 'kevinhwang91/nvim-bqf' }

  use {
    'numToStr/Comment.nvim',
    requires = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end
  }
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup() end
  }
  use 'lukas-reineke/indent-blankline.nvim'
  use 'machakann/vim-highlightedyank'
  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end
  }
  use({
    'mvllow/modes.nvim',
    tag = 'v0.2.0',
    config = function()
      require('modes').setup()
    end
  })
  use {
    'folke/todo-comments.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('todo-comments').setup() end
  }
  use {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require('hlslens').setup()
      vim.keymap.set('n', '<Leader>/', [[*<Cmd>lua require('hlslens').start()<CR>]])
    end
  }

  use {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }

      local hop = require('hop')
      local directions = require('hop.hint').HintDirection
      vim.keymap.set('', 'fw', function()
        hop.hint_words({ direction = directions.AFTER_CURSOR })
      end, {remap=true})
      vim.keymap.set('', 'Fw', function()
        hop.hint_words({ direction = directions.BEFORE_CURSOR })
      end, {remap=true})
      vim.keymap.set('', 'fl', function()
        hop.hint_lines({ direction = directions.AFTER_CURSOR })
      end, {remap=true})
      vim.keymap.set('', 'Fl', function()
        hop.hint_lines({ direction = directions.BEFORE_CURSOR })
      end, {remap=true})
      vim.keymap.set('', 'fc', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
      end, {remap=true})
      vim.keymap.set('', 'Fc', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
      end, {remap=true})
    end
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

  use {
    'mopp/vim-operator-convert-case',
    requires = { 'kana/vim-operator-user' },
    config = function()
      require('plugins.vim-operator-convert-case')
    end
  }
  use{
    "gbprod/substitute.nvim",
    config = function()
      require("substitute").setup({
      })
      vim.keymap.set("n", "_", require('substitute').operator)
      vim.keymap.set("x", "_", require('substitute').visual)
    end
  }

  use {
    'monaqa/dial.nvim',
    config = function()
      vim.keymap.set("n", "+", require("dial.map").inc_normal())
      vim.keymap.set("n", "-", require("dial.map").dec_normal())
      vim.keymap.set("x", "+", require("dial.map").inc_visual())
      vim.keymap.set("x", "-", require("dial.map").dec_visual())
    end
  }

  use {
    "lewis6991/gitsigns.nvim",
    config = function() require('gitsigns').setup() end
  }

  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<Tab>",
          }
        },
      })
    end,
  }
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function ()
      require("copilot_cmp").setup()
    end
  }

  -- colorschema
  use 'ellisonleao/gruvbox.nvim'
  use 'sainnhe/gruvbox-material'
  use 'folke/tokyonight.nvim'
  use 'rebelot/kanagawa.nvim'
  use 'EdenEast/nightfox.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

