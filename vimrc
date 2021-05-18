scriptencoding 'utf-8'

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips'

Plug 'honza/vim-snippets'

Plug 'norcalli/snippets.nvim'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug '/usr/local/opt/fzf'

Plug 'dense-analysis/ale'

Plug 'ayu-theme/ayu-vim'

Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'vim-python/python-syntax'

Plug 'vim-airline/vim-airline'

Plug 'vim-airline/vim-airline-themes'

Plug 'airblade/vim-gitgutter'

Plug 'Vimjas/vim-python-pep8-indent'

Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

Plug 'skywind3000/Leaderf-snippet'

Plug 'sheerun/vim-polyglot'

Plug 'tpope/vim-commentary'

Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'elzr/vim-json'
Plug 'cespare/vim-toml'

Plug 'easymotion/vim-easymotion'

Plug 'vim-test/vim-test'

Plug 'jiangmiao/auto-pairs'

Plug 'octol/vim-cpp-enhanced-highlight'

Plug 'wellle/targets.vim'

Plug 'jparise/vim-graphql'

Plug 'godlygeek/tabular'

Plug 'plasticboy/vim-markdown'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end()

" To map <Esc> to exit terminal-mode:
tnoremap <Esc> <C-\><C-n>

set expandtab
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4

augroup resetindent
  autocmd FileType css,html,yaml,xml,json,markdown,javascript,vim setlocal shiftwidth=2 softtabstop=2
augroup END

set helplang=cn

"显示行号：
set number
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" TextEdit might fail if hidden is not set.
set hidden

set wildmenu
" Give more space for displaying messages.
set cmdheight=2
set laststatus=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

"为方便复制，用<F2>开启/关闭行号显示:
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

" 忽略搜索大小写
set hlsearch
set smartcase
set ignorecase
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

set ruler
set modeline
set cursorline
set cursorcolumn

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

if &tabpagemax < 50
  set tabpagemax=50
endif

set sessionoptions-=options
set viewoptions-=options

set autoread

setlocal textwidth=119
setlocal colorcolumn=+1

"""" leader
let mapleader = ';'

set t_Co=256

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors     " enable true colors support
set background=dark
" let ayucolor="light"  " for light version of theme
let ayucolor='mirage' " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
colorscheme ayu

autocmd FileType python,rust,c,cpp setlocal omnifunc=v:lua.vim.lsp.omnifunc

" Avoid showing message extra message when using completion
set shortmess+=c
set completeopt=menuone,preview,noinsert

let g:completion_trigger_keyword_length = 3
let g:completion_trigger_on_delete = 1
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_timer_cycle = 200  " default value is 80

" possible value: "length", "alphabet", "none"
let g:completion_sorting = "none"

let g:completion_matching_smart_case = 1

let g:python3_host_prog = $HOME . "/.pyenv/versions/neovim-support/bin/python3"

let g:ale_enabled = 1
let g:ale_linters = {
\   'python': ['flake8', 'black'],
\}
let g:ale_open_list = 1
let g:ale_fix_on_save = 1
let g:ale_list_window_size = 5
let g:ale_sign_column_always = 1

let g:ale_fixers = {
\   'python': ['add_blank_lines_for_python_control_statements', 'autoimport', 'autopep8', 'black', 'isort'],
\   'rust': ['rustfmt'],
\   'c': ['clangtidy', 'clang-format'],
\   'cpp': ['clangtidy', 'clang-format'],
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}

let g:ale_python_black_executable = $HOME . '/.pyenv/versions/neovim-support/bin/black'
let g:ale_python_black_options = ' -l 119 --skip-string-normalization --skip-numeric-underscore-normalization'
let g:ale_python_flake8_executable = $HOME . '/.pyenv/versions/neovim-support/bin/flake8'
let g:ale_python_flake8_options = ' --max-line-length 119'
let g:ale_python_autopep8_executable = $HOME . '/.pyenv/versions/neovim-support/bin/autopep8'
let g:ale_python_autopep8_options = ' --max-line-length 119'

let g:ale_c_clangd_executable = '/usr/local/opt/llvm/bin/clangd'
let g:ale_c_clangtidy_executable = '/usr/local/opt/llvm/bin/clang-tidy'
let g:ale_c_clangformat_executable = '/usr/local/opt/llvm/bin/clang-format'

let g:ale_cpp_clangd_executable = '/usr/local/opt/llvm/bin/clangd'
let g:ale_cpp_clangtidy_executable = '/usr/local/opt/llvm/bin/clang-tidy'
let g:ale_cpp_clangformat_executable = '/usr/local/opt/llvm/bin/clang-format'

let g:ale_disable_lsp = 1
let g:ale_completion_enabled = 0

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#enabled = 1
" AirlineTheme solarized
" let g:airline_solarized_bg='dark'
let g:airline_theme = 'papercolor'
let g:airline_powerline_fonts = 1

""""""""""""""""""""""""""""""""""""""
" auto-pairs
""""""""""""""""""""""""""""""""""""""
" Toggle Autopairs
let g:AutoPairsShortcutToggle = '<leader>ap'
" Fast Wrap
let g:AutoPairsShortcutFastWrap = '<C-e>'
" Jump to next closed pair
let g:AutoPairsShortcutJump = '<C-n>'
" BackInsert
let g:AutoPairsShortcutBackInsert = '<leader>b'

" if press < after a word will generate the pair
au FileType rust let b:AutoPairs = AutoPairsDefine({'\w\zs<': '>'})
" the 'begin' 'end' pair write in
" au FileType ruby let b:AutoPairs = AutoPairsDefine({'\v(^|\W)\zsbegin': 'end//n'})

""""""""""""""""""""""""""""""""""""""
" python syntax
"""""""""""""""""""""""""""""""""""""
" Highlight all by default
let g:python_highlight_all = 1

"""""""""""""""""""""""""""""
" UltiSnips
"""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger = '<leader>ex'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsUsePythonVersion = 3

let g:ultisnips_python_style = 'google'

" enable popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1

" maps
inoremap <c-x><c-j> <c-\><c-o>:Leaderf snippet<cr>
" optional: preview
let g:Lf_PreviewResult = get(g:, 'Lf_PreviewResult', {})
let g:Lf_PreviewResult.snippet = 1

augroup backtolastposition
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

map <Leader>m <Plug>(easymotion-prefix)

nmap <silent> <Leader>tn :TestNearest<CR>
nmap <silent> <Leader>tf :TestFile<CR>
nmap <silent> <Leader>ts :TestSuite<CR>
nmap <silent> <Leader>tl :TestLast<CR>
nmap <silent> <Leader>tg :TestVisit<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown
""""""""""""""""""""""""""""""""""""""""""""""""""
" https://github.com/plasticboy/vim-markdown#mappings
" To fold in a style like python-mode
let g:vim_markdown_folding_style_pythonic = 1
" Allow for the TOC window to auto-fit when it's possible for it to shrink. It never increases its default size (half screen)
let g:vim_markdown_toc_autofit = 1
" Concealing is set for some syntax.
" For example, conceal [link text](link url) as just link text. Also, _italic_ and *italic* will conceal to just italic.
"   Similarly __bold__, **bold**, ___italic bold___, and ***italic bold*** will conceal to just bold, bold, italic bold, and italic bold respectively.
set conceallevel=2

""""""""""""""""""""""""""""""""""""""""""""""""""
" Coc
""""""""""""""""""""""""""""""""""""""""""""""""""

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <leader><space> coc#refresh()
else
  inoremap <silent><expr> <leader><@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)
