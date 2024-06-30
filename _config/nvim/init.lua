map = vim.keymap.set
noremap = {noremap = true}
silent = {silent = true}
noremap_silent = {noremap = true, silent = true}

function ext(a, b)
  return vim.tbl_extend('force', a, b)
end

-- {{{ General settings
map('n', '<Space>', '<NOP>', noremap)
vim.g.mapleader = ' '
vim.g.maplocalleader = vim.api.nvim_replace_termcodes("<BS>", true, true, true)

vim.opt.completeopt = {'menuone', 'preview', 'noselect'}
vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- smart search case
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.number = true -- show current line number
vim.opt.wrap = false -- Don't wrap lines
vim.opt.showbreak='↪' -- But when wrapped, show nice linebreak char
vim.opt.hlsearch = true -- Highlight matches as you type
vim.opt.cursorline = true -- Highlight the cursor line
vim.opt.cursorcolumn = true -- Highlight the cursor column
vim.opt.scrolloff = 3 -- Keep 3 lines below and above the cursor
vim.opt.listchars = {tab = '»—', trail = '⋄', nbsp = '⋅'} -- Show tabs and trailing characters
vim.opt.list = true
vim.opt.winwidth = 80 -- Windows will always be at least 80 chars (if possible)
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.report = 0 -- Notify me whenever any lines have changed
vim.opt.confirm = true -- Y-N-C prompt if closing with unsaved changes
vim.opt.showmatch = true -- Briefly jump to the previous matching paren
vim.opt.timeoutlen = 500 -- Lowers leader and command timeout
vim.opt.directory = vim.fn.expand('~/.local/share/nvim/tmp')
vim.opt.backup = false -- Don't create backup files
vim.opt.writebackup = false -- Don't create write backups
vim.opt.swapfile = false -- Don't create swap files
vim.opt.splitbelow = true -- Split windows below the current window
vim.opt.splitright = true -- Split vertical windows on the right
vim.opt.updatetime = 1000
vim.opt.pumblend = 20 -- Transparency for pop-up menu
vim.opt.winblend = 20 -- Transparency for floating windows
vim.opt.mouse = '' -- :help disable-mouse

-- Highlight trailing space
vim.cmd [[
augroup TrailingSpace
au!
  au VimEnter,WinEnter * highlight link TrailingSpaces ErrorMsg
  au VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END
]]

-- Hightlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank {higroup='Visual', timeout=300} end,
})
-- }}}

-- {{{ Environment

-- Run the following for non-dev users:
-- echo export NVIM_ENV_FLAGS="nodev" >> ~/.zshrc.local

vim.g.nvim_env_flags = vim.split((vim.env.NVIM_ENV_FLAGS or ''), "%s+")

function flag_is_set(flag)
  return vim.tbl_contains(vim.g.nvim_env_flag or {}, flag)
end
-- }}}

-- {{{ Plugins
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {{ import = "plugins" }},
  checker = { enabled = false },
})
-- }}}

-- {{{ Color scheme settings
if vim.fn.has('termguicolors') then
  vim.opt.termguicolors = true
end

vim.cmd [[
" Make background transparent
hi Normal guibg=NONE ctermbg=NONE

" Make floating windows a bit more pronounced
hi FloatBorder guifg=#4B5263 guibg=#2C323C ctermbg=237

" Color window separators the same as inactive status lines
hi WinSeparator guifg=#3E4452 guibg=#3E4452 ctermbg=237
]]
-- }}}

-- {{{ Mappings
-- Center cursor after jumping
map('n', 'g;', 'g;zvzz')
map('n', 'g,', 'g,zvzz')
-- Commented out, because it removes the very useful search count '[1/5]' ('shortmess')
map('n', 'n', 'nzvzz', silent)
map('n', 'N', 'Nzvzz')
map('n', '*', '*zvzz')

-- Cut/Copy/Paste shortcuts
map('v', '<Leader>y', '"+y', noremap)
map('n', '<Leader>p', '"+p', noremap)
map('n', '<Leader><S-p>', '"+P', noremap)
map('v', '<Leader>x', '"+x', noremap)

-- Move to end of yanked/pasted text
map('v', 'y', 'y`]', silent)
map('v', 'p', 'p`]', silent)
map('n', 'p', 'p`]', silent)

-- Switch windows
map('n', '<C-Left>', '<C-w>h', noremap)
map('n', '<C-Right>', '<C-w>l', noremap)
map('n', '<C-Up>', '<C-w>k', noremap)
map('n', '<C-Down>', '<C-w>j', noremap)

-- Switch tabs
map('n', '[r', 'gT', noremap)
map('n', ']r', 'gt', noremap)

-- Move tabs left/right
map('n', '<C-S-PageUp>', '<Cmd>tabm -<CR>')
map('n', '<C-S-PageDown>', '<Cmd>tabm +<CR>')

map('n', '<Leader>td', '<Cmd>tab split<CR>') -- Duplicate tab
map('n', '<Leader>tn', '<Cmd>tabe<CR>') -- New tab
map('n', '<Leader>.', '<Cmd>tabnext #<CR>', noremap) -- Switch to last accessed tab
map('n', '<M-1>', '<Cmd>tabfirst<CR>')
map('n', '<M-0>', '<Cmd>tablast<CR>')
for x = 2,9 do
  map('n', string.format('<M-%d>', x), string.format('<Cmd>tabnext %d<CR>', x))
end

map('v', '/', '<Esc>/\\%V', noremap) -- Search in visual selection

-- Reselect visual selection after indent
map('v', '<', '<gv', noremap)
map('v', '>', '>gv', noremap)

-- Buffers
map('n', '<Leader>q', '<Cmd>q<CR>')
map('n', '<Leader>w', '<Cmd>w<CR>')
map('n', '<Leader>e', '<Cmd>w<CR>')
map('n', '<Leader>wq', '<Cmd>wq<CR>')
map('n', '<Leader>x', '<Cmd>bdelete<CR>')
map('n', '<Leader>/', '<Cmd>e#<CR>', noremap) -- Switch to previous buffer

-- Window splitting
map('n', '<Leader>S', '<Cmd>split<CR>')
map('n', '<Leader>V', '<Cmd>vsplit<CR>')

map('n', '<C-f>', 'za', noremap) -- Toggle folds
map('n', 'zB', 'zCzO') -- Open all folds for top-level fold under the cursor

-- Move up and down by folds
map('', '<C-j>', 'zj', silent)
map('', '<C-k>', 'zk', silent)

-- Change working directory to the current file's directory
-- (http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file)
map('n', '<Leader>cd', '<Cmd>cd %:p:h<CR><Cmd>pwd<CR>', noremap)
map('n', '<Leader>c.', '<Cmd>cd ..<CR><Cmd>pwd<CR>', noremap)

-- Quickfix and location list
map('n', '<Leader>ll', '<Cmd>ll<CR>zvzz', noremap_silent)
map('n', '<Leader>ls', function() vim.call('ToggleList', 'Location List', 'l') end, noremap_silent)
map('n', '<Leader>cc', '<Cmd>cc<CR>zvzz', noremap_silent)
map('n', '<Leader>cs', function() vim.call('ToggleList', 'Quickfix List', 'c') end, noremap_silent)

-- Go to start/end of line with H and L
-- From https://github.com/SidOfc/dotfiles/blob/master/.vimrc
map('', 'H', '^', noremap)
map('', 'L', '$', noremap)

-- From https://github.com/SidOfc/dotfiles/blob/master/.vimrc
map('n', 'Y', 'y$', noremap) -- make Y consistent with C and D

map('n', '<Leader>ds', '<Cmd>%s/\\s\\+$//e<CR>', silent) -- Delete trailing spaces

-- Set indentations
map('n', '<Leader>in2', '<Cmd>set ts=2 sts=2 sw=2<CR>')
map('n', '<Leader>in4', '<Cmd>set ts=4 sts=4 sw=4<CR>')

-- Formatting with external tools
if vim.fn.executable('python') then
  map('n', '<Leader>Fj', ':%!python -m json.tool<CR>')
end
if vim.fn.executable('sqlformat') then
  map('n', '<Leader>Fs', ':%!sqlformat --reindent -<CR>')
end
if vim.fn.executable('xmllint') then
  map('n', '<Leader>Fx', ':%!xmllint --format -<CR>')
end

-- Select pasted text
-- (http://vim.wikia.com/wiki/Selecting_your_pasted_text)
map('n', 'gp', "'`[' . strpart(getregtype(), 0, 1) . '`]'", {noremap = true, expr = true})

-- grep word under cursor
-- (https://github.com/nathanlong/dotfiles/blob/master/vim/vimrc)
map('n', '<Leader>GG', '<Cmd>grep! <C-R>=shellescape("\\b<C-R><C-W>", 1)<CR><CR><Cmd>cw<CR>', noremap)
map('v', '<Leader>GG', '"sy<Cmd>grep! <C-R>=shellescape("\\b<C-R>s", 1)<CR><CR><Cmd>cw<CR>', noremap)
map('n', '<Leader>G', '<Cmd>grep! <C-R>=shellescape("\\b<C-R><C-W>", 1)<CR>', noremap)
map('v', '<Leader>G', '"sy<Cmd>grep! <C-R>=shellescape("\\b<C-R>s", 1)<CR>', noremap)

-- Expand %% to the current file's directory in commands. This is useful if CWD
-- is "far" from the current file's directory.
-- (https://github.com/nathanlong/dotfiles/blob/master/vim/vimrc)
map('c', '%%', '<C-R>=expand("%:h")."/"<CR>', noremap)

-- Use <C-k>/<C-j> to move up/down in command history
map('c', '<C-j>', '<Down>', noremap)
map('c', '<C-k>', '<Up>', noremap)

-- <M-b>/<M-f> to move back/forward a word, in command mode
map('c', '<M-b>', '<C-Left>', noremap)
map('c', '<M-f>', '<C-Right>', noremap)

-- Insert date and time
map('n', '<Leader>IT', '"=strftime("%Y-%m-%d %H:%M:%S")<CR>p',
    {noremap = true, desc = "Insert full date and time."})
map('n', '<Leader>Id', '"=strftime("%Y-%m-%d")<CR>p',
    {noremap = true, desc = "Insert current date: 2022-11-17"})
map('n', '<Leader>Iy', "<Cmd>r!date '+\\%Y-\\%m-\\%d' -d yesterday<CR>",
    {noremap = true, desc = "Insert yesterday's date: 2022-11-16"})
map('n', '<Leader>It', '"=strftime("%H:%M:%S")<CR>p',
    {noremap = true, desc = "Insert current time: 14:43:15"})

-- Line text objects
map('x', 'il', 'g_o^', noremap)
map('o', 'il', '<Cmd>normal vil<CR>')
map('x', 'al', '$o0', noremap)
map('o', 'al', '<Cmd>normal val<CR>')

-- Typing aides
vim.cmd [[
iabbrev improt import
iabbrev fucntion function
iabbrev Noen None
iabbrev NOne None
iabbrev sefl self
iabbrev :shrug: ¯\_(ツ)_/¯
]]

map('n', '<Leader>T', '<Cmd>ToggleWord<CR>', silent) -- toggle_words.vim
-- }}}

-- {{{ Miscellaneous functionality
-- Use rg/ag/ack-grep for the :grep command
if vim.fn.executable('rg') then
  -- XXX This is the default in nvim >= 0.10.0
  vim.opt.grepprg = 'rg --vimgrep -uu'
elseif vim.fn.executable('ag') then
  vim.opt.grepprg = 'ag --nogroup --nocolor'
end

-- Persist undo
-- From http://nathan-long.com/blog/vim-a-few-of-my-favorite-things/
if vim.fn.exists('&undodir') then
  vim.opt.undofile = true
  vim.opt.undodir = vim.api.nvim_get_option('directory')
  vim.opt.undolevels = 500
  vim.opt.undoreload = 500
end
-- }}}

-- vim:fdm=marker:expandtab:ts=2:sw=2:sts=2
