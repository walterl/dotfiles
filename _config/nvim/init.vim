" {{{ General settings
nnoremap <Space> <NOP>
let mapleader = "\<Space>"
let maplocalleader = "\<BS>"

set completeopt=menuone,preview,noselect
set ignorecase                           " case insensitive search
set smartcase                            " smart search case
set relativenumber                       " show relative line numbers
set number                               " show current line number
set nowrap                               " Don't wrap lines
set showbreak=↪                          " But when wrapped, show nice linebreak char
set hlsearch                             " Highlight matches as you type
set cursorline                           " Highlight the cursor line
set cursorcolumn                         " Highlight the cursor column
set listchars=tab:»—,trail:⋅,nbsp:⋄      " Show tabs and trailing characters
set list
set winwidth=80                          " Windows will always be at least 80 chars (if possible)
set tabstop=4
set softtabstop=4
set shiftwidth=4
set report=0                             " Notify me whenever any lines have changed
set confirm                              " Y-N-C prompt if closing with unsaved changes
set showmatch                            " Briefly jump to the previous matching paren
set timeoutlen=500                       " Lowers leader and command timeout
set directory=~/.local/share/nvim/tmp
set nobackup                             " Don't create backup files
set nowritebackup                        " Don't create write backups
set noswapfile                           " Don't create swap files
set splitbelow                           " Split windows below the current window
set splitright                           " Split vertical windows on the right
set updatetime=2000
set pumblend=20                          " Transparency for pop-up menu
set winblend=20                          " Transparency for floating windows
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Environment

" Run the following for non-dev users
" echo export NVIM_ENV_FLAGS="nodev" >> ~/.zshrc.local

let g:nvim_env_flags = split($NVIM_ENV_FLAGS)

function! s:flag_is_set(flag)
  return index(g:nvim_env_flags, a:flag) > -1
endfunction

function! HasPlugin(plugin)
  return index(keys(g:plugs), a:plugin) > -1
endfunction

" And Lua versions
lua <<EOF
function flag_is_set(flag)
  return vim.tbl_contains(vim.g.nvim_env_flag or {}, flag)
end

function has_plugin(plugin)
  vim.tbl_contains(vim.tbl_keys(vim.g.plugs or {}), plugin)
end
EOF
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Plugins
call plug#begin('~/.local/share/nvim/site/plugged')
  " General
  Plug 'chrisbra/NrrwRgn'
  Plug 'junegunn/goyo.vim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'hgiesel/vim-motion-sickness'
  Plug 'itchyny/vim-cursorword'
  Plug 'jiangmiao/auto-pairs'
  Plug 'kylechui/nvim-surround'
  Plug 'liuchengxu/vim-which-key'
  Plug 'machakann/vim-highlightedyank'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'scrooloose/nerdtree'
  Plug 'stevearc/dressing.nvim'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-dadbod'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sleuth'
  Plug 'vim-scripts/httplog'
  Plug 'vim-scripts/Smart-Home-Key'
  Plug 'whiteinge/diffconflicts'

  " Completion with cmp
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'

  " Colors
  Plug 'drewtempelmeyer/palenight.vim'

  "" Git
  Plug 'airblade/vim-gitgutter'
  Plug 'junegunn/gv.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'vim-scripts/git-time-lapse'

  " Sieve
  Plug 'vim-scripts/sieve.vim'

  " SQL
  Plug 'shmup/vim-sql-syntax'

  " Telescope
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-telescope/telescope.nvim'

  if !s:flag_is_set('nodev')
    Plug 'AndrewRadev/sideways.vim'
    Plug 'AndrewRadev/splitjoin.vim'
    Plug 'knsh14/vim-github-link'
    Plug 'luochen1990/rainbow'
    Plug 'neovim/nvim-lspconfig'
    "Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'tpope/vim-projectionist'
    Plug 'w0rp/ale'
    Plug 'walterl/centerfold'

    " cmp
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'PaterJason/cmp-conjure'

    " Clojure
    Plug 'clojure-vim/clojure.vim'
    Plug 'guns/vim-clojure-highlight'
    Plug 'Olical/conjure'
    Plug 'walterl/conjure-macroexpand'
    "" vim-jack-in
    Plug 'tpope/vim-dispatch'
    Plug 'radenling/vim-dispatch-neovim'
    Plug 'clojure-vim/vim-jack-in'
    "" sexp
    Plug 'guns/vim-sexp'
    Plug 'tpope/vim-sexp-mappings-for-regular-people'

    " Fennel
    Plug 'Olical/aniseed'
    Plug 'bakpakin/fennel.vim'

    " HTML
    Plug 'mattn/emmet-vim'

    " Markdown
    "Plug 'davidgranstrom/nvim-markdown-preview'
    " Until https://github.com/davidgranstrom/nvim-markdown-preview/pull/21 is
    " merged.
    Plug 'walterl/nvim-markdown-preview', { 'branch': 'set-liveserver-root' }
    Plug 'plasticboy/vim-markdown'
    Plug 'walterl/downtools'

    " Terraform
    Plug 'hashivim/vim-terraform'
  endif
call plug#end()
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Plugin config
if HasPlugin('ale')
  nmap [a <Cmd>ALEPrevious<CR>
  nmap ]a <Cmd>ALENext<CR>
endif

if HasPlugin('centerfold')
  nmap <silent> <Leader>jj vaF<Cmd>CenterFold<CR>zCzO
endif

if HasPlugin('conjure')
  let g:conjure#mapping#doc_word = "K"
  let g:conjure#client#clojure#nrepl#eval#auto_require = v:false
  let g:conjure#client#clojure#nrepl#connection#auto_repl#enabled = v:false
  let g:conjure#log#hud#height = 0.6
  let g:conjure#client#clojure#nrepl#completion#with_context = v:false

  imap <C-k> <Cmd>ConjureDocWord<CR>

  autocmd BufEnter conjure-log-* setlocal winhighlight=Normal:lualine_c_normal
endif

if HasPlugin('git-time-lapse')
  nmap <Leader>gt <Cmd>call TimeLapse()<CR>
endif

if HasPlugin('lualine.nvim')
lua <<EOF
  local function lsp_connection()
    if vim.tbl_isempty(vim.lsp.buf_get_clients(0)) then
      return ""
    else
      return ""
    end
  end

  require('lualine').setup {
    options = {
      theme = 'palenight',
      icons_enabled = true,
      section_separators = {"", ""},
      component_separators = {"", ""},
    },
    sections = {
      lualine_a = {},
      lualine_b = { {'mode', { upper = true }} },
      lualine_c = { {'FugitiveHead'}, {'filename', { filestatus = true, path = 1 }} },
      lualine_x = {
        {
          "diagnostics",
          {
            sections = {'error', 'warn', 'info', 'hint'},
            sources = {'nvim_lsp'},
          },
        },
        {lsp_connection},
        'location',
        'filetype',
      },
      lualine_y = {'encoding'},
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { {'filename', { filestatus = true, path = 1 }} },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  }
EOF
endif

if HasPlugin('nerdtree')
  map <silent> <F2> <Cmd>NERDTreeToggle<CR>

  let NERDTreeIgnore=['\~$', '\.exe$', '\.py[co]$', '\.s?o$', '\.sw[op]$']
  let NERDTreeShowBookmarks = 1
endif

if HasPlugin('NrrwRgn')
  let g:nrrw_rgn_vert = 1
  let g:nrrw_rgn_wdth = 80
endif

if HasPlugin('nvim-cmp')
lua <<EOF
  local cmp_src_menu_items = {
    buffer = 'buff',
    conjure = 'conj',
    nvim_lsp = 'lsp',
    path = 'path',
  }

  local cmp_srcs = {{name = 'buffer'}, {name = 'path'}}
  if not flag_is_set('nodev') then
    cmp_srcs = vim.list_extend(cmp_srcs, {{name = 'nvim_lsp'}, {name = 'conjure'}})
  end

  local cmp = require('cmp')
  cmp.setup {
    formatting = {
      format = function(entry, item)
        item.menu = cmp_src_menu_items[entry.source] or ''
        return item
      end,
    },
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert }),
    },
    sources = cmp_srcs,
  }
EOF
endif

if HasPlugin('nvim-markdown-preview')
  let g:nvim_markdown_preview_liveserver_extra_args = [
        \ '--browser=chromium-temp.sh',
        \ '--port=59999']
endif

if HasPlugin('nvim-lspconfig')
lua <<EOF
  local config = {
    handlers = {
      ['textDocument/publishDiagnostics'] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            severity_sort = true,
            update_in_insert = false,
            underline = true,
            virtual_text = false,
        }
      ),
      ['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = 'single' }
      ),
      ['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = 'single' }
      ),
    },
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(_client, bufnr)
      opts = { noremap = true }
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>ld', "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lt', "<Cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lh', "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>ln', "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>le', "<Cmd>lua vim.diagnostic.open_float()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lq', "<Cmd>lua vim.diagnostic.setloclist()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lf', "<Cmd>lua vim.lsp.buf.formatting()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lj', "<Cmd>lua vim.diagnostic.goto_next({ wrap = false })<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lk', "<Cmd>lua vim.diagnostic.goto_prev({ wrap = false })<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>la', "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'v', '<Leader>la', [[<Cmd>'<,'>vim.lsp.buf.code_action()<CR>]], opts)
      -- Telescope
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lw', "<Cmd>lua require('telescope.builtin').diagnostics()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lr', "<Cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>li', "<Cmd>lua require('telescope.builtin').lsp_implementations()<CR>", opts)
    end,
  }
  require('lspconfig').clojure_lsp.setup(config)
  require('lspconfig').pylsp.setup(config)
  require('lspconfig').tsserver.setup(config)
EOF
endif

if HasPlugin('nvim-surround')
  lua require('nvim-surround').setup {}
endif

if HasPlugin('nvim-treesitter')
  " https://github.com/nvim-treesitter/nvim-treesitter#folding
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()

lua <<EOF
  require('nvim-treesitter.configs').setup {
    highlight = {enable = true},
    indent = {enable = true},
    ensure_installed = {'clojure'},
  }
EOF
endif

if HasPlugin('rainbow')
  let g:rainbow_active = 1 " Toggle with :RainbowToggle
  let g:rainbow_conf = {'guifgs': ['DeepSkyBlue', 'darkorange3', 'LawnGreen', 'ivory1', 'firebrick', 'MistyRose1', 'maroon1']}
endif

if HasPlugin('sideways.vim')
  nnoremap <Leader>ah <Cmd>SidewaysLeft<CR>
  nnoremap <Leader>al <Cmd>SidewaysRight<CR>
endif

if HasPlugin('Smart-Home-Key')
  " Use SmartHomeKey to toggle between ^ and 0
  nmap <silent> 0 <Cmd>SmartHomeKey<CR>
endif

if HasPlugin('telescope.nvim')
lua <<EOF
  require("telescope").setup {
    defaults = {
      file_ignore_patterns = {"node_modules"},
    },
    pickers = {
      find_files = {
        find_command = {"rg", "--files", "--iglob", "!.git", "--hidden"},
      },
    },
  }
EOF

  nnoremap ,/ <Cmd>Telescope search_history<CR>
  nnoremap ,: <Cmd>Telescope command_history<CR>
  nnoremap ,h <Cmd>Telescope help_tags<CR>
  nnoremap ,R <Cmd>Telescope resume<CR>

  nnoremap ,b <Cmd>Telescope buffers<CR>
  nnoremap ,B <Cmd>Telescope oldfiles<CR>
  nnoremap ,d <Cmd>Telescope find_files search_dirs=["%:h"]<CR>
  nnoremap ,f <Cmd>Telescope find_files<CR>
  nnoremap ,G <Cmd>Telescope live_grep<CR>
  nnoremap ,L <Cmd>Telescope current_buffer_fuzzy_find<CR>

  nnoremap ,j <Cmd>Telescope jumplist<CR>
  nnoremap ,l <Cmd>Telescope loclist<CR>
  nnoremap ,q <Cmd>Telescope quickfix<CR>

  nnoremap ,t <Cmd>Telescope tags<CR>
  nnoremap ,T <Cmd>Telescope current_buffer_tags<CR>

  nnoremap ,g <Cmd>Telescope git_files<CR>
  nnoremap ,gb <Cmd>Telescope git_bcommits<CR>
  nnoremap ,gs <Cmd>Telescope git_status<CR>

  " https://github.com/nvim-telescope/telescope.nvim/issues/991#issuecomment-882059894
  autocmd! FileType TelescopeResults setlocal nofoldenable
endif

"" toggle_words.vim
nmap <silent> <Leader>T <Cmd>ToggleWord<CR>

if HasPlugin('vim-fugitive')
  nmap <Leader>gb <Cmd>Git blame<CR>
  nmap <Leader>gd <Cmd>Gdiffsplit<CR>
  nmap <Leader>gc <Cmd>Git commit<CR>
  nmap <Leader>gs <Cmd>tab Git<CR>
endif

if HasPlugin('vim-gitgutter')
  nmap <Leader>gg <Cmd>GitGutterToggle<CR>
endif

if HasPlugin('vim-github-link')
  vmap <Leader>YB <Cmd>GetCurrentBranchLink<CR>
  vmap <Leader>YC <Cmd>GetCurrentCommitLink<CR>
endif

if HasPlugin('vim-markdown')
  let g:vim_markdown_follow_anchor = 1
  let g:vim_markdown_strikethrough = 1
  let g:vim_markdown_new_list_item_indent = 2
  let g:vim_markdown_auto_insert_bullets = 0
endif

if HasPlugin('vim-sexp')
  let g:sexp_enable_insert_mode_mappings = 0
  let g:sexp_filetypes = "clojure,scheme,lisp,timl,fennel,janet"
endif

if HasPlugin('vim-sexp-mappings-for-regular-people')
  " Swap multiple selected elements:
  vmap <e <Plug>(sexp_swap_element_backward)
  vmap >e <Plug>(sexp_swap_element_forward)
endif

if HasPlugin('vim-which-key')
  nnoremap <silent> <Leader> :WhichKey '<C-v><Leader>'<CR>
  nnoremap <silent> <LocalLeader> :WhichKey '<C-v><LocalLeader>'<CR>
  nnoremap <silent> , :WhichKey '<C-v>,'<CR>
endif
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Color scheme settings
" Settings related to the color scheme
if has('termguicolors')
  set termguicolors
endif

" Enable italics
let g:palenight_terminal_italics = 1

" Slightly lighter (and bluer) grey, to increase contrast with dark/greyish backgrounds
let g:palenight_color_overrides = {
  \ "comment_grey": { "gui": "#7583D1", "cterm": "59", "cterm16": "15" }
  \}

" Load color scheme
colorscheme palenight

" Make background transparent
hi Normal guibg=NONE ctermbg=NONE
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Mappings
" Center cursor after jumping
nmap g; g;zvzz
nmap g, g,zvzz
nmap n nzvzz
nmap N Nzvzz
nmap * *zvzz

" Cut/Copy/Paste shortcuts
vnoremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader><S-p> "+P
vnoremap <Leader>x "+x

" Move to end of yanked/pasted text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Switch windows
nnoremap <C-Left> <C-w>h
nnoremap <C-Right> <C-w>l
nnoremap <C-Up> <C-w>k
nnoremap <C-Down> <C-w>j

" Switch tabs
nnoremap [r gT
nnoremap ]r gt

" Move tabs left/right
nmap <C-S-PageUp> <Cmd>tabm -<CR>
nmap <C-S-PageDown> <Cmd>tabm +<CR>

" Duplicate tab
nmap <Leader>td <Cmd>tab split<CR>
" New tab
nmap <Leader>tn <Cmd>tabe<CR>

" Search in visual selection
vnoremap / <Esc>/\%V

" Reselect visual selection after indent
vnoremap < <gv
vnoremap > >gv

" Buffers
nmap <Leader>q <Cmd>q<CR>
nmap <Leader>w <Cmd>w<CR>
nmap <Leader>e <Cmd>w<CR>
nmap <Leader>wq <Cmd>wq<CR>
nmap <Leader>x <Cmd>bdelete<CR>
" Switch to previous buffer
nnoremap <Leader>/ <Cmd>e#<CR>

" Window splitting
nmap <Leader>S <Cmd>split<CR>
nmap <Leader>V <Cmd>vsplit<CR>

" Toggle folds
nnoremap <C-f> za

" Open all folds for top-level fold under the cursor
nmap zB zCzO

" Change working directory to the current file's directory
" (http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file)
nnoremap <Leader>cd <Cmd>cd %:p:h<CR><Cmd>pwd<CR>
nnoremap <Leader>c. <Cmd>cd ..<CR><Cmd>pwd<CR>

" Quickfix and location list
nmap <silent> <Leader>ll <Cmd>ll<CR>zvzz
nmap <silent> <Leader>ls <Cmd>call ToggleList("Location List", 'l')<CR>zvzz
nmap <silent> <Leader>cc <Cmd>cc<CR>zvzz
nmap <silent> <Leader>cs <Cmd>call ToggleList("Quickfix List", 'c')<CR>zvzz

" Move up and down by folds
map <silent> <C-j> zj
map <silent> <C-k> zk

" Go to start/end of line with H and L
" From https://github.com/SidOfc/dotfiles/blob/master/.vimrc
noremap H ^
noremap L $

" make Y consistent with C and D
" From https://github.com/SidOfc/dotfiles/blob/master/.vimrc
nnoremap Y y$

" Delete trailing spaces
nmap <silent> <Leader>ds <Cmd>%s/\s\+$//e<CR>

" Set indentations
nmap <silent> <Leader>in2 <Cmd>set ts=2 sts=2 sw=2<CR>
nmap <silent> <Leader>in4 <Cmd>set ts=4 sts=4 sw=4<CR>

" Formatting with external tools
if executable('python')
  nmap <silent> <Leader>Fj :%!python -m json.tool<CR>
endif
if executable('sqlformat')
  nmap <silent> <Leader>Fs :%!sqlformat --reindent -<CR>
endif
if executable('xmllint')
  nmap <silent> <Leader>Fx :%!xmllint --format -<CR>
endif

" Select pasted text
" (http://vim.wikia.com/wiki/Selecting_your_pasted_text)
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" grep word under cursor
" (https://github.com/nathanlong/dotfiles/blob/master/vim/vimrc)
nnoremap <Leader>GG <Cmd>grep! <C-R>=shellescape("\\b<C-R><C-W>", 1)<CR><CR><Cmd>cw<CR>
vnoremap <Leader>GG "sy<Cmd>grep! <C-R>=shellescape("\\b<C-R>s", 1)<CR><CR><Cmd>cw<CR>
nnoremap <Leader>G <Cmd>grep! <C-R>=shellescape("\\b<C-R><C-W>", 1)<CR>
vnoremap <Leader>G "sy<Cmd>grep! <C-R>=shellescape("\\b<C-R>s", 1)<CR>

" Expand %% to the current file's directory in commands. This is useful if CWD
" is "far" from the current file's directory.
" (https://github.com/nathanlong/dotfiles/blob/master/vim/vimrc)
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" Use <C-k>/<C-j> to move up/down in command history
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>

" <M-b>/<M-f> to move back/forward a word, in command mode
cnoremap <M-b> <C-Left>
cnoremap <M-f> <C-Right>

" Insert date and time
nnoremap <Leader>IT "=strftime("%Y-%m-%d %H:%M:%S")<CR>p
nnoremap <Leader>Id "=strftime("%Y-%m-%d")<CR>p
nnoremap <Leader>Iy <Cmd>r!date '+\%Y-\%m-\%d' -d yesterday<CR>
nnoremap <Leader>It "=strftime("%H:%M:%S")<CR>p

" Line text objects
xnoremap il g_o^
omap il <Cmd>normal vil<CR>
xnoremap al $o0
omap al <Cmd>normal val<CR>
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Abbreviations
" Typing aides
iabbrev improt import
iabbrev fucntion function
iabbrev Noen None
iabbrev NOne None
iabbrev sefl self
iabbrev :shrug: ¯\_(ツ)_/¯
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Use ag/ack-grep for the :grep command
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
elseif executable('ack-grep')
  set grepprg=ack-grep\ --nogroup\ --nocolor
endif
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Persist undo
" From http://nathan-long.com/blog/vim-a-few-of-my-favorite-things/
if exists('&undodir')
  set undofile
  let &undodir=&directory
  set undolevels=500
  set undoreload=500
endif
" }}}

" vim:fdm=marker:sw=2
