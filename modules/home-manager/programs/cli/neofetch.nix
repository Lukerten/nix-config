{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.neofetch;
in {
  options.programs.neofetch = {
    enable = mkEnableOption "neofetch";

    package = mkOption {
      type = types.package;
      default = pkgs.neofetch;
      description = "The neofetch package";
    };

    config = mkOption {
      type = with types; nullOr str;
      default = builtins.readFile ./neofetch.conf;
      description = "The neofetch config to use";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [cfg.package];
    xdg.configFile."neofetch/config.conf".text = cfg.config;
  };
}
