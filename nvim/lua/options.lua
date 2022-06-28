local g = vim.g                             -- global variables
local o = vim.opt                           -- global/buffer/windows-scoped options
local cmd = vim.cmd                         -- execute Vim commands
local exec = vim.api.nvim_exec              -- execute Vimscript

-- colors
cmd('colorscheme gruvbox')

g.gruvbox_contrast_dark = 'hard'
g.gruvbox_invert_selection = '0'

cmd('highlight Normal guibg=none')
cmd('highlight signcolumn guibg=none')

o.termguicolors = true

-- general
o.clipboard = 'unnamedplus'

o.nu = true
o.relativenumber = true

o.hidden = true
o.errorbells = false
o.emoji = false
o.cul = false -- cursor line
o.mouse = 'a'

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true
o.wrap = false

-- do not show empty buffers
o.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }

-- window Splitting and Buffers
o.hidden = true
o.splitbelow = true
o.splitright = true
o.eadirection = "hor"
-- exclude usetab as we do not want to jump to buffers in already open tabs
-- do not use split or vsplit to ensure we don't open any new windows
o.switchbuf = 'useopen,uselast'
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
o.foldmethod = 'manual'

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

g.mapleader = ' '

