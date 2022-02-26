setlocal foldmethod=syntax

" Turn keyword into keyword-var map entry: turns `:foo|` (| is cursor position) into `:foo foo`
imap <C-l> <Esc>BywPlr<Space>E

if HasPlugin('ale')
  ALEDisableBuffer
endif

if HasPlugin('auto-pairs')
  " Don't automatically insert closing ' or `
  let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}
endif

""" cloJure mappings
" Comment out current form
nmap <Leader>jc (i#_<Esc>
" Insert Rich comment above current line
nmap <Leader>jC O(comment<CR><CR>,,,)<CR><Up><Up><Space><Space>
" Use current element/form as value in new `let`-form
nmap <Leader>jl <LocalLeader>wlet<Esc>W<LocalLeader>e[

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

if HasPlugin('coc.nvim')
  setl formatexpr=CocAction('formatSelected')
endif

if HasPlugin('vim-projectionist')
  let g:projectionist_heuristics = {
        \  "deps.edn|project.clj": {
        \    "src/*.clj": {
        \      "type": "source",
        \      "alternate": "test/{}_test.clj"
        \    },
        \    "test/*_test.clj": {
        \      "type": "test",
        \      "alternate": "src/{}.clj"
        \    }
        \  }
        \}
endif

if executable('jet')
  " Format with jet
  nnoremap <Leader>Fe <Cmd>%!jet --pretty<CR>
  vnoremap <silent> <leader>E y<Cmd>call PrettyJetSplit()<CR>
  " Shortcut: in normal mode, placing your cursor inside the top level of an EDN
  " map and using this mapping results in visually selecting the EDN map and
  " doing the PrettyJetSplit thing above.
  nnoremap <silent> <leader>EF va}y<Cmd>call PrettyJetSplit()<CR>
endif
