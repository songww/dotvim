syntax on
filetype plugin indent on

""""""
set ts=4
set sw=4
set expandtab
set softtabstop=4

autocmd FileType python setlocal et sta sw=4 sts=4
autocmd FileType css,html,yaml,xml,json setlocal et sta sw=2 sts=2
autocmd FileType markdown,javascript setlocal et sta sw=2 sts=2

" Jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

set helplang=cn
set encoding=utf-8

""""""
"显示当前的行号列号：
set ruler
"在状态栏显示正在输入的命令
set showcmd
""""""""""

set mouse=
" 禁止光标闪烁
" set gcr=a:blinkon0-ver01
set guicursor=i-c-n:blinkon0-ver01
" 禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=m
set guioptions-=T

set cursorline
set cursorcolumn
set laststatus=2

setlocal textwidth=119
setlocal colorcolumn=+1

set clipboard=unnamed
set clipboard+=unnamedplus

"显示行号：
set number
"为方便复制，用<F2>开启/关闭行号显示:
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

set modeline

set fillchars+=stl:\ ,stlnc:\

" 搜索忽略大小写
set ignorecase
" 搜索逐字符高亮
set hlsearch
set incsearch

" 高亮显示匹配的括号
set showmatch

"""" leader
let mapleader = ";"

"""" NERDTree
map <leader>n :NERDTreeToggle<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif  "" 如果没有带文件或目录
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif   """ 如果打开的是目录

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
"""""""""""""""""""""""""""""""""""

set t_Co=256

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors     " enable true colors support
set background=dark
" let ayucolor="light"  " for light version of theme
let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
colorscheme ayu
" colorscheme solarized8_dark

""""""""""""""""""""""""""""""
" python3 binding
""""""""""""""""""""""""""""""
let $MYPYPATH .= "."

if !has($NVIM)
    let g:python_host_prog = "/Users/songww/.pyenv/versions/2.7.15/envs/py2devel/bin/python"
    let g:python3_host_prog = "/Users/songww/.pyenv/versions/3.7.0/envs/py3devel/bin/python"
else
    let g:python_host_prog = "python2"
    let g:python3_host_prog = "python3"
endif

if !empty($VIRTUAL_ENV)
    py import vim, commands
    py ver = commands.getoutput("$VIRTUAL_ENV/bin/python --version").split()[1]
    py major, minor = ver.split('.')[:2]
    py vim.command("let $MYPYPATH .= $VIRTUAL_ENV . \"/lib/python{major}.{minor}/site-packages:\"".format(major=major, minor=minor))
endif

let g:ale_enabled = 1
let g:ale_linters = {
\   'python': ['flake8', 'black'],
\   'javascript': ['eslint']
\}
let g:ale_open_list = 1
let g:ale_list_window_size = 5
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1

let g:ale_javascript_eslint_use_global = 1

let g:ale_fixers = {
\   'python': ['autopep8', 'black', 'isort']
\}

let g:ale_python_black_options = ' -l 119'
let g:ale_python_flake8_options = ' --max-line-length 119 --mypy-config mypy.ini'
let g:ale_python_autopep8_path = 'python -m autopep8'
let g:ale_python_autopep8_options = ' --max-line-length 119'

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" DESC: Remove unused whitespaces
fun! Trim_whitespaces() "{{{
    let cursor_pos = getpos('.')
    silent! %s/\s\+$//
    call setpos('.', cursor_pos)
endfunction "}}}

au BufWritePre <buffer> call Trim_whitespaces()

let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
" AirlineTheme solarized
" let g:airline_solarized_bg='dark'
let g:airline_theme="papercolor"
let g:airline_powerline_fonts = 1

""""""""""""""""""""""""""""""""""""""
" python syntax
" """"""""""""""""""""""""""""""""""""
" Highlight all by default
let g:python_highlight_all = 1

""""""""""""""""""""""""""""""
" jedi
""""""""""""""""""""""""""""""
let g:jedi#auto_initialization = 1
let g:jedi#auto_vim_configuration = 1
let g:jedi#completions_enabled = 1

let g:jedi#completions_command = "<C-x>"
let g:jedi#use_splits_not_buffers = "bottom"
" let g:jedi#force_py_version = '3'

""""""""""""""""""""""""""""""
" vim gitgutter
""""""""""""""""""""""""""""""
" jump to next hunk (change)
" nmap ]c <Plug>GitGutterNextHunk
" jump to previous hunk
" nmap [c <Plug>GitGutterPrevHunk
" stage the hunk
" nmap <Leader>hs <Plug>GitGutterStageHunk
" undo it
" nmap <Leader>hu <Plug>GitGutterUndoHunk
" preview a hunk's changes
" nmap <Leader>hp <Plug>GitGutterPreviewHunk

""""""""""""""""""""""""""""""
" run code
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" jsbeautify
""""""""""""""""""""""""""""""
autocmd FileType javascript noremap <buffer>  <leader>ff :call JsBeautify()<cr>
autocmd FileType json noremap <buffer>  <leader>ff :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer>  <leader>ff :call JsxBeautify()<cr>
autocmd FileType css noremap <buffer>  <leader>ff :call CSSBeautify()<cr>
autocmd FileType html noremap <buffer>  <leader>ff :call HtmlBeautify()<cr>


autocmd FileType javascript vnoremap <buffer>  <leader>ff :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <leader>ff :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <leader>ff :call RangeJsxBeautify()<cr>
autocmd FileType css vnoremap <buffer> <leader>ff :call RangeCSSBeautify()<cr>
autocmd FileType html vnoremap <buffer> <leader>ff :call RangeHtmlBeautify()<cr>
""""""""""""""""""""""""""""""""""""""
" deoplete
""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1

let g:deoplete#sources#jedi#show_docstring = 1

"""""""""""""""""""""""""""""
" UltiSnips
"""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<leader>ex"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

let g:UltiSnipsUsePythonVersion = 3

let g:ultisnips_python_style = "google"

"""""""""""""""""""""""""""""
" nvim-ipy
"""""""""""""""""""""""""""""
map <silent> <leader>rl <Plug>(IPy-Run)
map <silent> <leader>rc <Plug>(IPy-Run)

"""""""""""""""""""""""""""""
" yapf
"""""""""""""""""""""""""""""
autocmd FileType json map <leader>ff :%!python -m json.tool
" autocmd FileType python map <leader>ff :call yapf#YAPF()<CR>
" map <leader>ff :call yapf#YAPF()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto disable fcitx
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:input_toggle = 1
function! ToggleFcitxDisabled()
    let s:input_status = system("fcitx-remote")
    if s:input_status == 2
        let g:input_toggle = 1
        let l:a = system("fcitx-remote -c")
    endif
endfunc

set ttimeoutlen=150
autocmd InsertLeave * call ToggleFcitxDisabled()

"""""""""""""""""""""""""""""""""""""""""""""""""""
"
"""""""""""""""""""""""""""""""""""""""""""""""""""
if !empty($NVIM)
    set pyxversion=3
endif
set encoding=utf-8


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Put these lines at the very end of your vimrc file.

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
