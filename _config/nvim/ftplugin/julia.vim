" Based on ./python/python.vim

setlocal foldminlines=2  " Don't fold single lines.

" Wrapping stuff in parens/brackets/braces, similar to vim-sexp
nmap <LocalLeader>w ysiwb
nmap <LocalLeader>e[ ysiw[
nmap <LocalLeader>e] ysiw]
nmap <LocalLeader>e{ ysiw}
nmap <LocalLeader>e} ysiw{

vmap <LocalLeader>w Sb`<
vmap <LocalLeader>e[ S[`<
vmap <LocalLeader>e] S]`<
vmap <LocalLeader>e{ S}`<
vmap <LocalLeader>e} S{`<

if exists("*AutoPairsDefine")
  au FileType julia let b:AutoPairs = AutoPairsDefine({'begin': 'end//n]'})
endif
