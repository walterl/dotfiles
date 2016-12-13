" For Python
"""""""""""""
" Most of the stuff from blog.sontek.net's VIm Python IDE tutorial
" (http://blog.sontek.net/2008/05/11/python-with-a-modular-ide-vim/)

setlocal foldignore=  " Default is #, which causes comment lines to be ignored in folds
setlocal foldminlines=2  " Don't fold single lines.
setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
setlocal efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
if system("python --version") =~ '^Python 2'
	setlocal equalprg=$HOME/.vim/ftplugin/python/reindent.py
else
	setlocal equalprg=$HOME/.vim/ftplugin/python/reindent3.py
endif

setlocal colorcolumn=72,80

" Avoid unindentation of Python comments
inoremap # X#

" Configure IndentGuides
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
IndentGuidesEnable
