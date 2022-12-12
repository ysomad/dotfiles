require('nvim-treesitter.configs').setup {
  ensure_installed = { 'go', 'lua', 'python', 'make', 'yaml', 'sql', 'proto', 'markdown',
    'gomod', 'gowork', 'regex', 'toml' },
  highlight = { enable = true },
}
