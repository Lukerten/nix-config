{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.xivLauncher;
in {
  options.programs.xivLauncher = {
    enable = lib.mkEnableOption "xivlauncher";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.xivlauncher;
      description = "The xivlauncher package to use.";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
