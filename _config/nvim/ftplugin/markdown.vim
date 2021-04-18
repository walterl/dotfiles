setlocal autoindent
setlocal spell
setlocal conceallevel=2

nmap ]] <Plug>Markdown_MoveToNextHeader
nmap [[ <Plug>Markdown_MoveToPreviousHeader
nmap ge <Plug>Markdown_EditUrlUnderCursor
nmap <CR> ge
nmap gx <Plug>Markdown_OpenUrlUnderCursor

" Bold
vmap <C-b> S*v`>S*

" The mapping below turns GitHub issue/PR URLs into Markdown links:
" https://github.com/walterl/uroute/pull/1 -> [#1](https://github.com/walterl/uroute/pull/1)
nmap <Leader>lg EF/yEBi[#<C-r>"]<Esc>lvESbF/x

command! -buffer -nargs=0 ConvertToHTML :exe "!pandoc -t html % -o %:r.html" | :e %:r.html
