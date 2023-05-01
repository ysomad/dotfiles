# Dotfiles

## Install packages and configs

1. Install symlinks
```sh
./install
```

2. Install brew and other packages which is not installable with it
```sh
./bootstrap
```

3. Install packages from Brewfile
```sh
brew bundle
```

4. Set macos sensible defaults
```sh
./macos
```

## Specific configuration

### yabai
1. [Disable system integrity protection](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection)

2. [Configure scripting addition](https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(from-HEAD)#configure-scripting-addition)

3. Start skhd service
```sh
skhd --start-service
```

4. Start yabai service
```sh
yabai --start-service
```

### neovim
Open nvim and run `:PackerInstall` to install plugins

### vscode
To Install extensions, run:
```sh
./vscode-extensions-install
```

### tmux
Open tmux and press `Ctrl-a + I` to install tmux plugins

## TODO

### macos
Keyboard:
- disable "Adjust keyboard brightness in low light"
- unbind cmd+q (bind cmd+q to Zoom > Turn focus following on or off)
- unbind all default keyboard shortcuts except screenshots, input sources and spotlight
- bind spotlight to alt-d

Dock & Menu Bar:
- enable "Show battery percentage"

Sound:
- disable "play sound on startup"
- show sound in menu bar - "always"
