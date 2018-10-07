## INSTALL

#### vim
```bash
git clone https://github.com/songww/dotvim ~/.vim
ln -sf ~/.vim/vimrc ~/.vimrc
cd ~/.vim
git submodules update --init
cd -
```

#### neovim
```bash
git clone https://github.com/songww/dotvim ~/.my-vim
mkdir -p ~/.local/share/nvim/site
ln -sf ~/.my-vim/vimrc ~/.config/nvim/init.vim
ln -sf ~/.my-vim/pack ~/.local/share/nvim/site/pack
cd ~/.my-vim
git submodules update --init
cd -
```

#### powerline fonts
```bash
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://raw.githubusercontent.com/ryanoasis/powerline-extra-symbols/master/PowerlineExtraSymbols.otf
```
