" Based on ftplugin/clojure.vim

set foldmethod=syntax

nmap <Leader>jc (i#_<Esc>
nmap <silent> <Leader>jj vaF:CenterFold<CR>

" Swap multiple selected elements:
vmap <buffer> <e <Plug>(sexp_swap_element_backward)
vmap <buffer> >e <Plug>(sexp_swap_element_forward)

" Don't automatically insert closing ' or `
let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}
let b:coc_diagnostic_disable = 1
