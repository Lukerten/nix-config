{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.fultimator-desktop;
in {
  options.programs.fultimator-desktop = {
    enable = mkEnableOption "fultimator-desktop";

    package = mkOption {
      type = types.package;
      default = pkgs.fultimator-desktop;
      description = "The fultimator-desktop package to use.";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
