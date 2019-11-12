set foldmethod=syntax

nnoremap <Leader>E :%Eval<CR>
vnoremap <Leader>E :Eval<CR>

" Don't automatically insert closing '
let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`'}
