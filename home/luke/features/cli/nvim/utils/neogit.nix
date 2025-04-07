{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    diffview-nvim
    fzf-lua
    {
      plugin = neogit;
      type = "lua";
      config =
        # lua
        ''
          local neogit = require('neogit')
          neogit.setup {}

          vim.keymap.set("n", "<leader>gn", "<cmd>Neogit<cr>", default_opts("open Neogit"))
        '';
    }
  ];
}
