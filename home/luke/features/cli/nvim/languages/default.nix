{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) concatMap filter;

  # List of language configurations to import
  languages = [
    ./bash.nix
    ./cpp.nix
    ./css.nix
    ./dart.nix
    ./docker.nix
    ./erlang.nix
    ./go.nix
    ./haskell.nix
    ./html.nix
    ./java.nix
    ./javascript.nix
    ./json.nix
    ./kotlin.nix
    ./lua.nix
    ./markdown.nix
    ./nix.nix
    ./php.nix
    ./python.nix
    ./rust.nix
    ./sql.nix
    ./svelte.nix
    ./terraform.nix
    ./yaml.nix
  ];
  l = map (lang: import lang {inherit pkgs lib;}) languages;
  ensureConfig = cfg: cfg.package != null && cfg.config != null;

  lspServers = filter ensureConfig (concatMap (lang: lang.lsp or []) l);
  formatters = filter ensureConfig (concatMap (lang: lang.format or []) l);
  extraPackages = filter (pkg: pkg != null) (concatMap (lang: lang.extraPackages) l);
  extraPlugins = filter (plugin: plugin != null) (concatMap (lang: lang.extraPlugins or []) l);
in {
  inherit lspServers formatters extraPackages extraPlugins;
}
