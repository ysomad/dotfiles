-- greates remaps ever (yoinked from primeagen)
vim.keymap.set('x', '<leader>p', '"_dP')
vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

vim.keymap.set('n', '<leader>pv', ':Ex<CR>')
vim.keymap.set('n', 'Q', '<nop>')

-- better indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- disable arrows
vim.keymap.set('n', '<up>', '')
vim.keymap.set('n', '<down>', '')
vim.keymap.set('n', '<left>', '')
vim.keymap.set('n', '<right>', '')
vim.keymap.set('i', '<up>', '')
vim.keymap.set('i', '<down>', '')
vim.keymap.set('i', '<left>', '')
vim.keymap.set('i', '<right>', '')


-- center screen on Ctrl+u, Ctrl+d moves
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- center screen on next
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
