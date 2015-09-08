function! s:highlightSpecial()
  " Color "Special" highlighting group to badwolf's "saltwatertaffy" colour
  hi Special guifg=#8cffba ctermfg=121
endfunction

function! s:highlightPythonPseudoKeyword()
  syn keyword pythonPseudoKeyword self cls
  hi def link pythonPseudoKeyword Special
endfunction

au BufEnter * call s:highlightSpecial()
au BufEnter *.py call s:highlightPythonPseudoKeyword()
