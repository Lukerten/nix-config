{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.blender;
in {
  options.programs.blender = {
    enable = mkEnableOption "blender";

    package = mkOption {
      type = types.package;
      default = pkgs.blender;
      description = "The Blender package to use.";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
