{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.element;
in {
  options.programs.element = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Element";
    };
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.element-desktop;
      description = "Element messager package";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
