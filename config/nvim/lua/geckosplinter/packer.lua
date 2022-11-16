return require('packer').startup(function()
      use 'wbthomason/packer.nvim'

      -- Git sections
      use 'tpope/vim-fugitive'
      use 'lewis6991/gitsigns.nvim'


      -- Utilities sections
      use 'nvim-lua/popup.nvim'
      use {
            'nvim-telescope/telescope.nvim', tag = '0.1.0',
            requires = {
                  'nvim-lua/plenary.nvim',
                  { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
                  { 'kyazdani42/nvim-web-devicons', opt = true},
                  { "nvim-telescope/telescope-live-grep-args.nvim" }
            }
      }
      use 'mbbill/undotree'
      use { 'nvim-treesitter/nvim-treesitter', run = 'TSUpdate' }
      use {'kevinhwang91/nvim-bqf', ft = 'qf'}
      use {
          'windwp/nvim-spectre', requires = {
              { 'nvim-lua/plenary.nvim' }
          }
      }

      -- Completion lps
      use 'williamboman/nvim-lsp-installer'
      use 'neovim/nvim-lspconfig'
      use 'hrsh7th/cmp-nvim-lsp'
      use 'hrsh7th/cmp-buffer'
      use 'hrsh7th/cmp-path'
      use 'hrsh7th/nvim-cmp'
      --use { 'tzachar/cmp-tabnine', run = './install.sh' }
      use 'onsails/lspkind-nvim'
      use 'nvim-lua/lsp_extensions.nvim'
      use 'glepnir/lspsaga.nvim'
      use 'simrat39/symbols-outline.nvim'
      use 'L3MON4D3/LuaSnip'
      use 'saadparwaiz1/cmp_luasnip'
      use 'j-hui/fidget.nvim'
      use 'b0o/schemastore.nvim'
      use {
          'RishabhRD/lspactions',
          requires = {
              'nvim-lua/plenary.nvim',
              'nvim-lua/popup.nvim'
          }
      }

      -- Interface section
      use 'gruvbox-community/gruvbox'
      use 'kyazdani42/nvim-web-devicons'
      use 'lukas-reineke/indent-blankline.nvim'
      use {
          'kyazdani42/nvim-tree.lua',
          requires = { 'kyazdani42/nvim-web-devicons', opt = true }
      }
      use {
          'nvim-lualine/lualine.nvim',
          requires = { 'kyazdani42/nvim-web-devicons', opt = true }
      }

      -- Other stuff
      use 'towolf/vim-helm'
      use 'sebdah/vim-delve'
      use 'fatih/vim-go'
  end)
