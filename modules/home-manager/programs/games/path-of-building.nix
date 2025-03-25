{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.path-of-building;
in {
  options.programs.path-of-building = {
    enable = lib.mkEnableOption "path-of-building";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.path-of-building;
      description = "The path-of-building package to use.";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
