#!/usr/bin/env bash

bootstrap_macos () {
    # command line tools
    xcode-select --install

    # homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    brew bundle
    brew cleanup

    # symlink config files
    ./install

    # oh-my-zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # vim-plug
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    # gopls lsp server
    go install golang.org/x/tools/gopls@latest
}

if [[ "$OSTYPE" == "darwin"* ]]; then
    bootstrap_macos
fi
