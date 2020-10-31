nnoremap <leader>Fe :call FormatEDN()<CR>1G=G<CR>

function! FormatEDN()
  if search('" "')
    execute '%s/" "/"\r"/g'
  endif
  " Break lists of maps onto separate lines.
  if search('} {')
    execute '%s/} {/}\r{/g'
  endif
  " Convert commas into newlines in maps.
  if search(', :')
    execute '%s/, :/\r:/g'
  endif
endfunction
