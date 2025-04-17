{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.xivLauncher;
in {
  options.programs.xivLauncher = {
    enable = mkEnableOption "xivlauncher";

    package = mkOption {
      type = types.package;
      default = pkgs.xivlauncher;
      description = "The xivlauncher package to use.";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
