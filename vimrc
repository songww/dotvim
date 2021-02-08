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
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*', 'for': 'go' }

" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim', 'for': 'go' }
Plug 'nsf/gocode', { 'tag': '*', 'for': 'go' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

Plug 'neovim/nvim-lspconfig'

Plug 'dense-analysis/ale'

Plug 'ayu-theme/ayu-vim'

Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'vim-python/python-syntax'

Plug 'vim-airline/vim-airline'

Plug 'vim-airline/vim-airline-themes'

Plug 'airblade/vim-gitgutter'

Plug 'Vimjas/vim-python-pep8-indent'

" completion-nvim is an auto completion framework that aims to provide a better completion experience with neovim's built-in LSP.
Plug 'nvim-lua/completion-nvim'

Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

" Initialize plugin system
call plug#end()

" To map <Esc> to exit terminal-mode:
tnoremap <Esc> <C-\><C-n>

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

augroup resetindent
  autocmd FileType css,html,yaml,xml,json,markdown,javascript,vim setlocal shiftwidth=2 softtabstop=2
augroup END

set helplang=cn

"显示行号：
set number
"为方便复制，用<F2>开启/关闭行号显示:
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

" 忽略搜索大小写
set ignorecase
set smartcase

set modeline

set cursorline
set cursorcolumn

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
" colorscheme solarized8_dark

nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>D    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>k <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1<leader>D   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <leader>r    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> <leader>W    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <leader>d    <cmd>lua vim.lsp.buf.declaration()<CR>

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

lua << EOF
local lspconfig = require 'lspconfig'
local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'

local custom_lsp_attach = function(client)
  -- See `:help nvim_buf_set_keymap()` for more information
  -- vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
  -- vim.api.nvim_buf_set_keymap(0, 'n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true})
  -- ... and other keymappings for LSP

  -- Use LSP as the handler for omnifunc.
  --    See `:help omnifunc` and `:help ins-completion` for more information.
  -- vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- For plugins with an `on_attach` callback, call them here. For example:
  -- require('completion').on_attach(client)
end

-- https://clangd.llvm.org/extensions.html#switch-between-sourceheader
local function switch_source_header(bufnr)
  bufnr = util.validate_bufnr(bufnr)
  local params = { uri = vim.uri_from_bufnr(bufnr) }
  vim.lsp.buf_request(bufnr, 'textDocument/switchSourceHeader', params, function(err, _, result)
    if err then error(tostring(err)) end
    if not result then print ("Corresponding file can’t be determined") return end
    vim.api.nvim_command('edit '..vim.uri_to_fname(result))
  end)
end

local root_pattern = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")

configs.clangd = {
  default_config =  {
    cmd = {"/usr/local/opt/llvm/bin/clangd", "--background-index"};
    filetypes = {"c", "cpp", "objc", "objcpp"};
    root_dir = function(fname)
      local filename = util.path.is_absolute(fname) and fname
        or util.path.join(vim.loop.cwd(), fname)
      return root_pattern(filename) or util.path.dirname(filename)
    end;
    capabilities = {
      textDocument = {
        completion = {
          editsNearCursor = true
        }
      }
    },
  };
  commands = {
    ClangdSwitchSourceHeader = {
      function()
        switch_source_header(0)
      end;
      description = "Switch between source/header";
    };
  };
  docs = {
    description = [[
https://clang.llvm.org/extra/clangd/Installation.html
**NOTE:** Clang >= 9 is recommended! See [this issue for more](https://github.com/neovim/nvim-lsp/issues/23).
clangd relies on a [JSON compilation database](https://clang.llvm.org/docs/JSONCompilationDatabase.html) specified
as compile_commands.json or, for simpler projects, a compile_flags.txt.
For details on how to automatically generate one using CMake look [here](https://cmake.org/cmake/help/latest/variable/CMAKE_EXPORT_COMPILE_COMMANDS.html).
]];
    default_config = {
      root_dir = [[root_pattern("compile_commands.json", "compile_flags.txt", ".git")]];
      on_init = [[function to handle changing offsetEncoding]];
      capabilities = [[default capabilities, with offsetEncoding utf-8]];
    };
  };
}

configs.clangd.switch_source_header = switch_source_header

lspconfig.clangd.setup{
  on_attach=require'completion'.on_attach
}

configs.jedi_language_server = {
  default_config = {
    cmd = {os.getenv("HOME") .. "/.pyenv/versions/neovim-support/bin/jedi-language-server"};
    filetypes = {"python"};
    root_dir = util.root_pattern("pyproject.toml", "poetry.lock", "requirements.txt", ".git");
    settings = {
      jedi = {
        enable = true;
        startupMessage = true;
        markupKindPreferred = { "markdown" };
        jediSettings = {
          autoImportModules = [["numpy"], ["pandas"], ["tensorflow"]];
        };
        executable = {
          disableSnippets = false;
        };
      };
    };
  };
  docs = {
    description = [[
https://github.com/pappasam/jedi-language-server
`jedi-language-server`, a language server for Python, built on top of jedi
    ]];
    default_config = {
      root_dir = "vim's starting directory";
    };
  };
};

lspconfig.jedi_language_server.setup{
  on_attach=require'completion'.on_attach
}

configs.rust_analyzer = {
  default_config = {
    cmd = {"/usr/local/bin/rust-analyzer"};
    filetypes = {"rust"};
    root_dir = util.root_pattern("Cargo.toml", "rust-project.json");
    settings = {
      ["rust-analyzer"] = {
      	assist = {
          importMergeBehaviour = {"last"};
	        importPrefix = {"by_crate"};
        };
	      callInfo = {
          full = true;
        };
    	  cargo = {
          autoreload = true;
        };
    	  completion = {
          addCallArgumentSnippets = true;
    	    addCallParenthesis = true;
    	    postfix = {
            enable = true;
          };
        };
    	  debug = {
          engine = {"auto"};
        };
    	  hoverActions = {
          enable = true;
    	    gotoTypeDef = true;
    	    implementations = true;
        };
    	  inlayHints = {
          chainingHints = true;
    	    enable = true;
    	    parameterHints = true;
    	    typeHints = true;
        };
    	  lens = {
          enable = true;
    	    implementations = true;
    	    methodReferences = true;
        };
    	  notifications = {
          cargoTomlNotFound = true;
        };
	      procMacro = {
          enable = true;
        };
      };
    };
  };
  docs = {
    package_json = "https://raw.fastgit.org/rust-analyzer/rust-analyzer/master/editors/code/package.json";
    description = [[
https://github.com/rust-analyzer/rust-analyzer
rust-analyzer (aka rls 2.0), a language server for Rust
See [docs](https://github.com/rust-analyzer/rust-analyzer/tree/master/docs/user#settings) for extra settings.
    ]];
    default_config = {
      root_dir = [[root_pattern("Cargo.toml", "rust-project.json")]];
    };
  };
};

lspconfig.rust_analyzer.setup{
  on_attach=require'completion'.on_attach
}

-- vim:et ts=2 sw=2
EOF

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
let g:airline#extensions#tabline#enabled = 1
" AirlineTheme solarized
" let g:airline_solarized_bg='dark'
let g:airline_theme = 'papercolor'
let g:airline_powerline_fonts = 1

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

augroup backtolastposition
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
