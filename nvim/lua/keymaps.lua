local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

-- Disable arrows
map('', '<up>', '', default_opts)
map('', '<down>', '', default_opts)
map('', '<left>', '', default_opts)
map('', '<right>', '', default_opts)

-- Telescope
map('n', '<leader>ff', ':Telescope find_files<CR>', default_opts)
map('n', '<leader>fg', ':Telescope live_grep<CR>', default_opts)
map('n', '<leader>fb', ':Telescope buffers<CR>', default_opts)

-- Bufferline
map('n', ']b', ':BufferLineCycleNext<CR>', default_opts)
map('n', '[b', ':BufferLineCyclePrev<CR>', default_opts)
