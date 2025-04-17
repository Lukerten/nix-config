{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.melonDS;
in {
  options.programs.melonDS = {
    enable = mkEnableOption "melonDS";

    package = mkOption {
      type = types.package;
      default = pkgs.melonDS;
      description = "The melonDS package to use.";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
