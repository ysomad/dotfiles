vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use({
    'aktersnurra/no-clown-fiesta.nvim',
    config = function() vim.cmd.colorscheme('no-clown-fiesta') end
  })

  use({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
  use 'nvim-treesitter/nvim-treesitter-context'

  use('ray-x/lsp_signature.nvim')
  use('mbbill/undotree')

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use('lukas-reineke/indent-blankline.nvim')

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }

  use {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup { icons = false }
    end
  }

  -- use {
  --   'fatih/vim-go',
  --   run = ':GoUpdateBinaries'
  -- }
  -- use 'github/copilot.vim'

end)
