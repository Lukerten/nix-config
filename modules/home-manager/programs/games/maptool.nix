{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.maptool;
in {
  options.programs.maptool = {
    enable = mkEnableOption "maptool";

    package = mkOption {
      type = types.package;
      default = pkgs.maptool;
      description = "The maptool package to use.";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
