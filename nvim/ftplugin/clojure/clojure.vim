set foldmethod=syntax

" cloJure mappings
nnoremap <Leader>je :%Eval<CR>
vnoremap <Leader>je :Eval<CR>
nmap <Leader>jd ]<C-d>
nmap <Leader>jf cpp
nmap <Leader>jj cpaF
nmap <Leader>jc (i#_<Esc>

" Don't automatically insert closing ' or `
let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}
let b:coc_diagnostic_disable = 1
