require('nvim-treesitter.configs').setup {
  ensure_installed = { 'lua', 'go', 'bash', 'css', 'gomod', 'gowork', 'html', 'http', 'json',
    'json5', 'make', 'markdown', 'proto', 'regex', 'scss', 'svelte', 'toml', 'typescript',
    'vim', 'yaml', 'python', 'javascript' },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
}
