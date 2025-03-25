{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.fultimator-desktop;
in {
  options.programs.fultimator-desktop = {
    enable = lib.mkEnableOption "fultimator-desktop";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.fultimator-desktop;
      description = "The fultimator-desktop package to use.";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
