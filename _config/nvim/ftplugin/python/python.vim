" For Python
"""""""""""""
" Most of the stuff from blog.sontek.net's VIm Python IDE tutorial
" (http://blog.sontek.net/2008/05/11/python-with-a-modular-ide-vim/)

setlocal foldmethod=indent
setlocal foldignore=  " Default is #, which causes comment lines to be ignored in folds
setlocal foldminlines=2  " Don't fold single lines.
setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
setlocal errorformat=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

setlocal colorcolumn=72,80

" Avoid unindentation of Python comments
inoremap # X#

" Wrapping stuff in parens/brackets/braces, similar to vim-sexp
nmap <LocalLeader>w ysiwb
nmap <LocalLeader>e[ ysiw[
nmap <LocalLeader>e] ysiw]
nmap <LocalLeader>e{ ysiw}
nmap <LocalLeader>e} ysiw{

vmap <LocalLeader>w SbF(
nmap <LocalLeader>e[ S[F[
nmap <LocalLeader>e] S]F[
nmap <LocalLeader>e{ S}F{
nmap <LocalLeader>e} S{F{

nmap <LocalLeader>el vil<LocalLeader>E
