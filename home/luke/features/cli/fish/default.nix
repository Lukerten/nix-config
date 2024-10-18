{
  lib,
  config,
  ...
}: {
  programs.fish = {
    enable = true;
    shellAbbrs = let
      hasEza = lib.mkIf config.programs.eza.enable;
    in config.home.shellAliases // {
      ls = hasEza "exa";
      la = hasEza "exa -la";
      ll = hasEza "exa -l";
      lla = hasEza "exa -la";
    };
    functions = {
      fish_greeting = "";
      up-or-search = lib.readFile ./up-or-search.fish;
    };
    interactiveShellInit = lib.readFile ./interactive-init.fish;
  };
}
