{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.mGBA;
in {
  options.programs.mGBA = {
    enable = mkEnableOption "mgba";

    package = mkOption {
      type = types.package;
      default = pkgs.mgba;
      description = "The mgba package to use.";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
