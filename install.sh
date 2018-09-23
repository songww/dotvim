#!/bin/bash

apt install git

ln -sf vimrc ~/.vimrc

git submodule init --recursive
git submodule sync --recursive
