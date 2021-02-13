#!/bin/bash

set -ex

mkdir -p ~/.config/nvim

curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [ ! -f ~/.config/nvim/init.vim ]; then
    echo source `pwd`"/vimrc" > ~/.config/nvim/init.vim
fi
