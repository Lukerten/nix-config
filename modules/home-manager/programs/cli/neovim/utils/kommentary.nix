{ pkgs, ... }:
let
  kommentary-nvim = pkgs.vimPlugins.kommentary;

  kommentary-config = # lua
    ''
      require("kommentary.config").configure_language("default", {
        prefer_single_line_comments = true,
        use_consistent_indentation = true,
        ignore_whitespace = true,
      })
    '';
in {
  programs.neovim.plugins = [{
    plugin = kommentary-nvim;
    type = "lua";
    config = kommentary-config;
  }];
}
