function! s:deadon_enable()
  augroup deadon
	autocmd CursorMoved * normal zz
  augroup END
endfunction

function! s:deadon_disable()
  autocmd! deadon
endfunction

command -nargs=0 DeadonEnable silent call <SID>deadon_enable()
command -nargs=0 DeadonDisable silent call <SID>deadon_disable()
