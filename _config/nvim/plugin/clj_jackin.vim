" A _much_ simpler alternative to vim-jack-in's :Clj command
"
" vim-jack-in uses older versions of cider-nrepl, the superfluous
" refactor-nrepl middleware, and doesn't allow for easy customisation of
" loaded middleware.
"
" This command allows me to use the aliases set up in my ~/.clojure/deps.edn:
"
" :RunClj -M:dev:mydev:nrepl+portal

function! s:RunRepl(cmd, is_bg) abort
  if exists(':Start') == 2
    execute 'Start' . (a:is_bg ? '!' : '') a:cmd
  else
    call s:warn('dispatch.vim not installed, please install it.')
    if has('nvim')
      call s:warn('neovim detected, falling back on termopen()')
      tabnew
      call termopen(a:cmd)
      tabprevious
    endif
  endif
endfunction

function! s:RunClj(is_bg, ...)
  let l:cmd = 'clj ' . join(a:000, ' ')
  call s:RunRepl(l:cmd, a:is_bg)
endfunction

command! -bang -nargs=* RunClj call s:RunClj(<bang>0,<q-args>)
