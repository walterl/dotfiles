" From http://vim.wikia.com/wiki/Search_using_quickfix_to_list_occurrences
command! GREP :execute 'vimgrep '.expand('<cword>').' '.expand('%') | :copen | :cc

" Assign some keys for handy quickfix window commands.
nnoremap <kPlus>     :call <SID>Fancy_Quickfix_Cmd(':cnext')<CR>
nnoremap <kMinus>    :call <SID>Fancy_Quickfix_Cmd(':cprev')<CR>
nnoremap <kMultiply> :call <SID>Fancy_Quickfix_Cmd(':cc')<CR>
nnoremap <c-kPlus>   :clast<CR>
nnoremap <c-kMinus>  :cfirst<CR>
nnoremap <m-kPlus>   :cnewer<CR>
nnoremap <m-kMinus>  :colder<CR>

" Very simple wrapper: do quickfix cmd, center line and,
" if taglist.vim's window is open, sync.
function! s:Fancy_Quickfix_Cmd(Cmd)
	try
		execute a:Cmd
	catch /^Vim(\a\+):E553:/
		echohl ErrorMsg | echo v:exception | echohl None
	endtry
	norm! zz
	" If the taglist window is open then :TlistSync
	"		Tag list window name: '__Tag_List__'
	if bufwinnr('__Tag_List__') != -1
		TlistSync
	endif
endfunction
