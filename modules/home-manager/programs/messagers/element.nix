{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.element;
in {
  options.programs.element = {
    enable = mkEnableOption "Enable Element";
    package = mkOption {
      type = types.package;
      default = pkgs.element-desktop;
      description = "Element messager package";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
