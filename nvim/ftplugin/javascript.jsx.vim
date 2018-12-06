if executable(expand("$HOME/.virtualenvs/jsbeautifier/bin/js-beautify"))
  setlocal equalprg=$HOME/.virtualenvs/jsbeautifier/bin/js-beautify\ --stdin\ -X
endif

if g:loaded_commentary
  autocmd FileType javascript.jsx setlocal commentstring={/*\ %s\ */}
endif
