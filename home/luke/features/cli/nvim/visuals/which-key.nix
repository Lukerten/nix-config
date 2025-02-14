{pkgs, ...}: {
  programs.neovim.plugins = [
    {
      plugin = pkgs.vimPlugins.which-key-nvim;
      type = "lua";
      config =
        # lua
        ''
          wk = require('which-key')
          wk.setup{
            preset = modern,
            icons = {
              mappings = false,
            },
          }

          wk.add({
            mode = { "n" },
            {"<leader>Gb", "Blame line"}
          })
        '';
    }
  ];
}
