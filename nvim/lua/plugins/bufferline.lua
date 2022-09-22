require('bufferline').setup {
  options = {
    mode = 'buffers',
    numbers = 'id',
    max_name_length = 32,
    max_prefix_length = 15,
    tab_size = 0,
    color_icons = false,
    show_buffer_icons = false,
    show_buffer_close_icons = false,
    show_buffer_default_icon = false,
    show_close_icon = false,
    separator_style = 'thin',
    sort_by = 'insert_after_current',
  }
}

local map = vim.api.nvim_set_keymap
local opts = {noremap = true}

map('n', ']b', '<cmd>BufferLineCycleNext<CR>', opts)
map('n', '[b', '<cmd>BufferLineCyclePrev<CR>', opts)
