{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = blink-cmp;
      type = "lua";
      config =
        # lua
        ''
          opts = {
            keymap = {
              preset = 'default',
              ['<tab>'] = {'select_prev', 'fallback'},
              ['<c-tab>'] = {'select_prev', 'fallback'},
              ['<c-e>'] = {}
              ['<c-space>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
            },
            fuzzy = {
              implementation = 'prefer_rust',
            },
            signature = { enabled = true }
          },

          require("blink.cmp").setup(opts)
        '';
    }
  ];
}
