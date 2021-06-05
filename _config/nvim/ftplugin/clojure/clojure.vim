set foldmethod=syntax

" cloJure mappings
nmap <Leader>jc (i#_<Esc>

if HasPlugin('vim-fireplace')
  nmap <Leader>jd <Plug>FireplaceDjump
  nmap <Leader>jS <Plug>FireplaceDsplit
  nmap <Leader>jt <Plug>FireplaceDtabjump
endif

if HasPlugin('vim-sexp')
  " Change (foo) into (doto (foo) tap>)
  nmap <silent> <Leader>j> <Plug>(sexp_round_head_wrap_list)doto<Esc>Ea tap><Esc>
  " Change foo into (doto foo tap>)
  nmap <silent> <Leader>j< <Plug>(sexp_round_head_wrap_element)doto<Esc>Ea tap><Esc>

  " Swap multiple selected elements:
  vmap <buffer> <e <Plug>(sexp_swap_element_backward)
  vmap <buffer> >e <Plug>(sexp_swap_element_forward)
endif

if HasPlugin('conjure')
  imap <silent> <C-k> <Cmd>ConjureDocWord<CR>
endif

" Don't automatically insert closing ' or `
let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}
let b:coc_diagnostic_disable = 1
if executable('jet')
  " Format with jet
  nmap <Leader>Fe <Cmd>%!jet --pretty<CR>
endif
