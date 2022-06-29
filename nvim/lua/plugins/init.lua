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

    -- telescope
    use {
      'nvim-telescope/telescope.nvim',
      config = require('plugins.telescope')
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- Pretty things
    use {
      'norcalli/nvim-colorizer.lua',
      config = require('plugins.nvim-colorizer')
    }
    use {
      'nvim-lualine/lualine.nvim',
      config = require('plugins.lualine')
    }
    use {
      'akinsho/bufferline.nvim',
      tag = "v2.*",
      config = require('plugins.bufferline')
    }

    -- Utils
    use {
      'numToStr/Comment.nvim',
      config = require('Comment').setup()
    }

    -- Snippets
    -- use 'L3MON4D3/LuaSnip'
    -- use 'saadparwaiz1/cmp_luasnip'

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
