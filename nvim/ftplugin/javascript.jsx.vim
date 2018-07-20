if executable(expand("$HOME/.virtualenvs/jsbeautifier/bin/js-beautify"))
  setlocal equalprg=$HOME/.virtualenvs/jsbeautifier/bin/js-beautify\ --stdin\ -X
endif
