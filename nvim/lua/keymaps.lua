local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

map('n', '<leader>pv', ':Ex<CR>', opts)
map('n', 'Q', '<nop>', opts)

-- Disable arrows
map('', '<up>', '', opts)
map('', '<down>', '', opts)
map('', '<left>', '', opts)
map('', '<right>', '', opts)

-- Telescope
map('n', '<leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
map('n', '<leader>fb', ':Telescope buffers<CR>', opts)

-- Bufferline
map('n', ']b', ':BufferLineCycleNext<CR>', opts)
map('n', '[b', ':BufferLineCyclePrev<CR>', opts)
