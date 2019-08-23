" clj_clean_ns.vim
" Author: Walter Leibbrandt <https://github.com/walterl>

" This simple script uses vim-fireplace to call Refactor nREPL's `clean-ns`
" operation, and replaces the current namespace declaration with the cleaned
" one.
"
" See https://github.com/clojure-emacs/refactor-nrepl#clean-ns for more
" information on `clean-ns`.
"
" This started out as an extraction of vim-cider's `clean_ns` function into a
" working, separate, standalone file.
" https://github.com/clojure-vim/vim-cider/

" if exists('g:loaded_clj_clean_ns')
"   finish
" endif

let g:loaded_clj_clean_ns = 1

function! s:clj_clean_ns() abort
  let path = expand('%:p')
  let result = fireplace#message({'op': 'clean-ns', 'path': path}, v:t_dict)

  if has_key(result, 'error')
    let error = result.error

    let raw_idx = strridx(error, "{:type")
    if raw_idx > 0
      let error = error[:raw_idx-1]
    endif

    echo "ERROR: " . error
    return
  endif

  let is_error = 0
  let is_unknown_op = 0
  for st in result.status
    if st ==# 'error'
      let is_error = 1
    endif
    if st ==# 'unknown-op'
      let is_unknown_op = 1
    endif
  endfor

  if is_error && is_unknown_op
    echo "clean-ns operation not found. Is Refactor nREPL loaded?"
    return
  endif

  if has_key(result, 'ns') && type(result.ns) is v:t_string
    let lnum = search("^(ns")
    if lnum < 1
      echo "No namspace definition found!"
      return
    endif

    exe "normal" . string(lnum) . "gg"
    normal! d%
    let @" = result.ns
    normal! P

    return
  endif

  echo "Not sure what to do with this, so I'll leave this here: "
  echo result
endfunction

command! -buffer -nargs=0 CljCleanNS :exe s:clj_clean_ns()
