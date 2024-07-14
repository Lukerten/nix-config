{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [{
    plugin = trouble-nvim;
    type = "lua";
    config = # lua
      ''
        -- Enable trouble diagnostics viewer
        require("trouble").setup()
      '';
  }];
}
