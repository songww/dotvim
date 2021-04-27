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
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go', { 'tag': '*', 'for': 'go' }

" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim', 'for': 'go' }

"Plug 'junegunn/fzf', { 'dir': '/usr/local/opt/fzf', 'do': './install --all' }
Plug '/usr/local/opt/fzf'

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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true;

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', '<leader>D', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>d', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>t', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<C-[>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>s", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<leader>s", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
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
  capabilities = capabilities;
  on_attach=on_attach,
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
  capabilities = capabilities;
  on_attach=on_attach,
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
          allFeatures = true;
          target = "aarch64-linux-android";
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
        runnables = {
          cargoExtraArgs = { "--release" };
        }
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
  capabilities = capabilities;
  on_attach=on_attach,
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
" Disabling conceal for code fences
let g:vim_markdown_conceal_code_blocks = 0
" This feature allows the ge command to follow named anchors in links of the form file#anchor or just #anchor, where file may omit the .md extension as usual.
"   Two variables control its operation:
let g:vim_markdown_follow_anchor = 1
" Highlight YAML front matter as used by Jekyll or Hugo.
let g:vim_markdown_frontmatter = 1
" Highlight TOML front matter as used by Hugo.
" TOML syntax highlight requires vim-toml.
let g:vim_markdown_toml_frontmatter = 1
" Highlight JSON front matter as used by Hugo.
" JSON syntax highlight requires vim-json.
let g:vim_markdown_json_frontmatter = 1
" vim-markdown automatically insert the indent.
" By default, the number of spaces of indent is 4. If you'd like to change the number as 2, just write:
let g:vim_markdown_new_list_item_indent = 2
