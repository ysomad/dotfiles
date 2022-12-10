# Dotfiles

![img](screenshots/magenta_tree.png)

## Install configuration and package manager

1. Clone repository
```sh
git clone git@github.com:ysomad/dotfiles.git
```

2. Go to dotfiles directory
```sh
cd /path/to/dotfiles
```

3. Install symlinks for config files
```sh
./install
```

4. Install package manager and packages which is not installable via package manager
```sh
./bootstrap
```

## macos

1. Install packages from Brewfile
```sh
brew bundle
```

2. Set macos sensible defaults
```sh
./.macos
```

### yabai
1. Start skhd service
```sh
brew services start skhd
```
2. [Disable system integrity protection](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection)
3. Start yabai service
```sh
brew services start yabai
```

## neovim

1. Install Gopls server (cannot be installed in bootstrap since `Go` is dependency in `Brewfile`)
```sh
go install golang.org/x/tools/gopls@latest
```

2. Install bufls server for protobuf definitions
```sh
go install github.com/bufbuild/buf-language-server/cmd/bufls@latest
```

2. Open nvim and run `:PackerInstall` to install plugins
3. Compile packer `:PackerCompile`

## vscode
- Install extensions, run:
```sh
./vscode-extensions-install
```

## tmux
- Open tmux session and press `Ctrl-a + I` to install tmux plugins

## TODO

### neovim
- fix packer setup (like in primeagen dots)
- use mason for managing lsp servers
- use https://github.com/ray-x/go.nvim instead of gopher
- fix colorschema
- Configure Git integration
- Configure Go test integrations ('nvim-neotest/neotest', 'nvim-neotest/neotest-go')
