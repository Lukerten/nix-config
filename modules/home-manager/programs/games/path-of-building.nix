{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.path-of-building;
in {
  options.programs.path-of-building = {
    enable = mkEnableOption "path-of-building";

    package = mkOption {
      type = types.package;
      default = pkgs.path-of-building;
      description = "The path-of-building package to use.";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
