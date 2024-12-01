" Running ":Colorize" while the cursor is over a color string like "#aabbcc"
" (leading "#" required) will highlight that color string with a background
" color #aabbcc.
"
" If the highlight doesn't show up immediately, it might be that a different
" highlight group is prioritized. Try removing enclosing double quotes or
" other syntax.

function! Colorize(col)
  let group = 'Color_' . a:col

  execute "syntax match " . l:group ' /#' . a:col . '/hs=s+1'
  execute "highlight " . l:group . " guibg=#" . a:col
endfunction

command! -nargs=0 Colorize call Colorize(expand("<cword>"))
