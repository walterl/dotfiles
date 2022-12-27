" A simpler alternative to vim-jack-in's :Clj command
"
" vim-jack-in uses older versions of cider-nrepl, the superfluous
" refactor-nrepl middleware, and doesn't allow for easy customisation of
" loaded middleware.
"
" This command allows me to use the aliases set up in my ~/.clojure/deps.edn:
"
" :RunClj -M:dev:mydev:nrepl+portal
"
" Based on vim-jack-in.

function! s:warn(str) abort
  echohl WarningMsg
  echomsg a:str
  echohl None
  let v:warningmsg = a:str
endfunction

" opts:
" - is_bg: switch to new terminal window unless true
" - title: Window title, set with ':file'
" - tabnew_count: [count] for ':tabnew'
function! s:RunRepl(cmd, opts) abort
  let is_bg = get(a:opts, 'is_bg')
  let title = get(a:opts, 'title', '[REPL]')
  let tabnew_count = get(a:opts, 'tabnew_count', '')

  if !has('nvim')
    call s:warn('Neovim is required for RunClj')
    return
  endif

  execute l:tabnew_count . "tabnew"

  call termopen(a:cmd)

  if !empty(l:title)
    execute "file" l:title
  endif

  if l:is_bg
    tabnext #
  endif
endfunction

function! s:RunClj(is_bg, ...)
  let l:cmd = 'clj ' . join(a:000, ' ')
  call s:RunRepl(l:cmd, { 'is_bg': a:is_bg, 'tabnew_count': 0 })
endfunction

command! -bang -nargs=* RunClj call s:RunClj(<bang>0,<q-args>)
