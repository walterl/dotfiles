set foldmethod=syntax

" cloJure mappings
nnoremap <Leader>je :%Eval<CR>
vnoremap <Leader>je :Eval<CR>
nnoremap <Leader>jp cpaF
nmap <Leader>jc (i#_<Esc>

" Don't automatically insert closing '
let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`'}
