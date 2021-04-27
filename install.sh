#!/bin/bash

set -ex

curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [ ! -f $HOME/.vimrc ]; then
    echo source `pwd`"/vimrc" > $HOME/.vimrc
fi
