{
  pkgs,
  lib,
  ...
}:
with lib; {
  programs.nixvim = {
    plugins = {
      conform-nvim.settings.formatters_by_ft.typst = ["typstyle"];
      lsp.servers.tinymist.enable = true;
      none-ls.sources.formatting.typstyle.enable = true;

      # Extra Plugin: Typst vim
      typst-vim = {
        enable = true;
        settings = {
          cmd = "${getExe pkgs.typst}";
          conceal_math = 1;
          auto_close_toc = 1;
        };
      };

      # Extra Plugin: Typst preview
      typst-preview = {
        enable = true;
        settings = {
          debug = true;
          port = 8000;
          dependencies_bin = {
            tinymist = "${getExe pkgs.tinymist}";
            websocat = "${getExe pkgs.websocat}";
          };
        };
      };
    };
  };
}
