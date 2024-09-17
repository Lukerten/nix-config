{
  pkgs,
  config,
  ...
}: let
  package = pkgs.vimPlugins.which-key-nvim;
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
        { "<space>a", desc = "Ask Copilot"},
        { "<space>b", desc = "Search"},
        { "<space>c", desc = "Comment Line"},
        { "<space>e", desc = "Open Files"},
        { "<space>f", desc = "Format"},
        { "<space>g", desc = "Grep"},
        { "<space>h", desc = "Home"},
        { "<space>i", desc = "Toggle Inlay Hint", hidden = true },
        { "<space>n", desc = "new File"},
        { "<space>r", desc = "Rename"},
        { "<space>s", desc = "Search Files"},
        { "<space>t", desc = "Open Terminal"},
      })
    '';
in {
  programs.neovim.plugins = [
    {
      plugin = package;
      type = "lua";
      config = config;
    }
  ];
}
