local cmd = vim.cmd                         -- execute Vim commands
local exec = vim.api.nvim_exec              -- execute Vimscript
local g = vim.g                             -- global variables
local opt = vim.opt                         -- global/buffer/windows-scoped options
local opt_local = vim.opt_local             -- local options
local autocmd = vim.api.nvim_create_autocmd -- create auto command

-- Colors
cmd('colorscheme gruvbox')

g.gruvbox_contrast_dark = 'hard'
g.gruvbox_invert_selection = '0'

cmd('highlight Normal guibg=none')
cmd('highlight signcolumn guibg=none')

-- General
opt.clipboard = 'unnamedplus'
opt.guicursor = ''

opt.nu = true
opt.relativenumber = true

opt.hidden = true
opt.errorbells = false

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true

opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true

opt.scrolloff = 8
opt.signcolumn = 'yes'
opt.isfname:append('@-@')

-- Give more space for displaying messages.
opt.cmdheight = 1

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
opt.updatetime = 50

-- Don't pass messages to |ins-completion-menu|.
opt.shortmess:append('c')

opt.colorcolumn = '100'

g.mapleader = ' '

-- ??????????????
g.tagbar_compact = 1
g.tagbar_sort = 0

-- Auto commands

-- don't auto commenting new lines
autocmd({'BufEnter'}, {
  pattern = '*',
  callback = function()
    opt.fo:remove('c')
    opt.fo:remove('r')
    opt.fo:remove('o')
  end
})

-- 2 spaces for selected filetypes
autocmd({'FileType'}, {
  pattern = 'xml,html,xhtml,css,scss,javascript,lua,yaml,htmljinja',
  callback = function()
    opt_local.shiftwidth = 2
    opt_local.tabstop = 2
  end
})

-- Go: format and sort imports on save
autocmd({'BufWritePre'}, {
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.formatting()
    goimports(1000)
  end
})

-- Omnifunc
--cmd [[
--autocmd FileType go setlocal omnifunc=v:lua.vim.lsp.omnifunc
--]]
autocmd({'FileType'}, {
  pattern = 'go',
  callback = function()
    opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
  end
})


-- TODO: MOVE 

require('nvim-web-devicons').setup { default = true; }

require('colorizer').setup({'*';}, {
  RGB      = true;         -- #RGB hex codes
  RRGGBB   = true;         -- #RRGGBB hex codes
  names    = true;         -- "Name" codes like Blue
  RRGGBBAA = true;         -- #RRGGBBAA hex codes
  rgb_fn   = true;         -- CSS rgb() and rgba() functions
  hsl_fn   = true;         -- CSS hsl() and hsla() functions
  css      = true;         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
  css_fn   = true;         -- Enable all CSS *functions*: rgb_fn, hsl_fn
})

require('telescope').setup{
  pickers = {
    buffers = { 
      initial_mode = 'normal' 
    }
  }
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
