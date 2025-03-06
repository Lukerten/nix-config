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

  importedLanguages = map (lang: import lang {inherit pkgs lib;}) languages;
  lspConfigs = filter (cfg: cfg != null) (concatMap (lang: lang.lsp) importedLanguages);
  formatterConfigs = filter (cfg: cfg != null) (concatMap (lang: [lang.formatter]) importedLanguages);
  extraPackages = filter (pkg: pkg != null) (concatMap (lang: lang.extraPackages) importedLanguages);
  extraPlugins = filter (plugin: plugin != null) (concatMap (lang: lang.extraPlugins or []) importedLanguages);
in {
  inherit lspConfigs formatterConfigs extraPackages extraPlugins;
}
