# Dotfiles

## Installation

1. Clone repository
```sh
git clone git@github.com:ysomad/dotfiles.git
```

2. Go to dotfiles directory
```sh
cd /path/to/dotfiles
```

3. Install package manager and packages which is not installable with it
```sh
./bootstrap.sh
```

4. Reload terminal session

5. Install symlinks for config files
```sh
./install
```

### MacOS

1. Install packages from Brewfile
```sh
brew bundle && brew doctor && brew cleanup
```

2. Set macOS sensible defaults
```sh
sudo chmod 755 ./.macos
./.macos
```


