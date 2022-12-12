vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- use 'gruvbox-community/gruvbox'
  -- use 'joshdick/onedark.vim'
  use({
    'aktersnurra/no-clown-fiesta.nvim',
    config = function() vim.cmd.colorscheme('no-clown-fiesta') end
  })
  -- use({
  --   'nyoom-engineering/oxocarbon.nvim',
  --   config = function()
  --     vim.cmd.colorscheme('oxocarbon')
  --     vim.opt.background = 'dark'
  --   end
  -- })

  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

  use('tpope/vim-fugitive')
  use('ray-x/lsp_signature.nvim')

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
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }

end)
