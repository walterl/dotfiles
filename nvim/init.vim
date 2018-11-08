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
set directory=~/.vim/tmp          " Directory for swap/temp files
set nobackup                      " Don't create backup files
set nowb                          " Don't create write backups
set noswapfile                    " Don't create swap files
set viminfo+=n$HOME/.config/nvim/tmp/viminfo
set splitbelow                    " Split windows below the current window
set splitright                    " Split vertical windows on the right
let mapleader = "\<Space>"        " Remap <Leader> to <Space>
match ErrorMsg '\s\+$'            " Highlight trailing space
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Plugins
call plug#begin('~/.config/nvim/plugged')
  " Colors
  Plug 'morhetz/gruvbox'

  " Editing enhancement
  Plug 'tpope/vim-sensible'
  Plug 'AndrewRadev/sideways.vim'
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'b4winckler/vim-angry'
  Plug 'chrisbra/NrrwRgn'
  Plug 'dhruvasagar/vim-table-mode'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'ervandew/supertab'
  Plug 'honza/vim-snippets'
  Plug 'itchyny/vim-cursorword'
  Plug 'junegunn/vim-easy-align'
  Plug 'justinmk/vim-sneak'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-line'
  Plug 'Konfekt/FastFold'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'majutsushi/tagbar'
  Plug 'mattn/emmet-vim'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'jiangmiao/auto-pairs'
  Plug 'rickhowe/diffchar.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'sheerun/vim-polyglot'
  Plug 'SirVer/ultisnips'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-dadbod'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-scripts/Smart-Home-Key'
  Plug 'vimwiki/vimwiki'
  Plug 'whiteinge/diffconflicts'
  Plug 'xolox/vim-misc'
  Plug 'xolox/vim-session'

  " CtrlP
  Plug 'kien/ctrlp.vim'
  Plug 'FelikZ/ctrlp-py-matcher'
  Plug 'ivalkeen/vim-ctrlp-tjump'
  Plug 'jasoncodes/ctrlp-modified.vim'

  " Clojure
  Plug 'tpope/vim-fireplace', {'for': 'clojure'}
  Plug 'kien/rainbow_parentheses.vim'
  Plug 'kovisoft/paredit', {'for': 'clojure'}
  " Git
  Plug 'airblade/vim-gitgutter'
  Plug 'mattn/gist-vim'
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/gv.vim'
  Plug 'vim-scripts/git-time-lapse'
  " HTML
  Plug 'vim-scripts/HTML-AutoCloseTag'
  " Jinja
  Plug 'mitsuhiko/vim-jinja'
  " Python
  Plug 'klen/python-mode'
  " reStructuredText
  Plug 'Rykka/riv.vim'
  " Sieve
  Plug 'vim-scripts/sieve.vim'
  " SQL
  Plug 'shmup/vim-sql-syntax'

  " Code completion
  Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
  Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
call plug#end()
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Plugin settings
" Settings and mappings related to plug-ins

colorscheme gruvbox

" LanguageClient-neovim
let g:LanguageClient_serverCommands = {
      \'go': ['go-langserver'],
      \'javascript': ['javascript-typescript-stdio'],
      \'javascript.jsx': ['tcp://127.0.0.1:2089'],
      \'python': ['pyls'],
      \}
let g:LanguageClient_rootMarkers = {
      \'javascript': ['package.json'],
      \'javascript.jsx': ['package.json'],
      \'python': ['setup.py'],
      \'*': ['.git', '.hg', '.svn'],
      \}

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gca :call LanguageClient#textDocument_codeAction()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> gR :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> gs :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <silent> gS :call LanguageClient#workspace_symbol()<CR>

" Deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy', 'matcher_length'])

" SuperTab
let g:SuperTabDefaultCompletionType = "<c-n>"

" CtrlP
let g:ctrlp_map = ",f"
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:50'
map <silent> ,g :CtrlP %:p:h<CR>
map <silent> ,b :CtrlPBuffer<CR>
map <silent> ,m :CtrlPMixed<CR>
map <silent> ,t :CtrlPBufTagAll<CR>
map <silent> ,o :CtrlPModified<CR>
map <silent> ,O :CtrlPBranch<CR>
map <silent> ,j :CtrlPtjump<CR>
vmap <silent> ,j :CtrlPtjumpVisual<CR>
if executable("ag")
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif
" Above from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/

" EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" NERDTree
map  <silent> <F2>      :NERDTreeToggle<CR>
imap <silent> <F2> <Esc>:NERDTreeToggle<CR>

let NERDTreeIgnore=['\~$', '\.exe$', '\.py[co]$', '\.s?o$', '\.sw[op]$']
let NERDTreeShowBookmarks = 1

" Tagbar
map  <silent> <F3>      :TagbarToggle<CR>
imap <silent> <F3> <Esc>:TagbarToggle<CR>

" VimWiki
let g:vimwiki_dir_link = 'index'
let g:vimwiki_folding = 1
let g:vimwiki_fold_lists = 1
let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checked = 1

" fugitive
nmap <Leader>gb :Gblame<CR>
nmap <Leader>gd :Gdiff<CR>
nmap <Leader>gc :Gcommit<CR>
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gS :Gstatus<CR><C-w>T

" Session
let g:session_directory = '~/.local/share/nvim/sessions'
let g:session_autosave = 'no'

" NrrwRgn options
let g:nrrw_rgn_vert = 1 " Open narrow region windows in *vertical* splits

" vim-airline options
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#tab_nr_type = 1

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-]>"
let g:UltiSnipsJumpForwardTrigger="<c-]>"
let g:UltiSnipsJumpBackwardTrigger="<c-[>"

" sideways.vim
nnoremap <Leader>ah :SidewaysLeft<CR>
nnoremap <Leader>al :SidewaysRight<CR>

" python-syntax
let python_highlight_all = 1
let python_slow_sync = 1

" vim-gitgutter
nmap <leader>gg :GitGutterToggle<CR>

" vim-gutentags
let g:gutentags_ctags_exclude = ['.git', 'node_modules']

" python-mode
let g:pymode_doc_bind = 'Q'
let g:pymode_breakpoint_bind = '<leader>db'
" Disable pymode's linting in favour of vim-lsc
let g:pymode_lint = 0
" Disable Rope completion in favour of YCM
let g:pymode_rope_completion = 0
" let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_regenerate_on_write = 0

" toggle_words.vim
let g:toggle_words_dict = {'python': [['assertTrue', 'assertFalse']]}
nmap <silent> <Leader>ff :ToggleWord<CR>

" Use SmartHomeKey to toggle between ^ and 0
nmap <silent> 0 :SmartHomeKey<CR>

" Splitjoin
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''

nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Mappings
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

" Navigate tabs
nnoremap [r gT
nnoremap ]r gt

" Search in visual selection
vnoremap <Leader>/ <Esc>/\%V

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
" Open scratchpad
nmap <silent> <Leader>bS :tabnew<CR>:set buftype=nofile<CR>

" Open current file in new tab
nmap <Leader>ts :split<CR><C-w>T

" Window splitting
nmap <Leader>S :split<CR>
nmap <Leader>V :vsplit<CR>

" Toggle folds
nnoremap <C-f> za
" Refresh folds by (re)setting fold method
" This correctly recalculates folds after 'foldmethod' gets set to 'custom'.
" This shouldn't be necessary, but happens enough to warrant a mapping.
nnoremap <Leader>FF :set foldmethod=syntax<CR>

" Change working directory to the current file's directory
" (http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file)
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <Leader>c. :cd ..<CR>:pwd<CR>

" Quickfix and location list
map <silent> <Leader>ll :ll<CR>zzzv
map <silent> <Leader>ls :LocList<CR>zzzv
map <silent> <Leader>cc :cc<CR>zzzv
map <silent> <Leader>cs :QFix<CR>zzzv

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

" xmllint
nmap <silent> <Leader>fX :%!xmllint --format -<CR>

" JSON formatting
nmap <silent> <Leader>fj :%!python -m json.tool<CR>

" Select pasted text
" (http://vim.wikia.com/wiki/Selecting_your_pasted_text)
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" grep word under cursor
" (https://github.com/nathanlong/dotfiles/blob/master/vim/vimrc)
nnoremap <Leader>G :lgrep! "\b(<C-R><C-W>)\b"<CR>:lw<CR>
vnoremap <Leader>G "sy:lgrep! "\b(<C-R>s)\b"<CR>:lw<CR>

" Expand %% to the current file's directory in commands. This is useful if CWD
" is "far" from the current file's directory.
" (https://github.com/nathanlong/dotfiles/blob/master/vim/vimrc)
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" Use <C-k>/<C-j> to move up/down in command history
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Abbreviations
" Typing aides
iabbrev improt import
iabbrev fucntion function
iabbrev Noen None
iabbrev sefl self
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Use ag/ack-grep for the :grep command
if executable("ag")
  set grepprg=ag\ --nogroup\ --nocolor
elseif executable("ack-grep")
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
if exists("&undodir")
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
    if line("'\"") > 0 && line ("'\"") <= line("$")
      exe "normal! g`\""
      normal! zz
    endif
  end
endfunction
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Rename command
" Rename3.vim  -  Rename a buffer within Vim and on disk.
"
" Copyright July 2013 by Alex Ehlke <alex.ehlke at gmail.com>
"
" based on Rename2.vim (which couldn't handle spaces in paths)
" Copyright July 2009 by Manni Heumann <vim at lxxi.org>
"
" which is based on Rename.vim
" Copyright June 2007 by Christian J. Robinson <infynity@onewest.net>
"
" Distributed under the terms of the Vim license.  See ":help license".
"
" Usage:
"
" :Rename[!] {newname}

command! -nargs=* -complete=file -bang Rename :call Rename("<args>", "<bang>")

function! Rename(name, bang)
  let l:curfile = expand("%:p")
  let l:curfilepath = expand("%:p:h")
  let l:newname = l:curfilepath . "/" . a:name
  let v:errmsg = ""
  silent! exec "saveas" . a:bang . " " . fnameescape(l:newname)
  if v:errmsg =~# '^$\|^E329'
    if expand("%:p") !=# l:curfile && filewritable(expand("%:p"))
      silent exec "bwipe! " . fnameescape(l:curfile)
      if delete(l:curfile)
        echoerr "Could not delete " . l:curfile
      endif
    endif
  else
    echoerr v:errmsg
  endif
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
command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction

command! -bang -nargs=? LocList call LocListToggle(<bang>0)
function! LocListToggle(forced)
  if exists("g:loclist_win") && a:forced == 0
    lclose
    unlet g:loclist_win
  else
    lopen 10
    let g:loclist_win = bufnr("$")
  endif
endfunction
" }}}

" vim:fdm=marker:sw=2