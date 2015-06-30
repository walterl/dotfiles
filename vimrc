" {{{ General Settings
lan C                             " Please use the default English
set modeline                      " Use mode lines in files (see :help modeline)
set relativenumber                " Show relative line numbers
set nowrap                        " Don't wrap lines
set showbreak=↪                   " But when wrapped, show nice linebreak char
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
set listchars=tab:»—,trail:⋅ list " Show tabs and trailing characters
set hidden                        " For lusty explorer
set winwidth=80                   " Windows will always be at least 80 chars (if possible)
set foldmethod=indent             " Fold on indentation
set complete-=i                   " from :help cpt: i: scan current and included files. It's very slow in Windows :(
set switchbuf=useopen,usetab      " Try to move to other windows if changing buf
set encoding=utf-8
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.pyo,*.swp
set smarttab
set softtabstop=4
set shiftwidth=4
set tabstop=4
set shortmess+=a                  " Use [+] [RO] [w] for modified, read-only, modified
set laststatus=2                  " Always show statusline, even if only 1 window
set report=0                      " Notify me whenever any lines have changed
set confirm                       " Y-N-C prompt if closing with unsaved changes
set showcmd                       " Show size of selected area in visual mode
set backspace=2                   " Backspace over anything! (Super backspace!)
set showmatch                     " Briefly jump to the previous matching paren
set matchtime=2                   " For .2 seconds
set timeoutlen=500                " Lowers leader and command timeout
set directory=~/.vim/tmp          " Directory for swap/temp files
set nobackup                      " Don't create backup files
set nowb                          " Don't create write backups
set noswapfile                    " Don't create swap files
set viminfo+=n$HOME/.vim/tmp/viminfo
set splitbelow                    " Split windows below the current window
set splitright                    " Split vertical windows on the right
let mapleader = "\<Space>"        " Remap <Leader> to <Space>
syntax on                         " Enable syntax highlighting
filetype plugin indent on         " Load filetype specific plug-ins and indentation scripts
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Plugins
call plug#begin('~/.vim/plugged')
  " Colors
  Plug 'sjl/badwolf'
  Plug 'junegunn/seoul256.vim'

  " Editing enhancement
  Plug 'AndrewRadev/sideways.vim'
  Plug 'chrisbra/NrrwRgn'
  Plug 'edsono/vim-dbext'
  Plug 'edsono/vim-matchit'
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
  Plug 'xolox/vim-easytags'
  Plug 'xolox/vim-misc'
  Plug 'xolox/vim-session'

  " CoffeeScript
  Plug 'kchmck/vim-coffee-script'
  " CSS
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
  Plug 'fatih/vim-go'
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
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Plugin settings
" Settings and mappings related to plug-ins

colorscheme badwolf

" CtrlP
let g:ctrlp_map = ",f"
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:50'
map <silent> ,b :CtrlPBuffer<CR>
map <silent> ,m :CtrlPMixed<CR>
map <silent> ,t :CtrlPBufTagAll<CR>
if executable("ag")
  let g:ctrp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif
" Above from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/

" NERDTree
map  <silent> <F2>      :NERDTreeToggle<CR>
imap <silent> <F2> <Esc>:NERDTreeToggle<CR>
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
nmap <Leader>gc :Gcommit<CR>
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gS :Gstatus<CR><C-w>T

" gitv
let g:Gitv_OpenHorizontal = 1
let g:Gitv_TruncateCommitSubjects = 1
nmap <Leader>gv :Gitv<CR>

" Syntastic
let g:syntastic_mode_map = {'mode': 'active', 'active_filetypes': ['javascript']}
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_coffee_coffeelint_exec = expand("$HOME") . "/node_modules/.bin/coffeelint"
let g:syntastic_javascript_jshint_exec = expand("$HOME") . "/node_modules/.bin/jshint"

" Session
let g:session_autosave = 'no'

" NrrwRgn options
let g:nrrw_rgn_vert = 1 " Open narrow region windows in *vertical* splits

" Pydiction options
let g:pydiction_location = expand("$HOME") . '/.vim/plugged/pydiction/complete-dict'

" showmarks
" Note that ` and ' are switched, to replace the above (commented out) remapping.
nnoremap ` :ShowMarksOnce<CR>'
nnoremap ' :ShowMarksOnce<CR>`

" vim-airline options
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#tab_nr_type = 1

" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-]>"
let g:UltiSnipsJumpForwardTrigger="<c-]>"
let g:UltiSnipsJumpBackwardTrigger="<c-[>"

" easyalign
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" sideways.vim
nnoremap <Leader>ah :SidewaysLeft<CR>
nnoremap <Leader>al :SidewaysRight<CR>

" python.vim--Vasiliev
let python_highlight_all = 1
let python_slow_sync = 1

" easytags
let g:easytags_auto_highlight = 0
let g:easytags_async = 1
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
nnoremap <Leader>[ gt
nnoremap <Leader>] gT
nnoremap <Leader>. gt
nnoremap <Leader>, gT

" Search in visual selection
vnoremap <M-/> <Esc>/\%V

" Reselect visual selection after indent
vnoremap < <gv
vnoremap > >gv

" Select a line without trailing whitespace or linebreaks
" (https://github.com/nathanlong/dotfiles/blob/master/vim/vimrc)
nnoremap <Leader>v <Esc>^vg_

" Close buffers
nmap <Leader>q :q<CR>
nmap <Leader>wq :wq<CR>
imap <C-q> <ESC>:bdelete<CR>
nmap <C-q> :bdelete<CR>
vmap <C-q> <ESC>:bdelete<CR>

" Switch to previous buffer
nmap <Leader>B :e#<CR>

" List buffers
nmap <Leader>bl :buffers<CR>

" <C-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Toggle folds
nnoremap <C-f> za

" Change working directory to the current file's directory
" (http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file)
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <Leader>c. :cd ..<CR>:pwd<CR>

" Quickfix and location list
map <silent> <Leader>ln :lnext<CR>zzzv
map <silent> <Leader>lp :lprev<CR>zzzv
map <silent> <Leader>ll :ll<CR>zzzv
map <silent> <Leader>ls :LocList<CR>zzzv
map <silent> <Leader>cn :cnext<CR>zzzv
map <silent> <Leader>cp :cprev<CR>zzzv
map <silent> <Leader>cc :cc<CR>zzzv
map <silent> <Leader>cs :QFix<CR>zzzv

" Switch windows
map <silent> <A-h> <C-w>h
map <silent> <A-l> <C-w>l
map <silent> <A-j> <C-w>j
map <silent> <A-k> <C-w>k

" Move up and down by folds
map <silent> <C-j> zj
map <silent> <C-k> zk

" Tag navigation
map <silent><A-]> <C-w><C-]><C-w>T
inoremap <Nul> <C-x><C-o>

" Emacs style jump to end of line in insert mode
" prevents conflict with autocomplete
" (https://github.com/nathanlong/dotfiles/blob/master/vim/vimrc)
inoremap <expr> <C-e> pumvisible() ? "\<C-e>" : "\<C-o>A"
inoremap <C-a> <C-o>I

" Open line above or below in insert mode
" (https://github.com/nathanlong/dotfiles/blob/master/vim/vimrc)
inoremap <C-Enter> <C-o>o
inoremap <C-S-Enter> <C-o>O

" Delete trailing spaces
nmap <silent> <Leader>ds :%s/\s\+$//e<CR>

" Open scratchpad
nmap <silent> <Leader>bS :tabnew<CR>:set buftype=nofile<CR>

" Set indentations
nmap <silent> <Leader>in2 :set ts=2 sts=2 sw=2<CR>
nmap <silent> <Leader>in4 :set ts=4 sts=4 sw=4<CR>

" xmllint
nmap <silent> <Leader>fx :g//d<CR>:r!xmllint --format "%"<CR>ggdd:w<CR>
nmap <silent> <Leader>fX :!xmllint --format "%" -o "%"<CR>

" JSON formatting
nmap <silent> <Leader>fj :%!python -m json.tool<CR>

" Move lines up or down
" (http://nathan-long.com/blog/vim-a-few-of-my-favorite-things/)
nmap <Leader>K ddkP
nmap <Leader>J ddp

vmap <Leader>K xkP`[V`]
vmap <Leader>J xp`[V`]

" bind K to grep word under cursor
" (https://github.com/nathanlong/dotfiles/blob/master/vim/vimrc)
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Expand %% to the current file's directory in commands. This is useful if CWD
" is "far" from the current file's directory.
" (https://github.com/nathanlong/dotfiles/blob/master/vim/vimrc)
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" Use <C-k>/<C-j> to move up/down in command history
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
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

" {{{ Automatically switch between relative and absolute line numbers
" (from http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/ - see comments)
autocmd FocusLost * :set number
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
autocmd CursorMoved * :set relativenumber
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Toggle relative/absolute line numbers
" Toggle line numbers between relative and absolute
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<CR>
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Autoclose inactive buffers
" (http://stackoverflow.com/questions/2974192/how-can-i-pare-down-vims-buffer-list-to-only-include-active-buffers)
" (https://github.com/nathanlong/dotfiles/blob/master/vim/vimrc)
command! -nargs=* CloseHiddenBuffers call s:CloseHiddenBuffers()
function! s:CloseHiddenBuffers()
  " figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " close any buffer that are loaded and not visible
  let l:tally = 0
  for b in range(1, bufnr('$'))
    if bufloaded(b) && !has_key(visible, b)
      let l:tally += 1
      exe 'bw ' . b
    endif
  endfor
  echon "Deleted " . l:tally . " buffers"
endfun

nmap <Leader>bc :CloseHiddenBuffers<CR>
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

" {{{ Rembmer cursor positions
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Toggle hex editing mode
" From http://vim.wikia.com/wiki/Improved_hex_editing
" ex command for toggling hex mode - define mapping if desired
command! -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function! ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

nnoremap <M-x> :Hexmode<CR>
inoremap <M-x> <ESC>:Hexmode<CR>
vnoremap <M-x> :<C-U>Hexmode<CR>
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Remember searches per window
function! s:restoreSearchPattern()
  if exists('w:search_pattern')
    call setreg('/', w:search_pattern)
  endif
endfunction

function! s:saveSearchPattern()
  let w:search_pattern = getreg('/')
endfunction

autocmd WinEnter * call s:restoreSearchPattern()
autocmd WinLeave * call s:saveSearchPattern()
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Load machine-specific vimrc
if filereadable(expand("$HOME") . "/.vimrc.local")
  source $HOME/.vimrc.local
endif
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim:fdm=marker:sw=2
