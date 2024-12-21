{
  pkgs,
  config,
  lib,
  ...
}: let
  dadbod-package = pkgs.vimPlugins.vim-dadbod;
  dadbod-ui-package = pkgs.vimPlugins.vim-dadbod-ui;
  dadbod-completion-package = pkgs.vimPlugins.vim-dadbod-completion;

  dadbod-config = ''
  '';

  dadbod-ui-config = ''
    vim.g.db_ui_use_nerd_fonts = 1
  '';

  dadbod-completion-config = ''
  '';
in {
  programs.neovim.plugins = [
    {
      plugin = dadbod-package;
      type = "vim";
      config = dadbod-config;
    }
    {
      plugin = dadbod-ui-package;
      type = "vim";
      config = dadbod-ui-config;
    }
    {
      plugin = dadbod-completion-package;
      type = "vim";
      config = dadbod-completion-config;
    }
  ];
}
