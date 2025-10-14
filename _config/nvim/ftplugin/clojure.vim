let g:clojure_discard_macro=1 " Style forms commented out with #_ reader macro
let g:clojure_fold=1
setlocal foldnestmax=1

autocmd BufWrite <buffer> :%s/\s\+$//e

" Make TODOs and FIXMEs stand out
highlight! link clojureCommentTodo PmenuSel

""" cloJure mappings
" Turn keyword into keyword-var map entry: turns `:foo|` (| is cursor position) into `:foo foo`
imap <C-l> <Esc>BywPlr<Space>E
" Comment out current form
nmap <Leader>jc (i#_<Esc>
" Insert Rich comment above current line
nmap <Leader>jC O(comment<CR><CR>,,,)<CR><Up><Up><Space><Space>

function HasPlugin(plugin)
  let plugin_names = luaeval('vim.tbl_keys(require("lazy.core.config").plugins)')
  return index(l:plugin_names, a:plugin) > -1
endfunction

if HasPlugin('auto-pairs')
  " Don't automatically insert closing ' or `
  let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}
endif

if exists("g:toggle_words_dict")
  let g:toggle_words_dict['clojure'] = [['true?', 'false?']]
endif

if HasPlugin('vim-projectionist')
lua <<EOF
vim.g.projectionist_heuristics = vim.tbl_extend('force', vim.g.projectionist_heuristics, {
  ['deps.edn|project.clj'] = {
    ['src/*.clj'] = { type = 'source', alternate = 'test/{}_test.clj' },
    ['test/*_test.clj'] = { type = 'test', alternate = 'src/{}.clj' },
  },
  ['shadow-cljs.edn'] = {
    ['src/main/**/*.cljs'] = { type = 'source', alternate = 'src/test/{}_test.cljs' },
    ['src/test/**/*_test.cljs'] = { type = 'test', alternate = 'src/main/{}.cljs' },
  },
})
EOF
endif

if HasPlugin('vim-sexp-mappings-for-regular-people')
  " Change (foo) into (doto (foo) tap>)
  nmap <silent> <Leader>j> <Plug>(sexp_round_head_wrap_list)doto<Esc>Ea tap><Esc>
  " Change foo into (doto foo tap>)
  nmap <silent> <Leader>j< <Plug>(sexp_round_head_wrap_element)doto<Esc>Ea tap><Esc>
  " Wrap current form in thread first macro ->
  nmap <Leader>j- <Plug>(sexp_move_to_prev_bracket)<Plug>(sexp_round_head_wrap_element)-><Esc><Plug>(sexp_move_to_next_element_tail)a<CR>
  " Wrap current form in thread last macro ->>
  nmap <Leader>j-- <Plug>(sexp_move_to_prev_bracket)<Plug>(sexp_round_head_wrap_element)->><Esc><Plug>(sexp_move_to_next_element_tail)a<CR>
  " Copies element under the cursor to a `def` in a Rich comment ABOVE top-level form
  nmap <Leader>jd yie<Plug>(sexp_move_to_prev_top_element)O<CR><Up>(comment<CR>(def <C-r>" :<Esc>pB
  " Copies the form under the cursor to a Rich comment BELOW top-level form
  nmap <Leader>je yaf<Plug>(sexp_move_to_prev_top_element)%o<CR>(comment,<Left><CR><CR><Up><Esc>p==
  " Wrap current element in :keys destructuring map
  nmap <Leader>jk <Plug>(sexp_curly_head_wrap_element):keys [] :as<Esc>F[
  " Wrap current element in an anonymous function
  nmap <Leader>ja i#<Esc>lyswb%
  " Change 'x y' line into '(def x y)'
  nmap <Leader>jD ^v2ESb0adef <Esc>==^

  lua <<EOF
  vim.api.nvim_buf_set_keymap(
    0, "n",
    "<Leader>jD", "^v2ESb0adef <Esc>==^",
    { desc = 'Change current line to "(def x y)" from "x y"' }
  )
EOF
endif

if HasPlugin('conjure')
  imap <buffer> <C-k> <Cmd>ConjureDocWord<CR>

  " Use current element/form as value in new `let`-form
  nmap <Leader>jl <LocalLeader>wlet<Esc>W<LocalLeader>e[
  " Execute (type ...) on the element under the cursor
  nmap <Leader>jy <LocalLeader>wtype<Esc><LocalLeader>eeu
  " Execute a def binding the selected value to the symbol preceding it. E.g. selelct `x (inc 1)` to execute `(def x (inc 1))`
  " Meant for `def`-ing intermediate values in `let` binding vectors.
  vmap <Leader>jE <LocalLeader>wdef <Esc><LocalLeader>eeu
endif

if HasPlugin('telescope')
  nmap <Leader>js <Cmd>Telescope live_grep cwd=~/.clojure/snippets<CR>
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

if executable('zprint')
  vmap <Leader>ff <Cmd>'<,'>!zprint "{:style :community}"<CR><Esc>
endif
