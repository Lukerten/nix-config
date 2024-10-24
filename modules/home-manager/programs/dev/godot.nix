{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.godot;
  defaultPackage = pkgs.godot_4;
in {
  options.programs.godot = {
    enable = lib.mkEnableOption "godot";

    package = lib.mkOption {
      type = lib.types.package;
      default = defaultPackage;
      description = "The godot package to use.";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
