local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup {
  function(use)
    -- core
    use 'wbthomason/packer.nvim'
    use {
      'kyazdani42/nvim-web-devicons',
      config = function()
        require('nvim-web-devicons').setup({ default = true; })
      end
    }
    use 'nvim-lua/plenary.nvim'

    -- colorschemas
    use 'gruvbox-community/gruvbox'
    use 'joshdick/onedark.vim'
    use 'folke/tokyonight.nvim'

    -- lsp
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/nvim-cmp'
    use {
      'tzachar/cmp-tabnine',
      run='./install.sh',
      requires = 'hrsh7th/nvim-cmp'
    }
    use('onsails/lspkind-nvim')

    -- telescope
    use {
      'nvim-telescope/telescope.nvim',
      config = function()
        require('plugins.telescope')
      end
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

     -- pretty things
    use {
      'norcalli/nvim-colorizer.lua',
      config = function()
        require('plugins.nvim-colorizer')
      end
    }
    use {
      'nvim-lualine/lualine.nvim',
      config = function()
        require('plugins.lualine')
      end
    }
    use {
      'akinsho/bufferline.nvim',
      tag = "v2.*",
      config = function()
        require('plugins.bufferline')
      end
    }

    -- utils
    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    }

    -- snippets
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    if packer_bootstrap then
      require('packer').sync()
    end
  end,

  -- packer config
  log = { level = 'info' },
  config = {
    display = {
      prompt_border = 'single',
    },
    profile = {
      enable = true,
      threshold = 0,
    },
  },
}
