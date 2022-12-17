-- greates remaps ever (yoinked from primeagen)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- yank into +y buffer
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set('n', 'Q', '<nop>')

-- better indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- disable arrows
vim.keymap.set({ 'n', 'i' }, '<up>', '')
vim.keymap.set({ 'n', 'i' }, '<down>', '')
vim.keymap.set({ 'n', 'i' }, '<left>', '')
vim.keymap.set({ 'n', 'i' }, '<right>', '')

-- center screen on Ctrl+u, Ctrl+d moves
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- center screen on next
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- rename in current buffer
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
