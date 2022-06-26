local cmd = vim.cmd                         -- execute Vim commands
local exec = vim.api.nvim_exec              -- execute Vimscript
local g = vim.g                             -- global variables
local opt = vim.opt                         -- global/buffer/windows-scoped options

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

-- Plugin settings
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
    icons_enabled = false,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
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
}

require('bufferline').setup {
  options = {
    mode = 'buffers', -- set to "tabs" to only show tabpages instead
    numbers = 'buffer_id',
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
      if buf.name:match('%.md') then
        return vim.fn.fnamemodify(buf.name, ':t:r')
      end
    end,
    max_name_length = 32,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 0,
    diagnostics = 'nvim_lsp',
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "("..count..")"
    end,
    color_icons = false, -- whether or not to add the filetype icon highlights
    show_buffer_icons = false, -- disable filetype icons for buffers
    show_buffer_close_icons = false,
    show_buffer_default_icon = false, -- whether or not an unrecognised filetype should show a default icon
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    separator_style = 'thin',
    enforce_regular_tabs = false,
    always_show_bufferline = true,
  }
}
