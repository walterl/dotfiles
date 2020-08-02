" https://stackoverflow.com/questions/4027222/vim-use-shorter-textwidth-in-comments-and-docstrings

function! GetPythonTextWidth()
  if !exists('g:python_normal_text_width')
    let normal_text_width = 79
  else
    let normal_text_width = g:python_normal_text_width
  endif

  if !exists('g:python_comment_text_width')
    let comment_text_width = 72
  else
    let comment_text_width = g:python_comment_text_width
  endif

  let cur_syntax = synIDattr(synIDtrans(synID(line("."), col("."), 0)), "name")
  if cur_syntax == "Comment"
    return comment_text_width
  elseif cur_syntax == "String"
    " Check to see if we're in a docstring
    let lnum = line(".")
    while lnum >= 1 && (synIDattr(synIDtrans(synID(lnum, col([lnum, "$"]) - 1, 0)), "name") == "String" || match(getline(lnum), '\v^\s*$') > -1)
      if match(getline(lnum), "\\('''\\|\"\"\"\\)") > -1
        " Assume that any longstring is a docstring
        return comment_text_width
      endif
      let lnum -= 1
    endwhile
  endif

  return normal_text_width
endfunction

augroup pep8
  au!
  autocmd CursorMoved,CursorMovedI * :if &ft == 'python' | :exe 'setlocal textwidth='.GetPythonTextWidth() | :endif
augroup END
