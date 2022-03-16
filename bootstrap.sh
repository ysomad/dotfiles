#!/usr/bin/env bash

bootstrap_macos () {
    # Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Oh-my-zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # install all from brew
    brew bundle

    # symlink config files
    ./install

    # Vim-plug
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    # gopls
    go install golang.org/x/tools/gopls@latest
}

if [[ "$OSTYPE" == "darwin"* ]]; then
    bootstrap_macos
fi
