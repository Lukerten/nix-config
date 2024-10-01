{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.xivlauncher;
in {
  options.programs.xivlauncher = {
    enable = lib.mkEnableOption "xivlauncher";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.xivlauncher;
      description = "The xivlauncher package to use.";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
