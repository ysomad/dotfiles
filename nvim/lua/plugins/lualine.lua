require('lualine').setup {
  options = {
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
    lualine_a = { 'filename' },
    lualine_b = { 'branch' },
    lualine_c = {},
    lualine_x = { 'diff', { 'diagnostics', sources = { 'nvim_diagnostic' } } },
    lualine_y = { 'encoding' } ,
    lualine_z = {},
  },
}
