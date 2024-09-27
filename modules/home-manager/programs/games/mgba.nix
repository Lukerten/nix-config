{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.mgba;
in {
  options.programs.mgba = {
    enable = lib.mkEnableOption "mgba";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.mgba;
      description = "The mgba package to use.";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
