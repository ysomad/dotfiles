require('nvim-treesitter.configs').setup {
  ensure_installed = { 'vimdoc', 'vim', 'go', 'lua', 'python', 'sql', 'javascript', 'typescript' },
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
