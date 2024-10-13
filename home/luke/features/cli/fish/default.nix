{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.fish = {
    enable = true;
    shellAbbrs = config.home.shellAliases;

    shellAliases = {
      # Clear screen and scrollback
      clear = "printf '\\033[2J\\033[3J\\033[1;1H'";
    };
    functions = {
      fish_greeting = "";
      up-or-search = lib.readFile ./up-or-search.fish;
      _tide_item_jj = lib.readFile ./tide-item-jj.fish;
    };
    plugins = [
      {
        name = "tide";
        src = pkgs.fetchFromGitHub {
          owner = "IlanCosman";
          repo = "tide";
          rev = "44c521ab292f0eb659a9e2e1b6f83f5f0595fcbd";
          hash = "sha256-85iU1QzcZmZYGhK30/ZaKwJNLTsx+j3w6St8bFiQWxc=";
        };
      }
    ];
    interactiveShellInit = lib.readFile ./interactive-init.fish;
  };
}
