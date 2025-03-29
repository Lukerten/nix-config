{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = blink-cmp;
      type = "lua";
      config =
        # lua
        ''
          opts = {
            keymap = { preset = 'default' },
            appearance = {
              use_nvim_cmp_as_default = true,
              nerd_font_variant = 'mono'
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
