{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.unity;
  defaultUnity = pkgs.unityhub;
in {
  options.programs.unity = {
    enable = lib.mkEnableOption "unity";

    package = lib.mkOption {
      type = lib.types.package;
      default = defaultUnity;
      description = "The unity package to use.";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
