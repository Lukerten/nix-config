{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      servers = let
        start-jdt-server = lib.getExe (pkgs.writeShellScriptBin "start-jdt-server" "jdtls -data ./.jdt-data");
      in {
        java_language_server = {
          enable = true;
          cmd = ["${start-jdt-server}"];
          package = pkgs.jdt-language-server;
        };
      };
    };

    # nvim-jdtls.settings = {
    #   enable = true;
    #   java.gradle.enabled = true;
    # };
    luasnip.fromSnipmate = [
      {
        paths = ../../snippets/store/snippets/java.snippets;
        include = ["java"];
      }
    ];
  };
}
