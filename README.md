## INSTALL

#### vim
```bash
git clone https://github.com/songww/dotvim ~/.vim
ln -sf ~/.vim/vimrc ~/.vimrc
```

#### neovim
```bash
git clone https://github.com/songww/dotvim ~/.my-vim
mkdir -p ~/.local/share/nvim/site
ln -sf ~/.my-vim/vimrc ~/.config/nvim/init.vim
ln -sf ~/.my-vim/pack ~/.local/share/nvim/site/pack
```
