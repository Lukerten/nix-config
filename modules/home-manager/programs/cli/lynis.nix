{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.lynis;
in {
  options.programs.lynis = {
    enable = mkEnableOption "lynis security auditing tool";

    package = mkOption {
      type = types.package;
      default = pkgs.lynis;
      description = "Lynis package to use.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
