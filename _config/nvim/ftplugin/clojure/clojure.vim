set foldmethod=syntax

" cloJure mappings
nmap <Leader>jd <Plug>FireplaceDjump
nmap <Leader>jS <Plug>FireplaceDsplit
nmap <Leader>jt <Plug>FireplaceDtabjump
nmap <Leader>jc (i#_<Esc>
nmap <silent> <Leader>jj vaF:CenterFold<CR>zCzO
" Change (foo) into (doto (foo) tap>)
nmap <silent> <Leader>j> <Plug>(sexp_round_head_wrap_list)doto<Esc>Ea tap><Esc>
" Change foo into (doto foo tap>)
nmap <silent> <Leader>j< <Plug>(sexp_round_head_wrap_element)doto<Esc>Ea tap><Esc>

imap <silent> <C-k> <Cmd>ConjureDocWord<CR>

" Swap multiple selected elements:
vmap <buffer> <e <Plug>(sexp_swap_element_backward)
vmap <buffer> >e <Plug>(sexp_swap_element_forward)

" Don't automatically insert closing ' or `
let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}
let b:coc_diagnostic_disable = 1
