{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.dolphin;
in {
  options.programs.dolphin = {
    enable = lib.mkEnableOption "dolphin";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.dolphin-emu;
      description = "The Dolphin package to use.";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
