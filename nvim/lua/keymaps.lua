local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

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

-- telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts)
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)

-- bufferline
map('n', ']b', '<cmd>BufferLineCycleNext<CR>', opts)
map('n', '[b', '<cmd>BufferLineCyclePrev<CR>', opts)
