#!/bin/bash

set -ex

curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [ ! -f $HOME/.vimrc ]; then
    echo source `pwd`"/vimrc" > $HOME/.vimrc
fi

if [ ! -d $HOME/.vim ]; then
    rm -r $HOME/.vim
fi

ln -sf `pwd`/vim $HOME/.vim

vim -c 'PlugInstall|q'
vim -c 'CocInstall -sync coc-json coc-html coc-pyright coc-cmake coc-emmet coc-flutter coc-graphql coc-snippets coc-sql coc-tasks coc-yaml coc-toml|q'

pip3 install -U pip wheel
pip3 install keyring browser-cookie3
