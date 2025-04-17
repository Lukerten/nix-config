{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.zoom;
in {
  options.programs.zoom = {
    enable = mkEnableOption "Enable zoom messager";
    package = mkOption {
      type = types.package;
      default = pkgs.zoom-us;
      description = "zoom messager package";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
