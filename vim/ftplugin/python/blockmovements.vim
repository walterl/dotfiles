" Copied from http://www.vim.org/scripts/download_script.php?src_id=9196

map  ]t   :PyBoB<CR>
vmap ]t   :<C-U>PyBOB<CR>m'gv``
map  ]e   :PyEoB<CR>
vmap ]e   :<C-U>PyEoB<CR>m'gv``

:com! PyBoB execute "normal ".PythonBoB(line('.'), -1, 1)."G"
:com! PyEoB execute "normal ".PythonBoB(line('.'), 1, 1)."G"


" Go to a block boundary (-1: previous, 1: next)
" If force_sel_comments is true, 'g:py_select_trailing_comments' is ignored
function! PythonBoB(line, direction, force_sel_comments)
  let ln = a:line
  let ind = indent(ln)
  let mark = ln
  let indent_valid = strlen(getline(ln))
  let ln = ln + a:direction
  if (a:direction == 1) && (!a:force_sel_comments) &&
      \ exists("g:py_select_trailing_comments") &&
      \ (!g:py_select_trailing_comments)
    let sel_comments = 0
  else
    let sel_comments = 1
  endif

  while((ln >= 1) && (ln <= line('$')))
    if  (sel_comments) || (match(getline(ln), "^\\s*#") == -1)
      if (!indent_valid)
        let indent_valid = strlen(getline(ln))
        let ind = indent(ln)
        let mark = ln
      else
        if (strlen(getline(ln)))
          if (indent(ln) < ind)
            break
          endif
          let mark = ln
        endif
      endif
    endif
    let ln = ln + a:direction
  endwhile

  return mark
endfunction
