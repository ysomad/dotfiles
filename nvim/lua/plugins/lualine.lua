require('lualine').setup {
  options = {
    icons_enabled = false,
    globalstatus = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      'NvimTree',
      'TelescopePrompt',
      'NeogitStatus',
      'packer',
    },
  },
  sections = {
    lualine_a = { 'branch' },
    lualine_b = { 'filename' },
    lualine_c = { 'diagnostics' },
    lualine_x = {},
    lualine_y = { 'diff' } ,
    lualine_z = { 'encoding' },
  },
}

