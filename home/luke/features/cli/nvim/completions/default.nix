{
  pkgs,
  lib,
  ...
}: let
  nvim-cmp-config =
    #lua
    ''
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end

      local cmp = require'cmp'
      local cmp_window = require "cmp.config.window"
      local cmp_mapping = require "cmp.config.mapping"
      local lspkind = require'lspkind'
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        completion = {
          completeopt = 'menu, menuone, noinsert',
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = ({
              nvim_lsp_document_symbol = '[LSP]',
              nvim_lsp_signature_help = '[LSP]',
              vsnip = '[VSnip]',
              buffer = '[Buffer]',
              crates = '[Crates]',
              path = '[Path]',
              nvim_lua = "[Lua]",
              latex_symbols = "[Latex]",
            })
          }),
        },
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
        sources = {
          {
            name='nvim_lsp',
            entry_filter = function(entry, ctx)
              local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
              if kind == "Snippet" and ctx.prev_context.filetype == "java" then
                return false
              end
              return true
            end,
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
            name = 'copilot',
            max_item_count = 3,
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
        window = {
          completion = cmp_window.bordered(),
          documentation = cmp_window.bordered(),
        },
      })
    '';
in {
  imports = [./copilot.nix ./snippets.nix];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    otter-nvim
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
      config = nvim-cmp-config;
    }
  ];
}

