# Dotfiles

## Requirements

- homebrew
- kitty
- zsh + oh-my-fish and plugins
- tmux
- neovim + vimplug (plugin manager) + (for unnamedplus clipboard) + fd, rgm, pbcopy
- go + gopls LSP
- pyenv
- jetbrains, fira code fonts
- mpv
- docker
- stats
- copyclip
- insomnia
- vscode
- wireguard
- alfred
- hidden bar
- amphetamine
- macs fan control
- yabai + skhd + spaceid
- google chrome
- spotify
- telegram
- slack
- discord
- tree
- npm/nodejs



# Steps
6. install [neovim](https://github.com/neovim/neovim)
7. install [vim-plug](https://github.com/junegunn/vim-plug)
8. put neovim config files to .config/nvim
9. install [fd](https://github.com/sharkdp/fd), [nodejs](https://github.com/nodejs/node), [xsel](https://archlinux.org/packages/community/x86_64/xsel/)

10. install [go](https://github.com/golang/go)
11. add $GOPATH to $PATH ($GOPATH and $GOROOT installed in fish config)
```sh
fish_add_path $GOPATH/bin
```
12. install [gopls](https://github.com/golang/tools/tree/master/gopls) LSP server
```sh
go install golang.org/x/tools/gopls@latest
```

13. install [tmux](https://github.com/tmux/tmux)
14. put .tmux.conf to $HOME

15. install [jetbrains](https://github.com/JetBrains/JetBrainsMono), [fira code](https://github.com/tonsky/FiraCode) fonts

## TODO
1. bootstrap script to install main dependencies
