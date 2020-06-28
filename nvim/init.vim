" {{{ General Settings
lan C                             " Please use the default English
set relativenumber                " Show relative line numbers
set number                        " Show current line number
set nowrap                        " Don't wrap lines
set showbreak=↪                   " But when wrapped, show nice linebreak char
set ignorecase                    " Ignore case in searches
set hlsearch                      " Highlight matches as you type
set bg=dark                       " I work on a console with a dark background
set lazyredraw                    " Don't repaint when scripts are running
set cursorline cursorcolumn       " Highlight the cursor line and column
set guitablabel=%N/\ %t\ %M
set cpoptions=aABceFsI            " Can't remember what these all mean
set listchars=tab:»—,trail:⋅,nbsp:⋄  " Show tabs and trailing characters
set list
set hidden                        " For lusty explorer
set winwidth=80                   " Windows will always be at least 80 chars (if possible)
set foldmethod=indent             " Fold on indentation
set switchbuf=useopen,usetab      " Try to move to other windows if changing buf
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.pyo,*.swp,*/node_modules/*
set wildmode=longest:full,full
set softtabstop=4
set shiftwidth=4
set tabstop=4
set shortmess+=a                  " Use [+] [RO] [w] for modified, read-only, modified
set report=0                      " Notify me whenever any lines have changed
set confirm                       " Y-N-C prompt if closing with unsaved changes
set showcmd                       " Show size of selected area in visual mode
set showmatch                     " Briefly jump to the previous matching paren
set matchtime=2                   " For .2 seconds
set timeoutlen=500                " Lowers leader and command timeout
set directory=~/.config/nvim/tmp  " Directory for swap/temp files
set nobackup                      " Don't create backup files
set nowb                          " Don't create write backups
set noswapfile                    " Don't create swap files
set viminfo+=n$HOME/.config/nvim/tmp/viminfo
set runtimepath+=$HOME/.config/nvim.local
set splitbelow                    " Split windows below the current window
set splitright                    " Split vertical windows on the right
set diffopt=vertical,filler,internal,algorithm:histogram,indent-heuristic
if has('nvim-0.5.0')
  set pumblend=20                 " Transparency for pop-up menu
  set winblend=20                 " Transparency for floating windows
endif
let mapleader = "\<Space>"        " Remap <Leader> to <Space>
match ErrorMsg '\s\+$'            " Highlight trailing space

let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Environment

" Run the following for non-dev users
" echo export NVIM_ENV_FLAGS="nodev" >> ~/.zshrc.local

let g:nvim_env_flags = split($NVIM_ENV_FLAGS)

function! s:flag_is_set(flag)
  return index(g:nvim_env_flags, a:flag) > -1
endfunction

function! s:has_plugin(plugin)
  return index(keys(g:plugs), a:plugin) > -1
endfunction
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Plugins
call plug#begin('~/.config/nvim/plugged')
  " Colors
  " Plug 'sjl/badwolf'
  Plug 'morhetz/gruvbox'

  " Editing enhancement
  Plug 'tpope/vim-sensible'
  Plug 'AndrewRadev/sideways.vim'
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'chrisbra/NrrwRgn'
  Plug 'dhruvasagar/vim-table-mode'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'ervandew/supertab'
  Plug 'hgiesel/vim-motion-sickness'
  Plug 'itchyny/vim-cursorword'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'junegunn/vim-peekaboo'
  Plug 'justinmk/vim-sneak'
  Plug 'Konfekt/FastFold'
  Plug 'liuchengxu/vim-which-key'
  Plug 'majutsushi/tagbar'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'jiangmiao/auto-pairs'
  Plug 'scrooloose/nerdtree'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-dadbod'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'vim-scripts/Smart-Home-Key'
  Plug 'whiteinge/diffconflicts'
  Plug 'xolox/vim-misc'
  Plug 'xolox/vim-session'

  " Git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/gv.vim'
  Plug 'vim-scripts/git-time-lapse'
  " HTTP
  Plug 'vim-scripts/httplog'
  " HTML
  Plug 'vim-scripts/HTML-AutoCloseTag'
  " Markdown
  Plug 'plasticboy/vim-markdown'
  Plug 'walterl/downtools'
  " Sieve
  Plug 'vim-scripts/sieve.vim'
  " SQL
  Plug 'shmup/vim-sql-syntax'

  if !s:flag_is_set('nodev')
    Plug 'honza/vim-snippets'
    Plug 'janko/vim-test'
    Plug 'knsh14/vim-github-link'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'mattn/emmet-vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'SirVer/ultisnips'
    Plug 'w0rp/ale'

    " Clojure
    Plug 'clojure-vim/async-clj-omni'
    Plug 'tpope/vim-fireplace', {'for': 'clojure'}
    Plug 'luochen1990/rainbow'
    Plug 'guns/vim-sexp', {'for': 'clojure'}
    Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': 'clojure'}
    " Go
    Plug 'fatih/vim-go'
    " Jinja
    Plug 'mitsuhiko/vim-jinja'
    " Python
    Plug 'tmhedberg/SimpylFold'
    " Code completion
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
  endif

  " vim-polyglot can misbehave if loaded before language specific plugins
  Plug 'sheerun/vim-polyglot'
call plug#end()
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Color scheme settings
" Settings related to the color scheme
if has('termguicolors')
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799: https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
  "Based on Vim patch 7.4.1770 (`guicolors` option): https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
  " https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
  set termguicolors
endif

let g:gruvbox_italic = 1
colorscheme gruvbox
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Plugin settings
" Settings and mappings related to plug-ins

if s:has_plugin('ale')
  let g:ale_linters = {'clojure': ['clj-kondo']}
  nmap [a :ALEPrevious<CR>
  nmap ]a :ALENext<CR>
endif

if s:has_plugin('coc.nvim')
  nmap <silent> <Leader>od <Plug>(coc-definition)
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> <Leader>or <Plug>(coc-references)
  nmap <silent> <Leader>oR <Plug>(coc-rename)
  nmap <silent> gR <Plug>(coc-rename)

  nmap <silent> <Leader>of :call CocAction('format')<CR>
  xmap <silent> <Leader>of <Plug>(coc-format-selected)
  vmap <silent> <Leader>of <Plug>(coc-format-selected)

  nmap <silent> <Leader>oa <Plug>(coc-codeaction)
  xmap <silent> <Leader>oa <Plug>(coc-codeaction-selected)
  vmap <silent> <Leader>oa <Plug>(coc-codeaction-selected)

  nmap <silent> <Leader>oF <Plug>(coc-fix-current)

  nmap <silent> <Leader>ot <Plug>(coc-range-select)
  nmap <silent> <Leader>oT <Plug>(coc-range-select-backword)

  nmap <silent> ]g :CocNext<CR>
  nmap <silent> [g :CocPrev<CR>
  nmap <silent> <Leader>olr :CocListResume<CR>

  nmap <silent> <Leader>K :call CocAction('doHover')<CR>
  autocmd CursorHold * silent call CocActionAsync('highlight')
endif

if s:has_plugin('rainbow')
  let g:rainbow_active = 1 " Toggle with :RainbowToggle
endif

if s:has_plugin('supertab')
  let g:SuperTabDefaultCompletionType = '<C-n>'
endif

if s:has_plugin('fzf')
  map <silent> ,f :Files<CR>
  map <silent> ,d :Files %:p:h<CR>
  map <silent> ,b :Buffers<CR>
  map <silent> ,t :BTags<CR>
  map <silent> ,T :Tags<CR>
  map <silent> ,s :Snippets<CR>
  map <silent> ,l :BLines<CR>
  map <silent> ,L :Lines<CR>

  map <silent> ,g :GFiles<CR>
  map <silent> ,G :GFiles?<CR>
  map <silent> ,c :Commits<CR>
  map <silent> ,C :BCommits<CR>

  map <silent> ,h :History<CR>
  map <silent> ,: :History :<CR>
  map <silent> ,/ :History /<CR>
endif

if s:has_plugin('editorconfig-vim')
  let g:EditorConfig_exclude_patterns = ['fugitive://.*']
endif

if s:has_plugin('nerdtree')
  map <silent> <F2> :NERDTreeToggle<CR>

  let NERDTreeIgnore=['\~$', '\.exe$', '\.py[co]$', '\.s?o$', '\.sw[op]$']
  let NERDTreeShowBookmarks = 1
endif

if s:has_plugin('tagbar')
  map <silent> <F3> :TagbarToggle<CR>
endif

if s:has_plugin('vim-fugitive')
  nmap <Leader>gb :Gblame<CR>
  nmap <Leader>gd :Gdiff<CR>
  nmap <Leader>gc :Gcommit<CR>
  nmap <Leader>gs :tab Gstatus<CR>
endif

if s:has_plugin('git-time-lapse')
  nmap <Leader>gt :call TimeLapse()<CR>
endif

if s:has_plugin('vim-session')
  let g:session_directory = '~/.local/share/nvim/sessions'
  let g:session_autosave = 'no'
endif

if s:has_plugin('NrrwRgn')
  let g:nrrw_rgn_vert = 1
  let g:nrrw_rgn_wdth = 80
endif

if s:has_plugin('vim-airline')
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#show_splits = 0
  let g:airline#extensions#tabline#show_close_button = 0
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#tab_nr_type = 1
endif

if s:has_plugin('ultisnips')
  let g:UltiSnipsExpandTrigger='<C-]>'
  let g:UltiSnipsJumpForwardTrigger='<C-]>'
  let g:UltiSnipsJumpBackwardTrigger='<C-[>'
endif

if s:has_plugin('sideways.vim')
  nnoremap <Leader>ah :SidewaysLeft<CR>
  nnoremap <Leader>al :SidewaysRight<CR>
endif

if s:has_plugin('SimpylFold')
  " Not sure why, but this keeps vim from stalling at 100% CPU when opening
  " certain Python files.
  let g:SimpylFold_docstring_preview = 1
endif

if s:has_plugin('vim-gitgutter')
  nmap <Leader>gg :GitGutterToggle<CR>
endif

if s:has_plugin('vim-gutentags')
  let g:gutentags_ctags_exclude = ['.git', 'node_modules']
endif

if s:has_plugin('vim-markdown')
  let g:vim_markdown_no_default_key_mappings = 1
  let g:vim_markdown_folding_level = 3
  let g:vim_markdown_follow_anchor = 1
  let g:vim_markdown_strikethrough = 1
  let g:vim_markdown_new_list_item_indent = 2
endif

if s:has_plugin('Smart-Home-Key')
  " Use SmartHomeKey to toggle between ^ and 0
  nmap <silent> 0 :SmartHomeKey<CR>
endif

if s:has_plugin('splitjoin.vim')
  let g:splitjoin_split_mapping = ''
  let g:splitjoin_join_mapping = ''

  nmap <Leader>sj :SplitjoinSplit<CR>
  nmap <Leader>sk :SplitjoinJoin<CR>
endif

if s:has_plugin('vim-which-key')
  if !exists('g:loaded_vim_which_key')
    nnoremap <silent> <Leader> :WhichKey '<Space>'<CR>
  endif
endif

if s:has_plugin('vim-polyglot')
  " RST
  let g:rst_fold_enabled = 1
endif

if s:has_plugin('vim-test')
  nmap <silent> <Leader>Tt :TestNearest<CR>
  nmap <silent> <Leader>TT :TestFile<CR>
  nmap <silent> <Leader>Ta :TestSuite<CR>
  nmap <silent> <Leader>Tl :TestLast<CR>
  nmap <silent> <Leader>Tg :TestVisit<CR>
endif

if s:has_plugin('vim-github-link')
  vmap <Leader>YB :GetCurrentBranchLink<CR>
  vmap <Leader>YC :GetCurrentCommitLink<CR>
endif

" toggle_words.vim
let g:toggle_words_dict = {
  \ 'clojure': [['true?', 'false?']],
  \ 'python': [['assertTrue', 'assertFalse']]
  \}
nmap <silent> <Leader>ff :ToggleWord<CR>
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Mappings
" Center cursor after jumping
nmap g; g;zvzz
nmap g, g,zvzz
nmap n nzvzz
nmap N Nzvzz
nmap * *zvzz

" Since <Leader> is <Space>, we need a mapping to keep c<Space> behaviour
nnoremap c<Leader> c<Space>

" Cut/Copy/Paste shortcuts
vnoremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader><S-p> "+P
vnoremap <Leader>x "+x

" Quick and easy escape from Insert Mode
imap jk <Esc>
vmap <Space>jk <Esc>

" Move to end of yanked/pasted text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Switch windows
nnoremap <C-Left> <C-w>h
nnoremap <C-Right> <C-w>l
nnoremap <C-Up> <C-w>k
nnoremap <C-Down> <C-w>j

" Switch tabs
nnoremap [r gT
nnoremap ]r gt

" Search in visual selection
vnoremap / <Esc>/\%V

" Reselect visual selection after indent
vnoremap < <gv
vnoremap > >gv

" Buffers
nmap <Leader>q :q<CR>
nmap <Leader>w :w<CR>
nmap <Leader>e :w<CR>
nmap <Leader>wq :wq<CR>
nmap <Leader>x :bdelete<CR>
" Switch to previous buffer
nnoremap <Leader>/ :e#<CR>

" Window splitting
nmap <Leader>S :split<CR>
nmap <Leader>V :vsplit<CR>

" Toggle folds
nnoremap <C-f> za

" Change working directory to the current file's directory
" (http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file)
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <Leader>c. :cd ..<CR>:pwd<CR>

" Quickfix and location list
map <silent> <Leader>ll :ll<CR>zvzz
map <silent> <Leader>ls :LocList<CR>zvzz
map <silent> <Leader>cc :cc<CR>zvzz
map <silent> <Leader>cs :QFix<CR>zvzz

" Move up and down by folds
map <silent> <C-j> zj
map <silent> <C-k> zk

" Tag navigation
inoremap <Nul> <C-x><C-o>

" `cc` the line above the current one without leaving insert mode
inoremap <C-k> <C-o>k<C-o>cc
" Ctrl+j moves cursor to the end of the line below, while in insert mode
inoremap <C-j> <C-o>j<C-o>$

" Go to start/end of line with H and L
" From https://github.com/SidOfc/dotfiles/blob/master/.vimrc
noremap H ^
noremap L $

" make Y consistent with C and D
" From https://github.com/SidOfc/dotfiles/blob/master/.vimrc
nnoremap Y y$

" Delete trailing spaces
nmap <silent> <Leader>ds :%s/\s\+$//e<CR>

" Set indentations
nmap <silent> <Leader>in2 :set ts=2 sts=2 sw=2<CR>
nmap <silent> <Leader>in4 :set ts=4 sts=4 sw=4<CR>

nmap <silent> <Leader>fm :set ft=markdown<CR>

" Formatting with external tools
nmap <silent> <Leader>Fh :%!tidy -q -i --show-errors 0 -w 80<CR>
nmap <silent> <Leader>Fj :%!python -m json.tool<CR>
nmap <silent> <Leader>Fs :%!sqlformat --reindent -<CR>
nmap <silent> <Leader>Fx :%!xmllint --format -<CR>

" Select pasted text
" (http://vim.wikia.com/wiki/Selecting_your_pasted_text)
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" grep word under cursor
" (https://github.com/nathanlong/dotfiles/blob/master/vim/vimrc)
nnoremap <Leader>G :grep! "\b(<C-R><C-W>)\b"<CR>:lw<CR>
vnoremap <Leader>G "sy:grep! "\b(<C-R>s)\b"<CR>:lw<CR>

" Expand %% to the current file's directory in commands. This is useful if CWD
" is "far" from the current file's directory.
" (https://github.com/nathanlong/dotfiles/blob/master/vim/vimrc)
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" Use <C-k>/<C-j> to move up/down in command history
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>

" <M-b>/<M-f> to move back/forward a word, in command mode
cnoremap <M-b> <C-Left>
cnoremap <M-f> <C-Right>
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Abbreviations
" Typing aides
iabbrev improt import
iabbrev fucntion function
iabbrev Noen None
iabbrev NOne None
iabbrev sefl self
iabbrev :shrug: ¯\_(ツ)_/¯
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Use ag/ack-grep for the :grep command
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
elseif executable('ack-grep')
  set grepprg=ack-grep\ --nogroup\ --nocolor
endif
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Kill calltip window if we move cursor or leave insert mode
au CursorMovedI * if pumvisible() == 0|pclose|endif
au InsertLeave * if pumvisible() == 0|pclose|endif
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Persist undo
" From http://nathan-long.com/blog/vim-a-few-of-my-favorite-things/
if exists('&undodir')
  set undofile
  let &undodir=&directory
  set undolevels=500
  set undoreload=500
endif
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Remember cursor positions
" From http://nathan-long.com/blog/vim-a-few-of-my-favorite-things/
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
  if &filetype !~ 'svn\|commit\c'
    if line("'\"") > 0 && line ("'\"") <= line('$')
      exe 'normal! g`"'
      normal! zz
    endif
  end
endfunction
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Selection search
" From http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Toggle QuickFix window or location list
" From http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window
command! -bang -nargs=? QFix call QFixToggle(<Bang>0)
function! QFixToggle(forced)
  if exists('g:qfix_win') && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr('$')
  endif
endfunction

command! -bang -nargs=? LocList call LocListToggle(<Bang>0)
function! LocListToggle(forced)
  if exists('g:loclist_win') && a:forced == 0
    lclose
    unlet g:loclist_win
  else
    lopen 10
    let g:loclist_win = bufnr('$')
  endif
endfunction
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Insert copied HTML as Markdown
map <Leader>M :r!xclip -selection clipboard -o -t text/html \| pandoc -f html -t markdown --no-wrap 2> /dev/null<CR>
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim:fdm=marker:sw=2
