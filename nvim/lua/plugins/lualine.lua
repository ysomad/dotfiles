require('lualine').setup {
  options = {
    icons_enabled = false,
    globalstatus = true,
    component_separators = { left = '', right = '┃' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      'NvimTree',
      'TelescopePrompt',
      'NeogitStatus',
      'packer',
    },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diagnostics' },
    lualine_c = { '' },
    lualine_x = { 'diff', 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' } ,
    lualine_z = { 'location' },
  },
}
