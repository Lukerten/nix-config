{pkgs, ...}: {
  programs.neovim.plugins = [
    {
      plugin = pkgs.vimPlugins.gx-nvim;
      type = "lua";
      config =
        # lua
        ''
          require('gx').setup{}
          vim.keymap.set("v", "<leader>b", ":Browse<cr>", default_opts("Browse Selection"))
        '';
    }
  ];
}
