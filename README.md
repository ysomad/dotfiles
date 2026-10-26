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
./.macos
```

5. [Configure podman to work with docker-compose](https://gist.github.com/kaaquist/dab64aeb52a815b935b11c86202761a3)

## Specific configuration

### tmux
Open tmux session and press `Ctrl+a - I` to install plugins

### keyboard
1. Disable all default shortcuts except for spotlight, screenshots and input sources
2. Set 'Open Spotlight' to `Option+D' shortcut


### gigapwd backups
`bin/pull-gigapwd` pulls encrypted backups from the gigapwd server daily at 04:00 and at login (missed runs fire on wake). Needs `brew install rsync` and a `gigapwd-backup` host in `~/.ssh/config` (setup in the gigacloud repo README, "Pull").
```sh
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/xyz.ysomad.pull-gigapwd.plist
launchctl kickstart -k gui/$(id -u)/xyz.ysomad.pull-gigapwd   # run now
tail ~/Library/Logs/pull-gigapwd.log
```
