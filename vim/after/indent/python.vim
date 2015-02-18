" Shamelessly ripped from the very extensive python-mode plug-in:
" https://github.com/klen/python-mode

" From after/indent/python.vim
setlocal nolisp
setlocal tabstop=8
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal shiftround
setlocal expandtab
setlocal autoindent
setlocal indentexpr=GetPythonIndent(v:lnum)
setlocal indentkeys=!^F,o,O,<:>,0),0],0},=elif,=except
