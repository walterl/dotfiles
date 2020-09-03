set foldmethod=syntax

" cloJure mappings
nmap <Leader>jd <Plug>FireplaceDjump
nmap <Leader>jS <Plug>FireplaceDsplit
nmap <Leader>jt <Plug>FireplaceDtabjump
nmap <Leader>jc (i#_<Esc>

" Don't automatically insert closing ' or `
let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}
let b:coc_diagnostic_disable = 1
