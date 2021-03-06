setlocal foldmethod=syntax

if HasPlugin('coc.nvim')
  let b:coc_diagnostic_disable = 1
endif

if HasPlugin('auto-pairs')
  " Don't automatically insert closing ' or `
  let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}
endif

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
  " Copies element under the cursor to a `def` in a Rich comment ABOVE top-level form
  nmap <Leader>jd yie<Plug>(sexp_move_to_prev_top_element)O<CR><Up>(comment<CR>(def <C-r>" :<Esc>pB
  " Copies the form under the cursor to a Rich comment BELOW top-level form
  nmap <Leader>je yaf<Plug>(sexp_move_to_prev_top_element)%o<CR>(comment<CR><Esc>p==
  " Wrap current element in :keys destructuring map
  nmap <Leader>jk <LocalLeader>e{:keys [] :as<Esc>F[
  " Swap multiple selected elements:
  vmap <buffer> <e <Plug>(sexp_swap_element_backward)
  vmap <buffer> >e <Plug>(sexp_swap_element_forward)
endif

if HasPlugin('conjure')
  imap <silent> <C-k> <Cmd>ConjureDocWord<CR>
endif

if executable('jet')
  " Format with jet
  nmap <Leader>Fe <Cmd>%!jet --pretty<CR>
endif
