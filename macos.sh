#!/usr/bin/env bash


# ========= Symlinks ========= #

# Shell
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.zprofile ~/.zprofile

# Git
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

# Tmux
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

# Neovim
ln -s ~/.dotfiles/.config/nvim/init.vim ~/.config/nvim/init.vim
ln -s ~/.dotfiles/.config/nvim/lua/lsp.lua ~/.config/nvim/lua/lsp.lua
ln -s ~/.dotfiles/.config/nvim/lua/plug-colorizer.lua ~/.config/nvim/lua/plug-colorizer.lua

# Alacritty
ln -s ~/.dotfiles/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

# Kitty
ln -s ~/.dotfiles/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf

# Yabai
ln -s ~/.dotfiles/.config/yabai/yabairc ~/.config/yabai/yabairc

# SKHD
ln -s ~/.dotfiles/.config/skhd/skhdrc ~/.config/skhd/skhdrc



