set foldmethod=syntax

" To enable me to use vim-sexp's awesome mappings:
let maplocalleader='Y'

nnoremap <Leader>E :%Eval<CR>
vnoremap <Leader>E :Eval<CR>

" Don't automatically insert closing '
let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`'}
