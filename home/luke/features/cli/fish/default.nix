{
  lib,
  config,
  ...
}: {
  programs.fish = {
    enable = true;
    shellAbbrs = config.home.shellAliases;
    shellAliases = {
      clear = "printf '\\033[2J\\033[3J\\033[1;1H'";
    };
    functions = {
      fish_greeting = "";
      up-or-search = lib.readFile ./up-or-search.fish;
    };
    interactiveShellInit = lib.readFile ./interactive-init.fish;
  };
}

