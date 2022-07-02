local g = vim.g                             -- global variables
local o = vim.opt                           -- global/buffer/windows-scoped options
local cmd = vim.cmd                         -- execute Vim commands
local exec = vim.api.nvim_exec              -- execute Vimscript
local hi = vim.highlight.create             -- create hightlight

-- yoinked from primeagen dots
local hl = function(thing, opts)
  vim.api.nvim_set_hl(0, thing, opts)
end

-- colors
cmd('colorscheme gruvbox')

-- transparent column on the left side from line numbers
hl('SignColumn', { bg = 'none' })

-- transparent bg
hl('Normal', { bg = 'none' })

-- set cursorline bg to none
hi('CursorLine', { guibg='none' })
hi('CursorLineNr', { guibg='none' })

g.gruvbox_contrast_dark = 'hard'
g.gruvbox_invert_selection = '0'

o.termguicolors = true

-- general
o.clipboard = 'unnamedplus'

o.nu = true
o.relativenumber = true

o.hidden = true
o.errorbells = false
o.emoji = false
o.cul = true -- cursor line
o.mouse = 'a'

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true
o.wrap = false

o.hidden = true
o.fillchars = {
  vert = " ",
  fold = " ",
  eob = " ",
  diff = "░",
  msgsep = "‾",
  foldopen = "▾",
  foldsep = "|",
  foldclose = "▸",
}

o.swapfile = false
o.backup = false
o.undodir = os.getenv('HOME') .. '/.vim/undodir'
o.undofile = true

o.hlsearch = false
o.incsearch = true

o.scrolloff = 8
o.signcolumn = 'yes'
o.isfname:append('@-@')

o.title = true
o.titlestring = '%f - nvim'
o.conceallevel = 2 -- Hide * markup for bold and italic

-- give more space for displaying messages.
o.cmdheight = 1

-- having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
o.updatetime = 50

-- don't pass messages to |ins-completion-menu|.
o.shortmess:append('c')

o.colorcolumn = '100'
o.showmode = false

g.mapleader = ' '
