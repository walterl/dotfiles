if exists("g:loaded_winsearch")
	finish
endif

let g:loaded_winsearch = 1

function! winsearch#restoreSearchPattern()
	if exists('w:search_pattern')
		call setreg('/', w:search_pattern)
	endif
endfunction

function! winsearch#saveSearchPattern()
	let w:search_pattern = getreg('/')
endfunction

autocmd WinEnter * call winsearch#restoreSearchPattern()
autocmd WinLeave * call winsearch#saveSearchPattern()
