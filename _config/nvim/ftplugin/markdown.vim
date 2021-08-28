setlocal autoindent
setlocal spell
setlocal conceallevel=2

nmap ]] <Plug>Markdown_MoveToNextHeader
nmap [[ <Plug>Markdown_MoveToPreviousHeader
nmap ge <Plug>Markdown_EditUrlUnderCursor
nmap <CR> ge
nmap gx <Plug>Markdown_OpenUrlUnderCursor

" The mapping below turns GitHub issue/PR URLs into Markdown links:
" https://github.com/walterl/uroute/pull/1 -> [#1](https://github.com/walterl/uroute/pull/1)
nmap <Leader>lg EF/yEBi[#<C-r>"]<Esc>lvESbF/x

command! -buffer -nargs=0 ConvertToHTML :exe "!pandoc -t html % -o %:r.html" | :e %:r.html

" Insert copied HTML as Markdown
if executable("xclip") && executable("pandoc")
  nmap <Leader>M :r!xclip -selection clipboard -o -t text/html \| pandoc -f html -t markdown --wrap=none 2> /dev/null<CR>
endif
