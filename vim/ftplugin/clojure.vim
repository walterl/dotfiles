RainbowParenthesesActivate

" Copied from fireplace.vim, because it's more useful than the default K
" mapping I have in my main vimrc.
function! s:fireplaceK() abort
  let word = expand('<cword>')
  let java_candidate = matchstr(word, '^\%(\w\+\.\)*\u\l[[:alnum:]$]*\ze\%(\.\|\/\w\+\)\=$')
  if java_candidate !=# ''
    return 'Javadoc '.java_candidate
  else
    return 'Doc '.word
  endif
endfunction

nnoremap <Leader>E :%Eval<CR>
vnoremap <Leader>E :Eval<CR>

nnoremap <Plug>FireplaceK :<C-R>=<SID>fireplaceK()<CR><CR>
nmap <buffer> K <Plug>FireplaceK

" Don't automatically insert closing '
let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`'}
