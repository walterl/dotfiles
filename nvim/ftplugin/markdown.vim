setlocal autoindent
setlocal spell
setlocal conceallevel=2

" {{{ FUNCTIONS from vim-markdown
function! s:JumpToHeader(forward, visual)
  let cnt = v:count1
  let save = @/
  let pattern = '\v^#{1,6}.*$|^.+\n%(\-+|\=+)$'
  if a:visual
    normal! gv
  endif
  if a:forward
    let motion = '/' . pattern
  else
    let motion = '?' . pattern
  endif
  while cnt > 0
    silent! execute motion
    let cnt = cnt - 1
  endwhile
  call histdel('/', -1)
  let @/ = save
endfunction

function! s:Indent(indent)
  if getline('.') =~ '\v^\s*%([-*+]|\d\.)\s*$'
    if a:indent
      normal >>
    else
      normal <<
    endif
    call setline('.', substitute(getline('.'), '\([-*+]\|\d\.\)\s*$', '\1 ', ''))
    normal $
  elseif getline('.') =~ '\v^\s*(\s?\>)+\s*$'
    if a:indent
      call setline('.', substitute(getline('.'), '>\s*$', '>> ', ''))
    else
      call setline('.', substitute(getline('.'), '\s*>\s*$', ' ', ''))
      call setline('.', substitute(getline('.'), '^\s\+$', '', ''))
    endif
    normal $
  endif
endfunction

function! s:IsAnEmptyListItem()
  return getline('.') =~ '\v^\s*%([-*+]|\d\.)\s*$'
endfunction

function! s:IsAnEmptyQuote()
  return getline('.') =~ '\v^\s*(\s?\>)+\s*$'
endfunction

" }}}

" Selected (modified) default mappings:
noremap <silent> <buffer> <script> ]] :<C-u>call <SID>JumpToHeader(1, 0)<CR>
noremap <silent> <buffer> <script> [[ :<C-u>call <SID>JumpToHeader(0, 0)<CR>
vnoremap <silent> <buffer> <script> ]] :<C-u>call <SID>JumpToHeader(1, 1)<CR>
vnoremap <silent> <buffer> <script> [[ :<C-u>call <SID>JumpToHeader(0, 1)<CR>
noremap <silent> <buffer> <script> ][ <nop>
noremap <silent> <buffer> <script> [] <nop>

inoremap <silent> <buffer> <script> <expr> <Tab>
      \ <SID>IsAnEmptyListItem() \|\| <SID>IsAnEmptyQuote() ? '<C-O>:call <SID>Indent(1)<CR>' : '<Tab>'
inoremap <silent> <buffer> <script> <expr> <S-Tab>
      \ <SID>IsAnEmptyListItem() \|\| <SID>IsAnEmptyQuote() ? '<C-O>:call <SID>Indent(0)<CR>' : '<Tab>'

inoremap <silent> <buffer> <script> <expr> <CR> <SID>IsAnEmptyListItem() ? '<C-O>:normal 0D<CR>' : '<CR>'
nnoremap <silent> <buffer> <C-Space> :call markdown#SwitchStatus()<CR>

nnoremap <silent> <buffer> <Leader>me :MarkdownEditBlock<CR>
