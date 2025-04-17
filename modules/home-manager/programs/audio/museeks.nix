{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.museeks;
in {
  options.programs.museeks = {
    enable = mkEnableOption "Museeks";

    package = mkOption {
      type = types.package;
      default = pkgs.museeks;
      description = "The Museeks package to use.";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
