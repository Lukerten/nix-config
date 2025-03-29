{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    otter-nvim
    vim-vsnip
    cmp-buffer
    cmp-nvim-lsp
    cmp_luasnip
    cmp-vsnip
    cmp-path
    cmp-nvim-lsp-signature-help
    cmp-nvim-lsp-document-symbol
    {
      plugin = cmp-git;
      type = "lua";
      config =
        # lua
        ''
          require("cmp_git").setup({})
        '';
    }
    {
      plugin = nvim-cmp;
      type = "lua";
      config =
        #lua
        ''
          -- Setup nvim-cmp.
          local cmp = require'cmp'
          local cmp_window = require "cmp.config.window"
          local cmp_mapping = require "cmp.config.mapping"
          local lspkind = require'lspkind'

          local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
          end

          -- Determine if we should expand snippets
          local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
          end

          -- Line Feed
          local feedkey = function(key, mode)
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
          end

          cmp.setup({

            -- Snippets
            snippet = {
              expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
              end,
            },

            -- Completion
            completion = {
              completeopt = 'menu, menuone, noinsert',
            },

            -- Formatting
            formatting = {
              format = lspkind.cmp_format({
                mode = "symbol_text",
                menu = ({
                  path = '[Path]',
                  nvim_lsp_document_symbol = '[LSP]',
                  nvim_lsp_signature_help = '[LSP]',
                  copilot = "[Copilot]",
                  vsnip = '[VSnip]',
                  buffer = '[Buffer]',
                  crates = '[Crates]',
                  nvim_lua = "[Lua]",
                  latex_symbols = "[Latex]",
                })
              }),
            },

            -- Mapping
            sources = {
              {
                name='nvim_lsp',
              },
              {
                name = 'copilot',
                max_item_count = 1,
              },
              {
                name = 'path'
              },
              {
                name = 'nvim-lsp-signature-help'
              },
              {
                name = 'nvim-document-symbol'
              },
              {
                name = 'vsnip'
              },
              {
                name = 'buffer'
              },
              {
                name = 'crates'
              },
            },

            -- Window
            window = {
              completion = cmp_window.bordered(),
              documentation = cmp_window.bordered(),
            },

            -- Keymap
            mapping = {
              ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
              ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c'}),
              ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c'}),
              ['<C-y>'] = cmp.config.disable,
              ['<C-e>'] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
              }),
              ['<CR>'] = cmp.mapping.confirm({
                select = true,
              }),
              ['<Tab>'] = cmp.mapping(function (fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif vim.fn['vsnip#available'](1) == 1 then
                  feedkey("<Plug>(vsnip-expand-or-jump)", "")
                elseif has_words_before() then
                  cmp.complete()
                else
                  fallback()
                end
              end, { 'i', 's' }),
              ['<S-Tab>'] = cmp.mapping(function (fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif vim.fn['vsnip#available'](-1) == 1 then
                  feedkeys("<Plug>(vsnip-jump-prev)", "")
                end
              end, { 'i', 's' })
            },
          })
        '';
    }
  ];
}
