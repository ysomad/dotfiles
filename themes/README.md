# Theme sources

The syntax themes use the official [no-clown-fiesta.nvim palette](https://github.com/no-clown-fiesta/no-clown-fiesta.nvim/blob/04b808e9769ded988089772ffcaf08d92d75d927/lua/no-clown-fiesta/palettes.lua), revision `04b808e9769ded988089772ffcaf08d92d75d927`. Neovim follows `master` in the personal fork. After pushing theme changes, run `:lua vim.pack.update({ "no-clown-fiesta.nvim" })`, confirm the update, and restart Neovim. Fork changes do not automatically regenerate the terminal, bat, delta, or tmux themes here.

The Alacritty light theme matches the community [iTerm2-Color-Schemes light port](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/alacritty/No%20Clown%20Fiesta%20Light.toml), including ANSI slots and selection colors. The official Alacritty repository is a placeholder. The community ANSI mapping is intentionally different from Neovim syntax roles; for example, bright red is gray-blue. Starship and the tmux fzf picker inherit these terminal colors.

`bat/*.tmTheme` maps TextMate scopes to upstream Neovim highlight roles with exact palette values. Bat and delta share these themes. Their syntax grammars differ from Neovim's parsers, so token classification is not guaranteed to be identical. `bin/theme` installs both themes, rebuilds bat's cache (also read by delta), and selects the requested variant.

The tmux and delta themes are local adaptations: no official ports exist. Light tmux uses `medium_gray` for inactive text, `gray_blue` for the active border, and `Visual` gray for selections. Delta uses `DiffAdd`/`DiffDelete` backgrounds, `DiffText` emphasis, and `SignAdd`/`SignDelete` line numbers. Coverage signs link to the same Neovim sign groups and follow colorscheme changes.

`bin/difft-themed` selects Difftastic's light/dark background on each invocation, including in existing shells. Difftastic does not expose a custom palette; its colors cannot exactly reproduce no-clown-fiesta. LazyGit uses delta for diffs. Its UI theme (`themes/lazygit`) is a local adaptation: `Visual` gray for selection, `VisualNOS` for inactive selection, and the tmux border colors. `LG_CONFIG_FILE` in `.zshrc` loads it after `config.yml`.

Run `bin/theme light` or `bin/theme dark` after editing these themes. `install` links LazyGit's config and both theme-switching scripts.
