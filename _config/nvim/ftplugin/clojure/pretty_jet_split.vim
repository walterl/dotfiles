" @daveyarwood's improvements from https://github.com/daveyarwood/dotfiles/blob/c0a8316978872f45c5eebfe7218cd99708846a40/vim/custom/300-filetypes.vim#L57-L70
" "If all else fails, macro it up 8-)" - @walterl
"
" Adapted from @walterl's macro:
" :vmap <leader>E y:vnew<CR>P:set ft=clojure <Bar> %!jet --pretty<CR>zR
"
" Opens a new clojure buffer in a split containing the prettified EDN

if !executable('jet')
  echo "jet not found"
  finish
endif

function! PrettyJetSplit() abort
  vnew
  normal! p
  set ft=clojure
  nnoremap <buffer> q :bdel!<CR>
  %!jet --pretty
  normal! zR
endfunction

vnoremap <silent> <leader>E y<Cmd>call PrettyJetSplit()<CR>
" Shortcut: in normal mode, placing your cursor inside the top level of an EDN
" map and using this mapping results in visually selecting the EDN map and doing
" the PrettyJetSplit thing above.
nnoremap <silent> <leader>EF va}y<Cmd>call PrettyJetSplit()<CR>
