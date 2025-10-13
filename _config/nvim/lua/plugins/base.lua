return {
  -- General
  {
    'chrisbra/NrrwRgn',
    config = function()
      vim.g.nrrw_rgn_vert = 1
      vim.g.nrrw_rgn_wdth = 80
    end,
  },
  {
    'folke/which-key.nvim',
    opts = {
      plugins = {
        presets = {
          motions = false,
          operators = false,
        }
      }
    },
  },
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').setup {}
      require('leap').set_default_keymaps()
    end,
  },
  {
    'goolord/alpha-nvim',
    dependencies = { 'walterl/alpha_startify_gst' },
    config = function()
      require'alpha'.setup(require'alpha_startify_gst'.config)
    end,
  },
  {
    'hgiesel/vim-motion-sickness',
    config = function()
      vim.g['sickness#expression#use_default_maps'] = 0
      vim.g['sickness#field#use_default_maps'] = 0
    end,
  },
  'itchyny/vim-cursorword',
  'jiangmiao/auto-pairs',
  {
    'junegunn/goyo.vim',
    config = function()
      vim.g.goyo_width = 100
      vim.cmd [[
      command! WritingMode Goyo | set ft=markdown wrap | lua require('lualine').hide(); MiniMap.close()
      ]]
    end,
  },
  {
    'karb94/neoscroll.nvim',
    opts = {
      easing_function = 'quartic',
      mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' }, -- Default without <C-f>, which I remapped
    },
  },
  'nvim-tree/nvim-web-devicons',
  {
    'kylechui/nvim-surround',
    opts = {
      surrounds = {
        -- Markdown links!
        ["l"] = { add = function() return { { '[' }, { ']()' } } end },
        ["L"] = { add = function() return { { '[](' }, { ')' } } end },
      },
    },
  },
  {
    'mbbill/undotree',
    keys = {
      { '<leader>u', vim.cmd.UndotreeToggle },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      local function lsp_connection()
        if vim.tbl_isempty(vim.lsp.get_clients()) then
          return ""
        else
          return ""
        end
      end

      local function sig_hint()
        if not pcall(require, 'lsp_signature') then return "" end
        local sig = pcall(require('lsp_signature').status_line, width)
        if not sig or not sig.label or #sig.label == 0 then return "" end
        return sig.label .. " ○ "  .. sig.hint
      end

      require('lualine').setup {
        options = {
          theme = 'palenight',
          icons_enabled = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { 'mode' },
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
            { 'diff' },
            { sig_hint },
          },
          lualine_x = {
            {
              'diagnostics',
              {
                sections = { 'error', 'warn', 'info', 'hint' },
                sources = { 'nvim_lsp' },
                symbols = { error='', warn='', info='', hint='' }
              },
            },
            { lsp_connection },
          },
          lualine_y = {
            'filetype',
          },
          lualine_z = {
            { 'progress' },
            { 'location', padding = { left = 0, right = 0} },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
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
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {
          lualine_a = {{ 'tabs', mode = 2, max_length = vim.o.columns, symbols = { modified = ' ⏺' } }},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'branch' }
        },
      }
    end,
  },
  {
    'scrooloose/nerdtree',
    config = function()
      vim.g.NERDTreeIgnore = { '\\~$', '\\.exe$', '\\.py[co]$', '\\.s?o$', '\\.sw[op]$' }
      vim.g.NERDTreeShowBookmarks = 1
      vim.g.NERDTreeShowLineNumbers = 1
    end,
    keys = {
      { '<F2>', '<Cmd>NERDTreeToggle<CR>', silent = true },
      { '<F3>', '<Cmd>NERDTreeToggle %<CR>', silent = true },
    },
  },
  'stevearc/dressing.nvim',
  'tpope/vim-commentary',
  'tpope/vim-dadbod',
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      {
        'kristijanhusak/vim-dadbod-completion',
        ft = { 'sql', 'mysql', 'plsql' },
        lazy = true
      },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      vim.g.db_ui_execute_on_save = 0
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_hide_schemas = { 'pg_toast.*' }
      vim.g.db_ui_table_helpers = {
        postgresql = {
          Count = 'SELECT COUNT(*) FROM "{table}"'
        },
      }
    end,
  },
  'tpope/vim-eunuch',
  'tpope/vim-repeat',
  'tpope/vim-sleuth',
  'tpope/vim-unimpaired',
  'vim-scripts/httplog',
  {
    'vim-scripts/Smart-Home-Key',
    keys = {
      { '0', '<Cmd>SmartHomeKey<CR>', silent = true },
    },
  },
  'whiteinge/diffconflicts',
  'walterl/curlod',
  { -- Completion with cmp
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp_src_menu_items = {
        buffer = 'buf',
        latex_symbols = 'texsym',
        nvim_lsp = 'lsp',
      }

      local sources = {
        { name = 'buffer' },
        { name = 'path' },
        { name = 'latex_symbols', option = { strategy = 0 } }
      }

      if not flag_is_set('nodev') then
        sources = vim.list_extend(
          {
            { name = 'nvim_lsp' },
            per_filetype = {
              codecompanion = { "codecompanion" },
            },
          },
          sources
        )
      end

      local cmp = require('cmp')
      local lspkind = require('lspkind')
      cmp.setup {
        view = {
          entries = { name = 'custom', selection_order = 'near_cursor' }
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

            if not lspkind then
              return item
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
        sources = cmp.config.sources(sources),
      }
    end,
  },
  { 'hrsh7th/cmp-buffer', dependencies = { 'hrsh7th/nvim-cmp' } },
  { 'hrsh7th/cmp-path', dependencies = { 'hrsh7th/nvim-cmp' } },
  { 'kdheepak/cmp-latex-symbols', dependencies = { 'hrsh7th/nvim-cmp' } },
  -- Colors
  {
    'catppuccin/nvim',
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin"
      require("catppuccin").setup({
        transparent_background = true,
      })
    end,
  },
  -- Git
  {
    'airblade/vim-gitgutter',
    lazy = false,
    branch = 'main',
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
    end,
    keys = {
      { '<Leader>gg', '<Cmd>GitGutterToggle<CR>' },
    },
  },
  { 'junegunn/gv.vim', dependencies = { 'tpope/vim-fugitive' } },
  {
    'junkblocker/git-time-lapse',
    keys = {
      { '<Leader>gt', '<Plug>(git-time-lapse)' },
    },
  },
  {
    'tpope/vim-fugitive',
    keys = {
      { '<Leader>gb', '<Cmd>Git blame<CR>' },
      { '<Leader>gd', '<Cmd>Gdiffsplit<CR>' },
      { '<Leader>gc', '<Cmd>Git commit<CR>' },
      { '<Leader>gs', '<Cmd>tab Git<CR>' },
    },
  },
  -- Markdown
  {
    --'davidgranstrom/nvim-markdown-preview'
    -- Until https://github.com/davidgranstrom/nvim-markdown-preview/pull/21 is merged.
    'walterl/nvim-markdown-preview',
    config = function()
      vim.g.nvim_markdown_preview_liveserver_extra_args = {
        '--browser=chromium-temp.sh',
        '--port=59999',
      }
    end,
  },
  {
    'preservim/vim-markdown',
    config = function()
      vim.g.vim_markdown_follow_anchor = 1
      vim.g.vim_markdown_strikethrough = 1
      vim.g.vim_markdown_new_list_item_indent = 2
      vim.g.vim_markdown_auto_insert_bullets = 0
    end,
  },
  'walterl/downtools',
  -- Sieve
  'vim-scripts/sieve.vim',
  -- SQL
  'shmup/vim-sql-syntax',
  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim', 'nvim-telescope/telescope-symbols.nvim' },
    config = function()
      require("telescope").setup {
        defaults = {
          file_ignore_patterns = { "node_modules" },
          scroll_strategy = "limit",
        },
        pickers = {
          find_files = {
            find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
          },
        },
      }

      local builtin = require('telescope.builtin')

      map('n', ',/', builtin.search_history, ext(noremap, { desc = "Search history" }))
      map('n', ',:', builtin.command_history, ext(noremap, { desc = "Command history" }))
      map('n', ',c', builtin.commands, ext(noremap, { desc = "Commands" }))
      map('n', ',h', builtin.help_tags, ext(noremap, { desc = "Help tags" }))
      map('n', ',m', builtin.marks, ext(noremap, { desc = "Marks" }))
      map('n', ',k', builtin.keymaps, ext(noremap, { desc = "Neovim keymaps" }))
      map('n', ',S', builtin.spell_suggest, ext(noremap, { desc = "Spelling suggestions" }))
      map('n', ',s', function()
        builtin.symbols{ sources = { 'emoji', 'kaomoji' } }
      end, ext(noremap, { desc = "Emoji" }))
      map('n', ',R', builtin.resume, ext(noremap, { desc = "Resume last search" }))

      map('n', ',b', builtin.buffers, ext(noremap, { desc = "Buffers" }))
      map('n', ',o', function()
        builtin.oldfiles{ cwd = vim.fn.getcwd(), only_cwd = false }
      end, ext(noremap, { desc = "Previously open files" }))
      map('n', ',O', builtin.oldfiles, ext(noremap, { desc = "Previously open files" }))
      map('n', ',d', function()
        builtin.find_files{ search_dirs = { "%:h" } }
      end, ext(noremap, { desc = "Files in current buffer's dir" }))
      map('n', ',f', builtin.find_files, ext(noremap, { desc = "Files in cwd" }))
      map({ 'n', 'v' }, ',F', builtin.grep_string, ext(noremap, { desc = "Grep string under cursor" }))
      map('n', ',G', builtin.live_grep, ext(noremap, { desc = "Grep string" }))
      map('n', ',e', builtin.current_buffer_fuzzy_find, ext(noremap, { desc = "Buffer lines (fuzzy)" }))

      map('n', ',j', builtin.jumplist, ext(noremap, { desc = "Jump list" }))
      map('n', ',l', builtin.loclist, ext(noremap, { desc = "Location list" }))
      map('n', ',q', builtin.quickfix, ext(noremap, { desc = "Quickfix list" }))
      map('n', ',Q', builtin.quickfixhistory, ext(noremap, { desc = "Quickfix list history" }))

      map('n', ',t', builtin.tags, ext(noremap, { desc = "Tags" }))
      map('n', ',T', builtin.current_buffer_tags, ext(noremap, { desc = "Buffer tags" }))

      map('n', ',g', builtin.git_files, ext(noremap, { desc = "Git files" }))
      map('n', ',gb', builtin.git_bcommits, ext(noremap, { desc = "Buffer's git commits" }))
      map('n', ',gs', builtin.git_status, ext(noremap, { desc = "Git status" }))
    end,
  },
}
