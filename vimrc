" Basic Settings
lan C                             " Please use the default English
set modeline                      " Use mode lines in files (see :help modeline)
set relativenumber                " Show relative line numbers
set nowrap                        " Don't wrap lines
set ignorecase                    " Ignore case in searches
set incsearch                     " Incremental search
set hlsearch                      " Highlight matches as you type
set bg=dark                       " I work on a console with a dark background
set lazyredraw                    " Don't repaint when scripts are running
set scrolloff=3                   " Keep 3 lines below and above the cursor
set ruler                         " Line numbers and column the cursor is on
set wildmenu                      " Show possibilities when pressing Tab in command mode
set cursorline                    " Highlight the cursor line
set guitablabel=%N/\ %t\ %M
set cpoptions=aABceFsI            " Can't remember what these all mean
set listchars=tab:>-,trail:_ list " Show tabs and trailing characters
set hidden                        " For lusty explorer
set autochdir                     " Automatically change to the current file's directory
set winwidth=80                   " Windows will always be at least 80 chars (if possible)
set foldmethod=indent             " Fold on indentation
set complete-=i                   " from :help cpt: i: scan current and included files. It's very slow in Windows :(
set switchbuf=useopen,usetab      " Try to move to other windows if changing buf
set encoding=utf-8
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.pyo,*.swp
" Tab handling
set smarttab
set softtabstop=4
set shiftwidth=4
set tabstop=4
" Messages, Info, Status
set shortmess+=a                  " Use [+] [RO] [w] for modified, read-only, modified
set laststatus=2                  " Always show statusline, even if only 1 window
set report=0                      " Notify me whenever any lines have changed
set confirm                       " Y-N-C prompt if closing with unsaved changes
set showcmd                       " Show size of selected area in visual mode
" Editing
set backspace=2                   " Backspace over anything! (Super backspace!)
set showmatch                     " Briefly jump to the previous matching paren
set matchtime=2                   " For .2 seconds

let mapleader = "\<Space>"        " Remap <Leader> to <Space>

if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
elseif executable("ack-grep")
    set grepprg=ack-grep\ --nogroup\ --nocolor
endif

syntax on                         " Enable syntax highlighting
filetype plugin indent on

call plug#begin('~/.vim/plugged')
    " Colors
    Plug 'sjl/badwolf'
    Plug 'junegunn/seoul256.vim'

    " Editing enhancement
    Plug 'AndrewRadev/sideways.vim'
    Plug 'chrisbra/NrrwRgn'
    Plug 'edsono/vim-dbext'
    Plug 'edsono/vim-matchit'
    Plug 'godlygeek/tabular'
    Plug 'honza/vim-snippets'
    Plug 'itchyny/vim-cursorword'
    Plug 'junegunn/vim-easy-align'
    Plug 'justinmk/vim-sneak'
    Plug 'kien/ctrlp.vim'
    Plug 'Konfekt/FastFold'
    Plug 'majutsushi/tagbar'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'Raimondi/delimitMate'
    Plug 'scrooloose/nerdtree'
    Plug 'scrooloose/syntastic'
    Plug 'SirVer/ultisnips'
    Plug 'terryma/vim-expand-region'
    Plug 'tomtom/tcomment_vim'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-sleuth'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-vinegar'
    Plug 'Valloric/YouCompleteMe', {'do': './install.sh --clang-completer'}
    Plug 'vim-scripts/diffchar.vim'
    Plug 'vim-scripts/showmarks--Politz'
    Plug 'vim-scripts/Smart-Home-Key'
    Plug 'vim-scripts/vimwiki'
    Plug 'walterl/vim-airline'
    Plug 'wellle/targets.vim'
    Plug 'xolox/vim-misc'
    Plug 'xolox/vim-session'

    " CoffeeScript
    Plug 'kchmck/vim-coffee-script'
    " CSS
    Plug 'ap/vim-css-color'
    Plug 'vim-scripts/Better-CSS-Syntax-for-Vim'
    " Dockerfile
    Plug 'ekalinin/Dockerfile.vim'
    " ferm - for Easy (iptables) Rule Making
    Plug 'cometsong/ferm.vim'
    " Git
    Plug 'gregsexton/gitv'
    Plug 'mattn/gist-vim'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-scripts/git-time-lapse'
    " Golang
    Plug 'jnwhiteh/vim-golang'
    " HTML
    Plug 'vim-scripts/HTML-AutoCloseTag'
    " JavaScript
    Plug 'pangloss/vim-javascript'
    " Jinja
    Plug 'mitsuhiko/vim-jinja'
    " LaTex
    Plug 'LaTeX-Box-Team/LaTeX-Box'
    " Mako
    Plug 'sophacles/vim-bundle-mako'
    " Markdown
    Plug 'tpope/vim-markdown'
    " nginx
    Plug 'vim-scripts/nginx.vim'
    " Python
    Plug 'ivanov/vim-ipython'
    Plug 'rkulla/pydiction'
    Plug 'vim-scripts/python.vim--Vasiliev'
    Plug 'vim-scripts/pythoncomplete'
    " reStructuredText
    Plug 'Rykka/riv.vim'
    " Sieve
    Plug 'vim-scripts/sieve.vim'
    " SQL
    Plug 'shmup/vim-sql-syntax'
call plug#end()

colorscheme badwolf

if filereadable(expand("$HOME") . "/.vimrc.local")
    source $HOME/.vimrc.local
endif
