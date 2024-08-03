{ pkgs, ... }: {
  imports = [
    ./alpha.nix
    ./bufferline.nix
    ./ibf.nix
    ./nvim-tree.nix
    ./statusline.nix
    ./toggleterm.nix
    ./trouble.nix
    ./noice.nix
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
