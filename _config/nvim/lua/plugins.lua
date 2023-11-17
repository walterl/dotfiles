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
      require('luatab').setup {
        windowCount = function(index)
          local nwins = 0
          local success, wins = pcall(vim.api.nvim_tabpage_list_wins, index)
          if success then
            for _ in pairs(wins) do nwins = nwins + 1 end
          end
          return index .. ' ' .. (nwins > 1 and '(' .. nwins .. ') ' or '')
        end,
      }
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
      require'alpha'.setup(require'alpha_startify_gst'.config)
    end,
    requires = 'walterl/alpha_startify_gst',
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

  use 'JuliaEditorSupport/julia-vim'

  use {
    'junegunn/goyo.vim',
    config = function()
      vim.cmd [[
      command! WritingMode Goyo | colorscheme palenight | set ft=markdown wrap | lua require('lualine').hide() | lua MiniMap.close()
      ]]
    end,
  }

  use {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup {
        easing_function = 'quartic',
        mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'}, -- Default without <C-f>, which I remapped
      }
    end
  }

  use 'kyazdani42/nvim-web-devicons'

  use {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup({
        surrounds = {
          -- Markdown links!
          ["l"] = { add = function() return { { '[' }, { ']()' } } end },
          ["L"] = { add = function() return { { '[](' }, { ')' } } end },
        },
      })
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
    'pappasam/nvim-repl',
    config = function()
      vim.g.repl_filetype_commands = {
        javascript = 'node',
        julia = 'julia',
        python = 'ipython',
        typescript = 'deno',
      }
      map('n', '<Leader>rt', '<Cmd>ReplToggle<CR>', noremap)
      map('n', '<Leader>rc', '<Cmd>ReplRunCell<CR>', noremap)
      map('n', '<Leader>rr', '<Plug>ReplSendLine')
      map('v', '<Leader>re', '<Plug>ReplSendVisual')
    end,
  }

  use {
    'scrooloose/nerdtree',
    config = function()
      map('', '<F2>', '<Cmd>NERDTreeToggle<CR>', silent)
      map('', '<F3>', '<Cmd>NERDTreeToggle %<CR>', silent)
      vim.g.NERDTreeIgnore = {'\\~$', '\\.exe$', '\\.py[co]$', '\\.s?o$', '\\.sw[op]$'}
      vim.g.NERDTreeShowBookmarks = 1
      vim.g.NERDTreeShowLineNumbers = 1
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
        buffer = 'buf',
        latex_symbols = 'texsym',
        nvim_lsp = 'lsp',
        nvim_lsp_signature_help = 'sig',
      }

      local sources = {
        {name = 'buffer'},
        {name = 'path'},
        {name = 'latex_symbols', option = {strategy = 0}}
      }

      if not flag_is_set('nodev') then
        sources = vim.list_extend(
          {
            {name = 'nvim_lsp'},
            {name = 'nvim_lsp_signature_help'},
          },
          sources
        )
      end

      local cmp = require('cmp')
      local lspkind = require('lspkind')
      cmp.setup {
        view = {
          entries = {name = 'custom', selection_order = 'near_cursor'}
        },
        snippet = {
          expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
          end,
        },
        formatting = {
          format = function(entry, item)
            if vim.tbl_contains({ 'path' }, entry.source.name) then
              local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
              if icon then
                item.kind = icon
                item.kind_hl_group = hl_group
                return item
              end
            end

            item.menu = cmp_src_menu_items[entry.source.name] or entry.source.name or ''
            if item.menu then
              item.menu = '[' .. item.menu .. ']'
            end

            return lspkind.cmp_format({ mode = 'symbol_text' })(entry, item)
          end,
        },
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-u>'] = cmp.mapping.select_prev_item({ count = 10 }),
          ['<C-d>'] = cmp.mapping.select_next_item({ count = 10 }),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<C-t>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert }),
        },
        sources = sources,
      }
    end,
  }
  use {'hrsh7th/cmp-buffer', requires = 'hrsh7th/nvim-cmp'}
  use {'hrsh7th/cmp-path', requires = 'hrsh7th/nvim-cmp'}
  use {'hrsh7th/cmp-nvim-lsp-signature-help', requires = 'hrsh7th/nvim-cmp'}
  use {'kdheepak/cmp-latex-symbols', requires = 'hrsh7th/nvim-cmp'}
  use {'onsails/lspkind.nvim', requires = 'hrsh7th/nvim-cmp'}

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
    'mbbill/undotree',
    config = function()
      map('n', '<leader>u', vim.cmd.UndotreeToggle)
    end
  }

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
          scroll_strategy = "limit",
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
    'ckolkey/ts-node-action',
    requires = { 'nvim-treesitter' },
    config = function()
      require("ts-node-action").setup {
        ['*'] = {
          ['arguments'] = require('ts-node-action.actions').toggle_multiline(),
        },
      }
      map('n', 'X', require("ts-node-action").node_action, { desc = "Trigger Node Action" })
    end
  }

  use_dev {
    'echasnovski/mini.map',
    branch = 'stable',
    config = function()
      local map = require('mini.map')

      map.setup {
        symbols = {
          encode = map.gen_encode_symbols.dot('4x2'),
        },
        integrations = {
          map.gen_integration.builtin_search(),
          map.gen_integration.diagnostic(),
        }
      }

      function open_minimap()
        MiniMap.open()
        vim.w.minimap_closed = 0
      end

      function close_minimap()
        MiniMap.close()
        vim.w.minimap_closed = 1
      end

      function toggle_minimap()
        MiniMap.toggle()
        if MiniMap.current.win_data[1] then
          vim.w.minimap_closed = 0
        else
          vim.w.minimap_closed = 1
        end
      end

      function on_winenter()
        if vim.w.minimap_closed and MiniMap.current.win_data[1] then
          MiniMap.close()
        else
          MiniMap.open()
        end
      end

      vim.keymap.set('n', '<Leader>mc', close_minimap, { desc = "MiniMap » Close" })
      vim.keymap.set('n', '<Leader>mf', MiniMap.toggle_focus, { desc = "MiniMap » Toggle focus" })
      vim.keymap.set('n', '<Leader>mm', toggle_minimap, { desc = "MiniMap » Toggle Open/Close" })
      vim.keymap.set('n', '<Leader>mo', open_minimap, { desc = "MiniMap » Open" })
      vim.keymap.set('n', '<Leader>mr', MiniMap.refresh, { desc = "MiniMap » Refresh" })
      vim.keymap.set('n', '<Leader>ms', MiniMap.toggle_side, { desc = "MiniMap » Toggle side" })

      vim.api.nvim_create_autocmd('WinEnter', {
        callback = on_winenter,
      })
    end,
  }

  use_dev {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require('hlslens').setup()

      local kopts = {noremap = true, silent = true}

      vim.api.nvim_set_keymap('n', 'n',
        [[<Cmd>execute('normal! ' . v:count1 . 'nzvzz')<CR><Cmd>lua require('hlslens').start(); MiniMap.refresh({}, {lines = false, scrollbar = false})<CR>]],
        kopts)
      vim.api.nvim_set_keymap('n', 'N',
        [[<Cmd>execute('normal! ' . v:count1 . 'Nzvzz')<CR><Cmd>lua require('hlslens').start(); MiniMap.refresh({}, {lines = false, scrollbar = false})<CR>]],
        kopts)
      vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start(); MiniMap.refresh({}, {lines = false, scrollbar = false})<CR>]], kopts)
      vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start(); MiniMap.refresh({}, {lines = false, scrollbar = false})<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start(); MiniMap.refresh({}, {lines = false, scrollbar = false})<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start(); MiniMap.refresh({}, {lines = false, scrollbar = false})<CR>]], kopts)
    end,
  }

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
      function ext(a, b)
        return vim.tbl_extend('force', a, b)
      end

      --- BEGIN peek_definition
      -- Based on code from https://teddit.net/r/neovim/comments/jsdox0/builtin_lsp_preview_definition_under_cursor/gbymsts/#c
      local function preview_location_callback(_, result, query)
        if result == nil or vim.tbl_isempty(result) then
          require('vim.lsp.log').info(query, 'Definition not found')
          print('Definition not found')
          return nil
        end
        if vim.tbl_islist(result) then
          vim.lsp.util.preview_location(result[1])
        else
          vim.lsp.util.preview_location(result)
        end
      end

      function peek_definition()
        local params = vim.lsp.util.make_position_params()
        return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
      end
      --- END peek_definition

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
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, ext(opts, { desc="Go to definition" }))
          vim.keymap.set('n', '<Leader>lD', peek_definition, ext(opts, { desc="Peek definition" }))
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('i', '<C-j>', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<Leader>lr', tel_builtin_fn('lsp_references'), ext(opts, { desc="LSP References" }))
          vim.keymap.set('n', '<Leader>lR', vim.lsp.buf.references, ext(opts, { desc="LSP References QF" }))
          vim.keymap.set('n', '<Leader>li', tel_builtin_fn('lsp_implementations'), ext(opts, { desc="LSP Implementations" }))
          vim.keymap.set('n', '<Leader>ld', vim.lsp.buf.declaration, ext(opts, { desc="LSP Declarations" }))
          vim.keymap.set('n', '<Leader>lt', vim.lsp.buf.type_definition, ext(opts, { desc="LSP Type Definition" }))
          vim.keymap.set('n', '<Leader>lh', vim.lsp.buf.signature_help, ext(opts, { desc="LSP Signature" }))
          vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<Leader>ln', vim.lsp.buf.rename, ext(opts, { desc="LSP Rename" }))
          vim.keymap.set('n', '<Leader>lw', tel_builtin_fn('diagnostics'), ext(opts, { desc="LSP Diagnostics" }))
          vim.keymap.set('n', '<Leader>le', vim.diagnostic.open_float, ext(opts, { desc="LSP Show diagnostic" }))
          vim.keymap.set('n', '<Leader>lq', vim.diagnostic.setloclist, ext(opts, { desc="LSP Diagnostics LocList" }))
          vim.keymap.set('n', '<Leader>lj', function() vim.diagnostic.goto_next({ wrap = false }) end, ext(opts, { desc="LSP Next diagnostic" }))
          vim.keymap.set('n', '<Leader>lk', function() vim.diagnostic.goto_prev({ wrap = false }) end, ext(opts, { desc="LSP Prev diagnostic" }))
          vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.format, ext(opts, { desc="LSP Format" }))
          vim.keymap.set('n', '<Leader>la', vim.lsp.buf.code_action, ext(opts, { desc="LSP Code action menu" }))
          vim.keymap.set('v', '<Leader>la', [[<Cmd>'<,'>lua vim.lsp.buf.code_action()<CR>]], ext(opts, { desc="LSP Code action menu" }))
          vim.keymap.set('n', '<Leader>ly', tel_builtin_fn('lsp_document_symbols'), ext(opts, { desc="LSP Doc symbols" }))
          vim.keymap.set('n', '<Leader>lY', tel_builtin_fn('lsp_workspace_symbols'), ext(opts, { desc="LSP Workspace symbols" }))
        end,
      }
      require('lspconfig').clojure_lsp.setup(config)
      require('lspconfig').julials.setup(config)
      require('lspconfig').ltex.setup(
        vim.tbl_extend('force', config, {
          filetypes = { 'tex', 'bib', 'markdown', 'rst' },
          settings = { ltex = { language = "en" } },
        })
      )
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
          disable = { 'javascript', 'python' },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_decremental = '-',
            node_incremental = '+',
            scope_incremental = '.',
          },
        },
        ensure_installed = {'bash', 'clojure', 'javascript', 'json', 'julia', 'lua', 'python', 'typescript'},
        --additional_vim_regex_highlighting = true, -- Could help with some indent/highlighting issues
      }
    end,
  }

  use_dev 'nvim-treesitter/nvim-treesitter-context'

  use_dev 'tpope/vim-projectionist'

  use_dev {
    'dense-analysis/ale',
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

  --- snippet support
  use_dev {'hrsh7th/cmp-vsnip', requires = 'hrsh7th/nvim-cmp'}

  use_dev 'hrsh7th/vim-vsnip'

  -- Clojure
  use_dev 'clojure-vim/clojure.vim'

  use_dev {
    'Olical/conjure',
    requires = 'Olical/aniseed',
    config = function()
      vim.g['conjure#mapping#doc_word'] = "K"
      vim.g['conjure#client#clojure#nrepl#eval#auto_require'] = false
      vim.g['conjure#client#clojure#nrepl#connection#auto_repl#enabled'] = false
      vim.g['conjure#log#hud#height'] = 0.6
      vim.g['conjure#client#clojure#nrepl#completion#with_context'] = false
      vim.g['conjure#filetypes'] = {
        "clojure", "fennel", "janet", "hy", "racket", "scheme", "lua", "lisp",
        "python", "rust",
      }

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
  use_dev { 'Olical/aniseed', requires = 'bakpakin/fennel.vim' }

  use_dev 'bakpakin/fennel.vim'

  -- HTML
  use_dev 'mattn/emmet-vim'

  -- Terraform
  use_dev 'hashivim/vim-terraform'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
