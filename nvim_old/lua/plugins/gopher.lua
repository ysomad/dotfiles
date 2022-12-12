require('gopher').setup()

local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

map('n', '<leader>gs', '<cmd>GoTagAdd json<CR>', opts)
map('n', '<leader>gr', '<cmd>GoTagRm json<CR>', opts)
