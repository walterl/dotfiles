" This is a minimal vimrc, dependent on no plugins.

" {{{ General Settings
lan C

set relativenumber
set number
set showmatch
set backspace=2
set showcmd
set confirm
set shortmess+=a
set cursorline
set scrolloff=3
set hlsearch
set incsearch
set ignorecase
set nowrap

set smarttab
set softtabstop=4
set shiftwidth=4
set tabstop=4
set nobackup
set nowb
set noswapfile
set listchars=tab:»—,trail:⋅ list

let mapleader = "\<Space>"
syntax on
filetype plugin indent on
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
vnoremap <M-/> <Esc>/\%V

" Reselect visual selection after indent
vnoremap < <gv
vnoremap > >gv

" Select a line without trailing whitespace or linebreaks
" (https://github.com/nathanlong/dotfiles/blob/master/vim/vimrc)
nnoremap <Leader>v <Esc>^vg_

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

" Split current window
nmap <Leader>H :split<CR>
nmap <Leader>V :vsplit<CR>

" Open current file in new tab
nmap <Leader>ts :split<CR><C-w>T

" <C-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

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

" Switch windows

" Move up and down by folds
map <silent> <C-j> zj
map <silent> <C-k> zk

" Tag navigation
inoremap <Nul> <C-x><C-o>

" Emacs style jump to end of line in insert mode
" prevents conflict with autocomplete
" (https://github.com/nathanlong/dotfiles/blob/master/vim/vimrc)
inoremap <expr> <C-e> pumvisible() ? "\<C-e>" : "\<C-o>A"
inoremap <C-a> <C-o>I

" `cc` the line above the current one without leaving insert mode
inoremap <C-k> <C-o>k<C-o>cc
" Ctrl+j moves cursor to the end of the line below, while in insert mode
inoremap <C-j> <C-o>j<C-o>$

" Move in cursor around while in insert mode
inoremap <M-h> <C-o>h
inoremap <M-j> <C-o>j
inoremap <M-k> <C-o>k
inoremap <M-l> <C-o>l

" Indent lines without leaving insert mode
inoremap <M->> <C-o>>>
inoremap <M-<> <C-o><<

" Delete trailing spaces
nmap <silent> <Leader>ds :%s/\s\+$//e<CR>

" Set indentations
nmap <silent> <Leader>in2 :set ts=2 sts=2 sw=2<CR>
nmap <silent> <Leader>in4 :set ts=4 sts=4 sw=4<CR>

" xmllint
nmap <silent> <Leader>fx :g//d<CR>:r!xmllint --format "%"<CR>ggdd:w<CR>
nmap <silent> <Leader>fX :!xmllint --format "%" -o "%"<CR>

" JSON formatting
nmap <silent> <Leader>fj :%!python -m json.tool<CR>

" Select pasted text
" (http://vim.wikia.com/wiki/Selecting_your_pasted_text)
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" grep word under cursor
" (https://github.com/nathanlong/dotfiles/blob/master/vim/vimrc)
nnoremap <Leader>G :grep! "\b(<C-R><C-W>)\b"<CR>:cw<CR>
vnoremap <Leader>G :grep! "\b(<C-R>*)\b"<CR>:cw<CR>

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

" vim:fdm=marker:sw=2
