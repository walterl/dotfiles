local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use_dev = function(x)
    if not flag_is_set('nodev') then
      use(x)
    end
  end

  use {
    'wbthomason/packer.nvim',
    config = function()
      vim.cmd [[
      augroup packer_user_config
        autocmd!
        autocmd BufWritePost init.lua source <afile> | PackerCompile
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
      augroup end
      ]]
    end,
  }

  -- General
  use {
    'alvarosevilla95/luatab.nvim',
    config = function()
      require('luatab').setup {}
    end,
  }

  use {
    'chrisbra/NrrwRgn',
    config = function()
      vim.g.nrrw_rgn_vert = 1
      vim.g.nrrw_rgn_wdth = 80
    end,
  }

  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup {
        plugins = {
          presets = {
            motions = false,
            operators = false,
          }
        }
      }
    end,
  }

  use {
    'ggandor/leap.nvim',
    config = function()
      require('leap').setup {}
      require('leap').set_default_keymaps()
    end,
  }

  use {
    'goolord/alpha-nvim',
    config = function()
      require'alpha'.setup(require'alpha.themes.startify'.config)
    end,
  }

  use {
    'hgiesel/vim-motion-sickness',
    config = function()
      vim.g['sickness#expression#use_default_maps'] = 0
      vim.g['sickness#field#use_default_maps'] = 0
    end,
  }

  use 'itchyny/vim-cursorword'

  use 'jiangmiao/auto-pairs'

  use {
    'junegunn/goyo.vim',
    config = function()
    end,
  }

  use 'kyazdani42/nvim-web-devicons'

  use {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup {}
    end,
  }

  use {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require('hlslens').setup()

      local kopts = {noremap = true, silent = true}

      vim.api.nvim_set_keymap('n', 'n',
        [[<Cmd>execute('normal! ' . v:count1 . 'nzvzz')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts)
      vim.api.nvim_set_keymap('n', 'N',
        [[<Cmd>execute('normal! ' . v:count1 . 'Nzvzz')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts)
      vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    end,
  }

  use 'machakann/vim-highlightedyank'

  use {
    'nvim-lualine/lualine.nvim',
    config = function()
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
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {
            {
              'filename',
              filestatus = true,
              path = 1,
              symbols = {
                modified = " ",
                readonly = " ",
                unnamed = "  "
              },
            },
          },
          lualine_c = {
            {'branch', icon = ""},
            {'diff'},
          },
          lualine_x = {
            {
              'diagnostics',
              {
                sections = {'error', 'warn', 'info', 'hint'},
                sources = {'nvim_lsp'},
                symbols = {error='', warn='', info='', hint=''}
              },
            },
            {lsp_connection},
          },
          lualine_y = {
            'filetype',
          },
          lualine_z = {
            {'progress'},
            {'location', padding = { left = 0, right = 0}},
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {{'filename', filestatus = true, path = 1}},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  }

  use {
    'scrooloose/nerdtree',
    config = function()
      map('', '<F2>', '<Cmd>NERDTreeToggle<CR>', silent)
      vim.g.NERDTreeIgnore = {'\\~$', '\\.exe$', '\\.py[co]$', '\\.s?o$', '\\.sw[op]$'}
      vim.g.NERDTreeShowBookmarks = 1
    end,
  }

  use 'stevearc/dressing.nvim'

  use 'tpope/vim-commentary'

  use 'tpope/vim-dadbod'

  use 'kristijanhusak/vim-dadbod-ui'

  use 'tpope/vim-eunuch'

  use 'tpope/vim-repeat'

  use 'tpope/vim-sleuth'

  use 'tpope/vim-unimpaired'

  use 'vim-scripts/httplog'

  use {
    'vim-scripts/Smart-Home-Key',
    config = function()
      map('n', '0', '<Cmd>SmartHomeKey<CR>', silent)
    end,
  }

  use 'whiteinge/diffconflicts'

  use 'walterl/curlod'

  -- Completion with cmp
  use {
    'hrsh7th/nvim-cmp',
    config = function()
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
        snippet = {
          expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
          end,
        },
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
    end,
  }
  use {'hrsh7th/cmp-buffer', requires = 'hrsh7th/nvim-cmp'}
  use {'hrsh7th/cmp-path', requires = 'hrsh7th/nvim-cmp'}

  -- Colors
  use {
    'drewtempelmeyer/palenight.vim',
    config = function()
      -- Enable italics
      vim.g.palenight_terminal_italics = 1

      -- Slightly lighter (and bluer) grey, to increase contrast with dark/greyish backgrounds
      vim.g.palenight_color_overrides = {
        comment_grey = { gui = "#7583D1", cterm = 59, cterm16 = 15},
        cursor_grey = { gui = "#232830", cterm = 236, cterm16 = 8 },
      }

      -- Load color scheme
      vim.cmd [[colorscheme palenight]]
      -- Make background transparent
      vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE', ctermbg = 'NONE' })
      -- Make floating windows a bit more pronounced
      vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#4B5263', bg = '#2C323C', ctermbg = 237 })
      -- Color window separators the same as inactive status lines
      vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#3E4452', bg = '#3E4452', ctermbg = 237 })
    end,
  }
  --use 'srcery-colors/srcery-vim'

  -- Git
  use {
    'airblade/vim-gitgutter',
    config = function()
      vim.g.gitgutter_floating_window_options = {
        relative = 'cursor',
        row = 1,
        col = 0,
        width = 42,
        height = vim.api.nvim_get_option('previewheight'),
        style = 'minimal',
        border = 'rounded',
      }
      map('n', '<Leader>gg', '<Cmd>GitGutterToggle<CR>')
    end,
  }

  use 'junegunn/gv.vim'

  use {
    'tpope/vim-fugitive',
    config = function()
      map('n', '<Leader>gb', '<Cmd>Git blame<CR>')
      map('n', '<Leader>gd', '<Cmd>Gdiffsplit<CR>')
      map('n', '<Leader>gc', '<Cmd>Git commit<CR>')
      map('n', '<Leader>gs', '<Cmd>tab Git<CR>')
    end,
  }

  use {
    'vim-scripts/git-time-lapse',
    config = function()
      map('n', '<Leader>gt', '<Cmd>call TimeLapse()<CR>')
    end,
  }

  -- Markdown
  use {
    --'davidgranstrom/nvim-markdown-preview'
    -- Until https://github.com/davidgranstrom/nvim-markdown-preview/pull/21 is merged.
    'walterl/nvim-markdown-preview',
    config = function()
      vim.g.nvim_markdown_preview_liveserver_extra_args = {
        '--browser=chromium-temp.sh',
        '--port=59999',
      }
    end,
  }

  use {
    'preservim/vim-markdown',
    config = function()
      vim.g.vim_markdown_follow_anchor = 1
      vim.g.vim_markdown_strikethrough = 1
      vim.g.vim_markdown_new_list_item_indent = 2
      vim.g.vim_markdown_auto_insert_bullets = 0
    end,
  }

  use 'walterl/downtools'

  -- Sieve
  use 'vim-scripts/sieve.vim'

  -- SQL
  use 'shmup/vim-sql-syntax'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim', 'nvim-telescope/telescope-symbols.nvim'},
    config = function()
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

      map('n', ',/', '<Cmd>Telescope search_history<CR>', noremap)
      map('n', ',:', '<Cmd>Telescope command_history<CR>', noremap)
      map('n', ',c', '<Cmd>Telescope commands<CR>', noremap)
      map('n', ',h', '<Cmd>Telescope help_tags<CR>', noremap)
      map('n', ',m', '<Cmd>Telescope marks<CR>', noremap)
      map('n', ',s', function()
        require'telescope.builtin'.symbols{ sources = {'emoji', 'kaomoji'} }
      end, noremap)
      map('n', ',R', '<Cmd>Telescope resume<CR>', noremap)

      map('n', ',b', '<Cmd>Telescope buffers<CR>', noremap)
      map('n', ',B', '<Cmd>Telescope oldfiles<CR>', noremap)
      map('n', ',d', '<Cmd>Telescope find_files search_dirs=["%:h"]<CR>', noremap)
      map('n', ',f', '<Cmd>Telescope find_files<CR>', noremap)
      map('n', ',G', '<Cmd>Telescope live_grep<CR>', noremap)
      map('n', ',L', '<Cmd>Telescope current_buffer_fuzzy_find<CR>', noremap)

      map('n', ',j', '<Cmd>Telescope jumplist<CR>', noremap)
      map('n', ',l', '<Cmd>Telescope loclist<CR>', noremap)
      map('n', ',q', '<Cmd>Telescope quickfix<CR>', noremap)

      map('n', ',t', '<Cmd>Telescope tags<CR>', noremap)
      map('n', ',T', '<Cmd>Telescope current_buffer_tags<CR>', noremap)

      map('n', ',g', '<Cmd>Telescope git_files<CR>', noremap)
      map('n', ',gb', '<Cmd>Telescope git_bcommits<CR>', noremap)
      map('n', ',gs', '<Cmd>Telescope git_status<CR>', noremap)

      -- https://github.com/nvim-telescope/telescope.nvim/issues/991#issuecomment-882059894
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'TelescopeResults',
        callback = function() vim.bo.foldenable = false end
      })
    end,
  }

  --- Development plugins

  use_dev {
    'AndrewRadev/sideways.vim',
    config = function()
      map('n', '<Leader>ah', '<Cmd>SidewaysLeft<CR>', noremap)
      map('n', '<Leader>al', '<Cmd>SidewaysRight<CR>', noremap)
    end,
  }

  use_dev 'AndrewRadev/splitjoin.vim'

  use_dev {
    'knsh14/vim-github-link',
    config = function()
      map('v', '<Leader>YB', '<Cmd>GetCurrentBranchLink<CR>')
      map('v', '<Leader>YC', '<Cmd>GetCurrentCommitLink<CR>')
    end,
  }

  use_dev {
    'luochen1990/rainbow',
    diable = true,
    config = function()
      vim.g.rainbow_active = 1 -- Toggle with :RainbowToggle
      vim.g.rainbow_conf = {guifgs = {'DeepSkyBlue', 'darkorange3', 'LawnGreen', 'ivory1', 'firebrick', 'MistyRose1', 'maroon1'}}
    end,
  }

  use_dev {
    'neovim/nvim-lspconfig',
    config = function()
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
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        on_attach = function(_client, bufnr)
          function tel_builtin_fn(fn_name)
            return function() require('telescope.builtin')[fn_name]() end
          end
          opts = { noremap = true, buffer = bufnr }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('i', '<C-j>', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<Leader>lr', tel_builtin_fn('lsp_references'), opts)
          vim.keymap.set('n', '<Leader>lR', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<Leader>li', tel_builtin_fn('lsp_implementations'), opts)
          vim.keymap.set('n', '<Leader>ld', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', '<Leader>lt', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<Leader>lh', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<Leader>ln', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<Leader>lw', tel_builtin_fn('diagnostics'), opts)
          vim.keymap.set('n', '<Leader>le', vim.diagnostic.open_float, opts)
          vim.keymap.set('n', '<Leader>lq', vim.diagnostic.setloclist, opts)
          vim.keymap.set('n', '<Leader>lj', function() vim.diagnostic.goto_next({ wrap = false }) end, opts)
          vim.keymap.set('n', '<Leader>lk', function() vim.diagnostic.goto_prev({ wrap = false }) end, opts)
          vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.formatting, opts)
          vim.keymap.set('n', '<Leader>la', vim.lsp.buf.code_action, opts)
          vim.keymap.set('v', '<Leader>la', [[<Cmd>'<,'>lua vim.lsp.buf.code_action()<CR>]], opts)
          vim.keymap.set('n', '<Leader>ly', tel_builtin_fn('lsp_document_symbols'), opts)
          vim.keymap.set('n', '<Leader>lY', tel_builtin_fn('lsp_workspace_symbols'), opts)
        end,
      }
      require('lspconfig').clojure_lsp.setup(config)
      require('lspconfig').pylsp.setup(config)
      require('lspconfig').tsserver.setup(config)

      vim.cmd [[
      sign define DiagnosticSignHint text=⍰ texthl=DiagnosticSignHint
      sign define DiagnosticSignInfo text=ⓘ texthl=DiagnosticSignInfo
      sign define DiagnosticSignWarn text=⚠ texthl=DiagnosticSignWarn
      sign define DiagnosticSignError text=✕ texthl=DiagnosticSignError
      ]]
    end,
  }

  use_dev {
    'nvim-treesitter/nvim-treesitter',
    --disable = true,
    run = ':TSUpdate',
    config = function()
      -- https://github.com/nvim-treesitter/nvim-treesitter#folding
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true,
          disable = { 'clojure' }, -- Breaks string handling: https://github.com/guns/vim-sexp/issues/31
        },
        indent = {
          enable = true,
          disable = { 'python' }, -- Doesn't work ¯\_(ツ)_/¯
        },
        ensure_installed = {'bash', 'clojure', 'javascript', 'json', 'lua', 'python', 'typescript'},
        --additional_vim_regex_highlighting = true, -- Could help with some indent/highlighting issues
      }
    end,
  }

  use_dev 'tpope/vim-projectionist'

  use_dev {
    'w0rp/ale',
    config = function()
      vim.g.ale_enabled = 0
      map('n', '[a', '<Cmd>ALEPrevious<CR>')
      map('n', ']a', '<Cmd>ALENext<CR>')
    end,
  }

  use_dev {
    'walterl/centerfold',
    config = function()
      map('n', '<Leader>jj', 'vaF:CenterFold<CR>zCzO', silent)
    end,
  }

  -- cmp
  use_dev {'hrsh7th/cmp-nvim-lsp', requires = 'hrsh7th/nvim-cmp'}

  use_dev {'PaterJason/cmp-conjure', requires = {'hrsh7th/nvim-cmp', 'Olical/conjure'}}

  --- snippet support
  use_dev {'hrsh7th/cmp-vsnip', requires = 'hrsh7th/nvim-cmp'}

  use_dev 'hrsh7th/vim-vsnip'

  -- Clojure
  use_dev 'clojure-vim/clojure.vim'

  use_dev {
    'Olical/conjure',
    config = function()
      vim.g['conjure#mapping#doc_word'] = "K"
      vim.g['conjure#client#clojure#nrepl#eval#auto_require'] = false
      vim.g['conjure#client#clojure#nrepl#connection#auto_repl#enabled'] = false
      vim.g['conjure#log#hud#height'] = 0.6
      vim.g['conjure#client#clojure#nrepl#completion#with_context'] = false

      map('i', '<C-k>', '<Cmd>ConjureDocWord<CR>')
      map('n', 'gD', '<Cmd>ConjureDefWord<CR>')

      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'conjure-log-*',
        command = 'setlocal winhighlight=Normal:lualine_c_normal',
      })
      vim.api.nvim_create_autocmd('BufNewFile', {
        pattern = 'conjure-log-*',
        callback = function() vim.diagnostic.disable(0) end
      })
    end,
  }
  use_dev {'walterl/conjure-efroot', requires = 'Olical/conjure'}
  use_dev {'walterl/conjure-macroexpand', requires = 'Olical/conjure'}
  use_dev {'walterl/conjure-locstack', requires = 'Olical/conjure'}
  use_dev {
    'walterl/conjure-tapdance',
    requires = 'Olical/conjure',
    config = function()
      map('n', '<Leader>jT', '<Cmd>TapForm<CR>', noremap_silent)
      map('n', '<Leader>jt', '<Cmd>TapWord<CR>', noremap_silent)
      map('v', '<Leader>jt', ':TapV<CR>', noremap_silent)
      map('n', '<Leader>jte', '<Cmd>TapExc<CR>', noremap_silent)
    end,
  }

  --- sexp
  use_dev {
    'guns/vim-sexp',
    config = function()
      vim.g.sexp_enable_insert_mode_mappings = 0
      vim.g.sexp_filetypes = "clojure,scheme,lisp,timl,fennel,janet"
    end,
  }

  use_dev {
    'tpope/vim-sexp-mappings-for-regular-people',
    config = function()
      -- Swap multiple selected elements:
      map('v', '<e', '<Plug>(sexp_swap_element_backward)')
      map('v', '>e', '<Plug>(sexp_swap_element_forward)')
    end,
  }

  -- Fennel
  use_dev 'Olical/aniseed'

  use_dev 'bakpakin/fennel.vim'

  -- HTML
  use_dev 'mattn/emmet-vim'

  -- Terraform
  use_dev 'hashivim/vim-terraform'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
