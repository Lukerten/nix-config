{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.godot;
  defaultPackage = pkgs.godot_4;
in {
  options.programs.godot = {
    enable = mkEnableOption "godot";

    package = mkOption {
      type = types.package;
      default = defaultPackage;
      description = "The godot package to use.";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
