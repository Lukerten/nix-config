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
          })
        '';
    }
  ];
}
