{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    blink-cmp-copilot
    {
      plugin = blink-cmp;
      type = "lua";
      config =
        # lua
        ''
          require("blink.cmp").setup({
            keymap = {
              preset = 'none',
              ['<Tab>'] = {'snippet_forward','select_next', 'fallback'},
              ['<C-Tab>'] = {'snippet_backward','select_next', 'fallback'},
              ['<C-s>'] = { 'show_signature', 'fallback'},
              ['<C-e>'] = {},
              ['<C-Space>'] = { 'show_documentation', 'fallback'},
              ['<Up>'] = { 'scroll_documentation_up', 'fallback' },
              ['<Down>'] = { 'scroll_documentation_down', 'fallback' },
              ['<CR>'] = { 'accept', 'fallback' },
              ['<C-a>'] = { 'show'},
            },
            completion = {
              list = {
                max_items = 200,
                selection = {
                  preselect = true,
                  auto_insert = true,
                },
                cycle = {
                  from_bottom = true,
                  from_top = true,
                },
              },
              documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
                window = {
                  border = "rounded",
                },
              },
              menu = {
                border = "rounded",
              },
            },

            fuzzy = {
              implementation = 'prefer_rust',
            },

            signature = { enabled = true },

            sources = {
              default = { "lsp", "path", "snippets", "buffer", "copilot" },
              providers = {
                copilot = {
                  name = "copilot",
                  module = "blink-cmp-copilot",
                  score_offset = 100,
                  async = true,
                },
              },
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
