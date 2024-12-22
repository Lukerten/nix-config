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
        { "<leader>a", desc = "Ask Copilot"},
        { "<leader>e", desc = "Open Files"},
        { "<leader>f", desc = "Format"},
        { "<leader><space>", desc = "Grep"},
        { "<leader>h", desc = "Home"},
        { "<leader>i", desc = "Toggle Inlay Hint", hidden = true },
        { "<leader>n", desc = "new File"},
        { "<leader>r", desc = "Rename"},
        { "<leader>s", desc = "Search Files"},
        { "<leader>t", desc = "Open Terminal"},
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
