" Automatically switch between relative and absolute line numbers
" (from http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/ - see comments)
autocmd FocusLost * :set number
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
autocmd CursorMoved * :set relativenumber
