{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.threema;
in {
  options.programs.threema = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Threema";
    };
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.threema-desktop;
      description = "Threema messager package";
    };
  };
  config = lib.mkIf cfg.enable {home.packages = [cfg.package];};
}
