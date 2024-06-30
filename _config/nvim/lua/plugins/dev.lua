local dev_mode = not flag_is_set('nodev')
local is_older_than_nvim_0_10_0 = vim.version.lt(vim.version(), vim.version.parse("0.10.0"))

local specs = {
  {
    'AndrewRadev/sideways.vim',
    config = function()
      map('n', '<Leader>ah', '<Cmd>SidewaysLeft<CR>', noremap)
      map('n', '<Leader>al', '<Cmd>SidewaysRight<CR>', noremap)
    end,
  },
  'AndrewRadev/splitjoin.vim',
  {
    'ckolkey/ts-node-action',
    dependencies = {'nvim-treesitter'},
    config = function()
      require("ts-node-action").setup {
        ['*'] = {
          ['arguments'] = require('ts-node-action.actions').toggle_multiline(),
        },
      }
      map('n', 'X', require("ts-node-action").node_action, { desc = "Trigger Node Action" })
    end
  },
  {
    'echasnovski/mini.align',
    version = '*',
    config = true
  },
  {
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
        vim.w.minimap_opened = 0
      end
      function close_minimap()
        MiniMap.close()
        vim.w.minimap_opened = 1
      end
      function toggle_minimap()
        MiniMap.toggle()
        if MiniMap.current.win_data[1] then
          vim.w.minimap_opened = 0
        else
          vim.w.minimap_opened = 1
        end
      end
      function on_winenter()
        if vim.w.minimap_opened and MiniMap.current.win_data[1] then
          MiniMap.open()
        else
          MiniMap.close()
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
  },
  {
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
  },
  {
    'knsh14/vim-github-link',
    config = function()
      map('v', '<Leader>YB', '<Cmd>GetCurrentBranchLink<CR>')
      map('v', '<Leader>YC', '<Cmd>GetCurrentCommitLink<CR>')
    end,
  },
  {
    'luochen1990/rainbow',
    config = function()
      vim.g.rainbow_active = 1 -- Toggle with :RainbowToggle
      vim.g.rainbow_conf = {guifgs = {'DeepSkyBlue', 'darkorange3', 'LawnGreen', 'ivory1', 'firebrick', 'MistyRose1', 'maroon1'}}
    end,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
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
              underline = false,
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
          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
          function tel_builtin_fn(fn_name, builtin_opts)
            return function() require('telescope.builtin')[fn_name](builtin_opts) end
          end
          opts = { noremap = true, buffer = bufnr }
          symbols_opts = { fname_width = 50, symbol_width = 50 }
          if is_older_than_nvim_0_10_0 then
            vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next({ wrap = false }) end, ext(opts, { desc="LSP Next diagnostic" }))
            vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev({ wrap = false }) end, ext(opts, { desc="LSP Prev diagnostic" }))
          end
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, ext(opts, { desc="LSP hover" }))
          vim.keymap.set('n', 'gd', tel_builtin_fn('lsp_definitions'), ext(opts, { desc="LSP definitions" }))
          vim.keymap.set('n', '<Leader>lD', peek_definition, ext(opts, { desc="Peek definition" }))
          vim.keymap.set('i', '<C-j>', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<Leader>lr', tel_builtin_fn('lsp_references'), ext(opts, { desc="LSP References" }))
          vim.keymap.set('n', '<Leader>lR', vim.lsp.buf.references, ext(opts, { desc="LSP References QF" }))
          vim.keymap.set('n', '<Leader>li', vim.lsp.buf.implementation, ext(opts, { desc="LSP Implementations" }))
          vim.keymap.set('n', '<Leader>ld', vim.lsp.buf.declaration, ext(opts, { desc="LSP Declarations" }))
          vim.keymap.set('n', '<Leader>lt', vim.lsp.buf.type_definition, ext(opts, { desc="LSP Type Definition" }))
          vim.keymap.set('n', '<Leader>lh', vim.lsp.buf.signature_help, ext(opts, { desc="LSP Signature" }))
          vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<Leader>ln', vim.lsp.buf.rename, ext(opts, { desc="LSP Rename" }))
          vim.keymap.set('n', '<Leader>lI', vim.lsp.buf.incoming_calls, ext(opts, { desc="LSP Incoming calls" }))
          vim.keymap.set('n', '<Leader>lO', vim.lsp.buf.outgoing_calls, ext(opts, { desc="LSP Outgoing calls" }))
          vim.keymap.set('n', '<Leader>lw', tel_builtin_fn('diagnostics'), ext(opts, { desc="LSP Diagnostics" }))
          vim.keymap.set('n', '<Leader>le', vim.diagnostic.open_float, ext(opts, { desc="LSP Show diagnostic" }))
          vim.keymap.set('n', '<Leader>lq', vim.diagnostic.setloclist, ext(opts, { desc="LSP Diagnostics LocList" }))
          vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.format, ext(opts, { desc="LSP Format" }))
          vim.keymap.set('v', '<Leader>lf', vim.lsp.buf.format, ext(opts, { desc="LSP Format" }))
          vim.keymap.set('n', '<Leader>la', vim.lsp.buf.code_action, ext(opts, { desc="LSP Code action menu" }))
          vim.keymap.set('v', '<Leader>la', vim.lsp.buf.code_action, ext(opts, { desc="LSP Code action menu" }))
          vim.keymap.set('n', '<Leader>ly', tel_builtin_fn('lsp_document_symbols', symbols_opts), ext(opts, { desc="LSP Doc symbols" }))
          vim.keymap.set('n', '<Leader>lY', tel_builtin_fn('lsp_dynamic_workspace_symbols', symbols_opts), ext(opts, { desc="LSP Workspace symbols" }))
        end,
      }
      require('lspconfig').clojure_lsp.setup(config)
      require('lspconfig').julials.setup((function()
        local julia_config = vim.deepcopy(config)
        julia_config.capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown' }
        julia_config.capabilities.textDocument.codeAction = {
          dynamicRegistration = true,
          codeActionLiteralSupport = {
            codeActionKind = {
              valueSet = (function()
                local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
                table.sort(res)
                return res
              end)(),
            },
          },
        }
        return julia_config
      end)())
      require('lspconfig').ltex.setup(
        ext(config, {
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
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function()
      -- https://github.com/nvim-treesitter/nvim-treesitter#folding
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true,
          disable = {
            'clojure', -- Breaks string handling: https://github.com/guns/vim-sexp/issues/31
            'julia', -- Breaks julia-vim's matchit integration
          },
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
        ensure_installed = {'bash', 'clojure', 'javascript', 'json', 'julia', 'lua', 'python', 'typescript', 'vimdoc'},
        --additional_vim_regex_highlighting = true, -- Could help with some indent/highlighting issues
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      map('n', '[F', function() require("treesitter-context").go_to_context(vim.v.count1) end, silent)
      vim.cmd [[ highlight! default link TreesitterContext Pmenu ]]
    end
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      chunk = {
        enable = true,
        delay = 100,
        duration = 200,
      },
    },
  },
  'tpope/vim-projectionist',
  {
    'walterl/centerfold',
    dependencies = {'vim-sexp'},
    config = function()
      map('n', '<Leader>jj', 'v<Plug>(sexp_outer_top_list)<Esc><Cmd>CenterFold<CR>', silent)
    end,
  },
  -- cmp
  {'hrsh7th/cmp-nvim-lsp', dependencies = {'hrsh7th/nvim-cmp'}},
  --- snippet support
  {'hrsh7th/cmp-vsnip', dependencies = {'hrsh7th/nvim-cmp'}},
  'hrsh7th/vim-vsnip',
  -- Clojure
  'clojure-vim/clojure.vim',
  {
    'Olical/conjure',
    dependencies = {'Olical/aniseed'},
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
  },
  {'walterl/conjure-efroot', dependencies = {'Olical/conjure'}},
  {'walterl/conjure-macroexpand', dependencies = {'Olical/conjure'}},
  {'walterl/conjure-locstack', dependencies = {'Olical/conjure'}},
  {
    'walterl/conjure-tapdance',
    dependencies = {'Olical/conjure'},
    config = function()
      map('n', '<Leader>jT', '<Cmd>TapForm<CR>', noremap_silent)
      map('n', '<Leader>jt', '<Cmd>TapWord<CR>', noremap_silent)
      map('v', '<Leader>jt', ':TapV<CR>', noremap_silent)
      map('n', '<Leader>jte', '<Cmd>TapExc<CR>', noremap_silent)
    end,
  },
  --- sexp
  {
    'guns/vim-sexp',
    config = function()
      vim.g.sexp_enable_insert_mode_mappings = 0
      vim.g.sexp_filetypes = "clojure,scheme,lisp,timl,fennel,janet"
    end,
  },
  {
    'tpope/vim-sexp-mappings-for-regular-people',
    config = function()
      -- Swap multiple selected elements:
      map('v', '<e', '<Plug>(sexp_swap_element_backward)')
      map('v', '>e', '<Plug>(sexp_swap_element_forward)')
    end,
  },
  -- Fennel
  { 'Olical/aniseed', dependencies = {'bakpakin/fennel.vim'} },
  'bakpakin/fennel.vim',
  -- HTML
  'mattn/emmet-vim',
  -- Terraform
  'hashivim/vim-terraform',
}

local dev_specs = {}

for k, v in pairs(specs) do
  if type(v) == 'string' then
    dev_specs[k] = {v, enabled = dev_mode}
  elseif type(v) == 'table' then
    dev_specs[k] = v
    dev_specs[k].enabled = dev_mode
  else
    print("Unknown spec:", vim.inspect(v))
  end
end

return dev_specs
