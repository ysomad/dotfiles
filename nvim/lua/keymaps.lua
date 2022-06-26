local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

-- Disable arrows
map('', '<up>', '', default_opts)
map('', '<down>', '', default_opts)
map('', '<left>', '', default_opts)
map('', '<right>', '', default_opts)

-- Telescope
map('n', '<leader>ff', [[ <cmd>Telescope find_files<cr> ]], default_opts)
map('n', '<leader>fg', [[ <cmd>Telescope live_grep<cr> ]], default_opts)
map('n', '<leader>fb', [[ <cmd>Telescope buffers<cr> ]], default_opts)
