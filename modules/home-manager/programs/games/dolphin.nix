{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.dolphin;
in {
  options.programs.dolphin = {
    enable = mkEnableOption "dolphin";

    package = mkOption {
      type = types.package;
      default = pkgs.dolphin-emu;
      description = "The Dolphin package to use.";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
