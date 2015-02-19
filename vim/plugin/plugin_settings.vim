" Settings and mappings related to plug-ins

" CtrlP
let g:ctrlp_map = ",f"
let g:ctrlp_switch_buffer = 'Et'
map <silent> ,b :CtrlPBuffer<CR>
map <silent> ,m :CtrlPMixed<CR>
map <silent> ,t :CtrlPBufTagAll<CR>
if executable("ag")
	let g:ctrp_user_command = 'ag %s -l --nocolor -g ""'
else
	let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
	let g:ctrlp_prompt_mappings = {
		\ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
		\ }
endif
" Above from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/

" NERDTree
map  <silent> <F4>      :NERDTreeToggle<CR>
imap <silent> <F4> <Esc>:NERDTreeToggle<CR>
let NERDTreeShowBookmarks = 1

" Tagbar
map  <silent> <F5>      :TagbarToggle<CR>
imap <silent> <F5> <Esc>:TagbarToggle<CR>

" VimWiki
let g:vimwiki_dir_link = 'index'
let g:vimwiki_folding = 1
let g:vimwiki_fold_lists = 1
let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checked = 1

" Tabularize maps
vmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a, :Tabularize /,<CR>

" fugitive
nmap <Leader>gs :Gstatus<CR>

" gitv
let g:Gitv_OpenHorizontal = 1
let g:Gitv_TruncateCommitSubjects = 1
nmap <Leader>gv :Gitv<CR>

" Syntastic
let g:syntastic_mode_map = {'mode': 'active', 'active_filetypes': ['javascript']}
let g:syntastic_always_populate_loc_list = 1

" Session
let g:session_autosave = 'no'

" NrrwRgn options
let g:nrrw_rgn_vert = 1 " Open narrow region windows in *vertical* splits

" Pydiction options
let g:pydiction_location = '/home/walter/.vim/bundle/pydiction/complete-dict'

" showmarks
" Note that ` and ' are switched, to replace the above (commented out) remapping.
nnoremap ` :ShowMarksOnce<CR>'
nnoremap ' :ShowMarksOnce<CR>`

" vim-airline options
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#tab_nr_type = 1

" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-]>"
let g:UltiSnipsJumpForwardTrigger="<c-]>"
let g:UltiSnipsJumpBackwardTrigger="<c-[>"
