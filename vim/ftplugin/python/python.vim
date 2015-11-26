" For Python
"""""""""""""
" Most of the stuff from blog.sontek.net's VIm Python IDE tutorial
" (http://blog.sontek.net/2008/05/11/python-with-a-modular-ide-vim/)

setlocal foldmethod=indent  " Fold on indentation
setlocal foldignore=  " Default is #, which causes comment lines to be ignored in folds
setlocal foldminlines=2  " Don't fold single lines.
setlocal omnifunc=pythoncomplete#Complete
setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
setlocal makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
setlocal efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
if system("python --version") =~ '^Python 2'
	setlocal equalprg=$HOME/.vim/ftplugin/python/reindent.py
else
	setlocal equalprg=$HOME/.vim/ftplugin/python/reindent3.py
endif

if v:version >= 703
	setlocal colorcolumn=80,90,100
endif

pyfile $HOME/.vim/ftplugin/python/custom.py

" Evaluate buffer or range:
nmap <Leader>pe :py eval_buffer()<CR>
vmap <Leader>pe :py eval_range()<CR>

" Set/clear breakpoints:
map <Leader>pb :py toggle_breakpoint()<CR>
map <Leader>pB :py remove_breakpoints()<CR>

" Generate CTags for Python files
map <Leader>pt :!find -name '*.py' \| xargs ctags-exuberant<CR>

" Avoid unindentation of Python comments
inoremap # X#

" Add the virtualenv's site-packages to vim path
py load_venv()

" Configure IndentGuides
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
IndentGuidesEnable
