{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.unity;
  defaultUnity = pkgs.unityhub;
in {
  options.programs.unity = {
    enable = mkEnableOption "unity";

    package = mkOption {
      type = types.package;
      default = defaultUnity;
      description = "The unity package to use.";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
