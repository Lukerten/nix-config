{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.zoom;
in {
  options.programs.zoom = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable zoom messager";
    };
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.zoom-us;
      description = "zoom messager package";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
