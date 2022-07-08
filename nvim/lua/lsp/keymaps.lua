-- See `:help vim.diagnostic.*` for documentation on any of the below functions

local map = vim.keymap.set
local opts = { noremap=true, silent=true }

map('n', '<leader>e', vim.diagnostic.open_float, opts)
map('n', '[d', vim.diagnostic.goto_prev, opts)
map('n', ']d', vim.diagnostic.goto_next, opts)
map('n', '<leader>q', vim.diagnostic.setloclist, opts)
