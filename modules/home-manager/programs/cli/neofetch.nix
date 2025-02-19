{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.neofetch;
in {
  options.programs.neofetch = {
    enable = lib.mkEnableOption "neofetch";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.neofetch;
      description = "The neofetch package";
    };

    config = lib.mkOption {
      type = with lib.types; nullOr str;
      default = builtins.readFile ./neofetch.conf;
      description = "The neofetch config to use";
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];
    xdg.configFile."neofetch/config.conf".text = cfg.config;
  };
}
