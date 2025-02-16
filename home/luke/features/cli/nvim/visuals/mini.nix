{pkgs, ...}: {
  programs.neovim.plugins = [
    {
      plugin = pkgs.vimPlugins.mini-nvim;
      type = "lua";
      config =
        # lua
        ''
          local map = require('mini.map')
          require('mini.map').setup({
            integrations = {
              map.gen_integration.builtin_search(),
              map.gen_integration.gitsigns(),
              map.gen_integration.diagnostic(),
            },
            symbols = {
              encode = require("mini.map").gen_encode_symbols.dot("4x2"),
            },
            window = {
              focusable = false,
              show_integration_count = false,
            },
          })

          vim.keymap.set("n","<leader>Mc", MiniMap.close, default_opts("close MiniMap"))
          vim.keymap.set("n","<leader>Mf", MiniMap.toggle_focus, default_opts("toggle MiniMap focus"))
          vim.keymap.set("n","<leader>Mt", MiniMap.toggle, default_opts("toggle MiniMap"))
          vim.keymap.set("n","<leader>Mo", MiniMap.open, default_opts("open MiniMap"))
          vim.keymap.set("n","<leader>Mr", MiniMap.refresh, default_opts("refresh MiniMap"))
        '';
    }
  ];
}
