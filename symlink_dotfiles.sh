#!/bin/bash

DOTFILES_DIR=~/Documents/repos/dotfiles

if [ -n "ZSH_VERSION" ]; then
  ln -sf $DOTFILES_DIR/bashrc ~/.zshrc
elif [ -n "BASH_VERSION" ]; then
  ln -sf $DOTFILES_DIR/bashrc ~/.bashrc
fi
 
ln -sf $DOTFILES_DIR/vim/vimrc ~/.vimrc
ln -sf $DOTFILES_DIR/tmux.conf ~/.tmux.conf
