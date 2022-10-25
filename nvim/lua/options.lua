local g = vim.g
local o = vim.opt
local cmd = vim.cmd
local exec = vim.api.nvim_exec

local hl = function(thing, opts)
  vim.api.nvim_set_hl(0, thing, opts)
end

g.mapleader = ' '
o.cursorline = true
o.termguicolors = true
o.clipboard = 'unnamedplus'
o.nu = true
o.relativenumber = true
o.hidden = true
o.errorbells = false
o.mouse = 'a'
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true
o.wrap = false
o.hidden = true
o.swapfile = false
o.backup = false
o.undodir = os.getenv('HOME') .. '/.vim/undodir'
o.undofile = true
o.hlsearch = false
o.incsearch = true
o.scrolloff = 8
o.signcolumn = 'yes'
o.cmdheight = 1
o.updatetime = 50
o.showmode = false
o.colorcolumn = '120'

-- g.oxocarbon_lua_alternative_telescope = true
-- cmd("colorscheme oxocarbon-lua")

-- cmd("colorscheme gruvbox")
-- g.gruvbox_contrast_dark = 'hard'
-- g.gruvbox_invert_selection = '0'
