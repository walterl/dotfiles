nmap <Leader>jes :let g:syntastic_javascript_checkers = ["eslint"]<CR>

if executable(expand("$HOME/.virtualenvs/jsbeautifier/bin/js-beautify"))
  setlocal equalprg=$HOME/.virtualenvs/jsbeautifier/bin/js-beautify\ --stdin\ -X
endif
