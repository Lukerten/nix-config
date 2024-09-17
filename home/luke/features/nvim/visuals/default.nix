{pkgs, ...}: {
  imports = [
    ./alpha.nix
    ./bufferline.nix
    ./fidget.nix
    ./ibf.nix
    ./noice.nix
    ./nvim-tree.nix
    ./statusline.nix
    ./todo.nix
    ./which-key.nix
  ];
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-colorizer-lua;
      type = "lua";
      config =
        # lua
        ''
          require('colorizer').setup{}
        '';
    }
    {
      plugin = nvim-web-devicons;
      type = "lua";
      config =
        # lua
        ''
          require('nvim-web-devicons').setup{}
        '';
    }
  ];
}
