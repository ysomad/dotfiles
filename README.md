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

5. [Configure podman to work with docker-compose](https://gist.github.com/kaaquist/dab64aeb52a815b935b11c86202761a3)

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

### tmux
Open tmux session and press `Ctrl+a - I` to install plugins

### keyboard
1. Disable all default shortcuts except for spotlight, screenshots and input sources
2. Set 'Open Spotlight' to `Option+D' shortcut
3. Change CapsLock to Ctrl keymap
