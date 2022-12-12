local map = vim.api.nvim_set_keymap
local opts = {noremap = true}

-- greates remaps ever (yoinked from primeagen)
map('x', '<leader>p', '"_dP', opts)
map('n', '<leader>d', '"_d', opts)
map('v', '<leader>d', '"_d', opts)

map('n', '<leader>pv', ':Ex<CR>', opts)
map('n', 'Q', '<nop>', opts)

-- better indenting
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- disable arrows
map('', '<up>', '', opts)
map('', '<down>', '', opts)
map('', '<left>', '', opts)
map('', '<right>', '', opts)

-- center screen on Ctrl+u, Ctrl+d moves
map('n', '<C-d>', '<C-d>zz', opts)
map('n', '<C-u>', '<C-u>zz', opts)

-- center screen on next
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)

vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
