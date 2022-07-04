require('bufferline').setup {
  options = {
    mode = 'buffers',
    numbers = 'none',
    max_name_length = 32,
    max_prefix_length = 15,
    modified_icon = '*',
    tab_size = 0,
    color_icons = false,
    show_buffer_icons = false,
    show_buffer_close_icons = false,
    show_buffer_default_icon = false,
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = 'thin',
    sort_by = 'insert_after_current',
  }
}